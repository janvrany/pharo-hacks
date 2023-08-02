Class {
	#name : #IOSelector,
	#superclass : #Object,
	#instVars : [
		'reaper',
		'reapActions'
	],
	#classVars : [
		'Current'
	],
	#pools : [
		'UnixConstants'
	],
	#category : #'LibUnix-I/O'
}

{ #category : #accessing }
IOSelector class >> current [
	Current isNil ifTrue:[
		Current := self new.
	].
	^ Current
	
	"
	POSIXSelector current
	"
]

{ #category : #waiting }
IOSelector >> readWait: fd [
	"Block calling process until there are data available
	 on given file descriptor. Return true if the other side
	 closed the connection (pipe's write end), false otherwise."
	
	"Implementation note: following is good, old and idiotic
	 polling. 
	
	 Much better solution would be to arrange a smalltalk process
	 to wait on SIGIO. Upon SIGIO poll() all registred descriptors
	 and signal read semaphores of those that are ready. This is left
	 as future work.
	 	
	 Really, this is something Pharo should provide out-of-the-box!"
	
	| pollfd |
	
	pollfd := Pollfd new.
	pollfd fd: fd.
	pollfd events: POLLIN.
	
	[ 
		| revents |
		
		LibC poll: pollfd getHandle _: 1 _: 0.
		revents := pollfd revents.
		
		(revents & POLLHUP) ~~ 0 ifTrue:[
			^ true
		].
			
		(revents & POLLERR) ~~ 0 ifTrue:[
			self error: 'Error condition occured'.
			^ true.
		].
	
		(revents & POLLNVAL) ~~ 0 ifTrue:[
			self error: 'Not open!'
		].
	
		(revents & POLLIN) ~~ 0 ifTrue:[
			^ false.		
		].
		
	
		(Delay forMilliseconds: 100) wait.	
	] repeat.
	
	
]

{ #category : #reaping }
IOSelector >> reap: pid with: action [
	"Arrange for reaping of Unix process with given pid.
	 Evaluate `action` once the process terminates". 
	
	reapActions isNil ifTrue:[
		reapActions := Dictionary new.
	].

	reapActions at: pid put: action.
	
	reaper isNil ifTrue:[
		reaper := [ 
			[
				[ reapActions notNil and:[ reapActions notEmpty ] ] whileTrue:[
					self reapOne.
				].
			] ensure: [ 
				reaper := nil.
			]
		] newProcess.
		reaper name: 'LibUnix process reaper'.
		reaper priority: Processor userBackgroundPriority.
		reaper resume.
	].
	
	
	
]

{ #category : #reaping }
IOSelector >> reapOne [
	"Wait for any process to be reaped and reap it, then return."
	
	"Implementation note: Here we simply poll. A better would be to wait
	 for SIGCHLD but that interferes with OSSUnixSubprocess' reaper.
	
	 Really, this functionality should be in Pharo instead of letting
	 everyone to roll its own implementation. How comes nobody sees that?"
	
	| wstatusPtr |
	
	wstatusPtr := FFIInt32 newBuffer.

	[
		reapActions isEmpty ifTrue:[ ^self ].	
						
		reapActions copy keysAndValuesDo: [ :pid :action |
			| pidIfExited |
		
			pidIfExited := LibC waitpid: pid _: wstatusPtr _: 1"<- WNOHANG".
			pidIfExited ~~ 0 ifTrue:[
				| status |
				
				status := UnixProcessStatus pid: pid wstatus: (wstatusPtr unsignedLongAt: 1).
				reapActions removeKey: pid.
				action cull: status.
				^self.
			].
		].
	
		(Delay forMilliseconds: 100) wait.10
	] repeat
]
