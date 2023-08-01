Class {
	#name : #IOSelector,
	#superclass : #Object,
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
