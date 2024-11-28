Extension { #name : #UnixPlatform }

{ #category : #'*LibUnix' }
UnixPlatform >> primForwardSignal: signalNumber toSemaphore: semaphoreIndex [
	"Set a signal handler in the VM which will signal a Smalltalk semaphore at
	semaphoreIndex whenever an external signal sigNum is received. Answer the
	prior value of the signal handler. If semaphoreIndex is zero, the handler is
	unregistered, and the VM returns to its default behavior for handling that
	signal.

	Use `Smalltalk >> #registerExternalObject:` to register a semaphore:

		sema := Semaphore new.
		index := Smalltalk registerExternalObject: sema.
		Smalltalk os primForwardSignal: 10 toSemaphore: index.

	The Smalltalk semaphore is expected to be kept at the same index location
	indefinitely during the lifetime of a Squeak session. If that is not the case, the
	handler must be unregistered prior to unregistering the Smalltalk semaphore.
	"

	<primitive: 'primitiveForwardSignalToSemaphore' module: 'UnixOSProcessPlugin'>
	^ nil

]

{ #category : #'*LibUnix' }
UnixPlatform >> primSemaIndexFor: sigNum [
	"Answer the registration index of the semaphore currently associated with the
	signal handler for sigNum."

	<primitive: 'primitiveSemaIndexFor' module: 'UnixOSProcessPlugin'>
	^ nil

]

{ #category : #'*LibUnix' }
UnixPlatform >> spawn: argv stdin: stdin stdout: stdout stderr: stderr exit: action [ 
	| pidptr argvptr actionsptr stdinFD stdoutFD stderrFD errno pid |
	
	pidptr := FFIInt32 newBuffer.
	
	argvptr := FFIExternalArray externalNewType: 'char*' size: argv size + 1.
	1 to: argv size do:[:i |
		argvptr at: i put: (ExternalAddress fromString: (argv at: i)).		
	].
	argvptr at: argv size + 1 put: (ExternalAddress fromAddress: 0).
	
	stdinFD := stdin notNil ifTrue:[stdin fileDescriptor] ifFalse:[0].
	stdoutFD := stdout notNil ifTrue:[stdout fileDescriptor] ifFalse:[1].
	stderrFD := stderr notNil ifTrue:[stderr fileDescriptor] ifFalse:[1].	
	
	actionsptr := Posix_spawn_file_actions_t new.
	LibC posix_spawn_file_actions_init: actionsptr.
	stdinFD ~~ 0 ifTrue:[
		LibC posix_spawn_file_actions_adddup2: actionsptr _: stdinFD  _: 0.
	].
	stdoutFD ~~ 1 ifTrue:[
		LibC posix_spawn_file_actions_adddup2: actionsptr _: stdoutFD _: 1.
	].
	stderrFD ~~ 2 ifTrue:[
		LibC posix_spawn_file_actions_adddup2: actionsptr _: stderrFD _: 2.
	].
	
	errno := LibC posix_spawn: pidptr _: argv first _: actionsptr getHandle _: nil _: argvptr getHandle _: self environment environ getHandle.
	errno ~~ 0 ifTrue:[
		self error:'posix_spawn() has failed'.
		^nil.
	].

	pid := pidptr integerAt: 1 size: 4 signed: true.
	IOSelector current reap: pid with: action.
	^ pid

	
	
	

]
