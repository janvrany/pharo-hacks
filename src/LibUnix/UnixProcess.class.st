Class {
	#name : #UnixProcess,
	#superclass : #Object,
	#classVars : [
		'ReapActions',
		'Reaper'
	],
	#category : #'LibUnix-Processes'
}

{ #category : #reaping }
UnixProcess class >> reap: pid with: action [
	"Arrange for reaping of Unix process with given pid.
	 Evaluate `action` once the process terminates". 
	
	ReapActions isNil ifTrue:[
		ReapActions := Dictionary new.
	].

	ReapActions at: pid put: action.
	
	Reaper isNil ifTrue:[
		Reaper := [ 
			[
				[ ReapActions notNil and:[ ReapActions notEmpty ] ] whileTrue:[
					self reapOne.
				].
			] ensure: [ 
				Reaper := nil.
			]
		] newProcess.
		Reaper name: 'LibUnix process reaper'.
		Reaper priority: Processor userBackgroundPriority.
		Reaper resume.
	].
	
	
	
]

{ #category : #reaping }
UnixProcess class >> reapOne [
	"Wait for any process to be reaped and reap it, then return."
	
	"Implementation note: Here we simply poll. A better would be to wait
	 for SIGCHLD but that interferes with OSSUnixSubprocess' reaper.
	
	 Really, this functionality should be in Pharo instead of letting
	 everyone to roll its own implementation. How comes nobody sees that?"
	
	| wstatusPtr |
	
	wstatusPtr := FFIInt32 newBuffer.

	[
		ReapActions isEmpty ifTrue:[ ^self ].	
						
		ReapActions copy keysAndValuesDo: [ :pid :action |
			| pidIfExited |
		
			pidIfExited := LibC waitpid: pid _: wstatusPtr _: 1"<- WNOHANG".
			pidIfExited ~~ 0 ifTrue:[
				| status |
				
				status := UnixProcessStatus pid: pid wstatus: (wstatusPtr unsignedLongAt: 1).
				ReapActions removeKey: pid.
				action cull: status.
				^self.
			].
		].
	
		(Delay forMilliseconds: 100) wait.10
	] repeat
]

{ #category : #spawning }
UnixProcess class >> spawn: argv stdin: stdin stdout: stdout stderr: stderr exit: action [ 
	| pidptr argvptr actionsptr errno pid |
	
	pidptr := FFIInt32 newBuffer.
	
	argvptr := FFIExternalArray externalNewType: 'char*' size: argv size + 1.
	1 to: argv size do:[:i |
		argvptr at: i put: (ExternalAddress fromString: (argv at: i)).		
	].
	argvptr at: argv size + 1 put: (ExternalAddress fromAddress: 0).
	
	actionsptr := Posix_spawn_file_actions_t new.
	LibC posix_spawn_file_actions_init: actionsptr.
	stdin notNil ifTrue:[
		LibC posix_spawn_file_actions_adddup2: actionsptr _: stdin fileDescriptor  _: 0.
	].
	stdout notNil ifTrue:[
		LibC posix_spawn_file_actions_adddup2: actionsptr _: stdout fileDescriptor _: 1.
	].
	stderr notNil ifTrue:[
		LibC posix_spawn_file_actions_adddup2: actionsptr _: stderr fileDescriptor _: 2.
	].
	
	errno := LibC posix_spawn: pidptr _: argv first _: actionsptr getHandle _: nil _: argvptr getHandle _: nil.
	errno ~~ 0 ifTrue:[
		self error:'posix_spawn() has failed'.
		^nil.
	].

	pid := pidptr integerAt: 1 size: 4 signed: true.
	self reap: pid with: action.
	^ pid

	
	
	

]
