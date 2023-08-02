Extension { #name : #UnixPlatform }

{ #category : #'*LibUnix' }
UnixPlatform >> spawn: argv stdin: stdin stdout: stdout stderr: stderr exit: action [ 
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
	IOSelector current reap: pid with: action.
	^ pid

	
	
	

]
