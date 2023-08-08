Extension { #name : #AbstractBinaryFileStream }

{ #category : #'*LibUnix' }
AbstractBinaryFileStream >> fileDescriptor [
	handle notNil ifTrue:[
		^ File fileDescriptor: handle.
	].
	self error:'Stream closed or never opened'.
]

{ #category : #'*LibUnix' }
AbstractBinaryFileStream >> setLocalEcho: onOrOff [
	| fd termios ec |
	
	fd := self fileDescriptor.
	termios := Termios new.
	
	ec := LibC tcgetattr: fd _: termios getHandle.
	ec == -1 ifTrue:[
		self error: 'tcgetattr() failed!'.
		^self.
	].
	onOrOff ifTrue:[ 
		termios c_lflag: (termios c_lflag bitOr: UnixConstants ECHO)
	] ifFalse:[ 
		termios c_lflag: (termios c_lflag bitClear: UnixConstants ECHO)
	].

	ec := LibC tcsetattr: fd _: UnixConstants TCSANOW _: termios getHandle.
	ec == -1 ifTrue:[
		self error: 'tcgetattr() failed!'.
		^self.
	].                             

	
]

{ #category : #'*LibUnix' }
AbstractBinaryFileStream >> setNonBlocking [ 
	File setNonBlocking: handle
]

{ #category : #'*LibUnix' }
AbstractBinaryFileStream >> setNonBuffered [
	File setNonBuffered: handle
]

{ #category : #'*LibUnix' }
AbstractBinaryFileStream >> setOutputCRLF: onOrOff [ 
	| fd termios ec |
	
	fd := self fileDescriptor.
	termios := Termios new.
	
	ec := LibC tcgetattr: fd _: termios getHandle.
	ec == -1 ifTrue:[
		self error: 'tcgetattr() failed!'.
		^self.
	].
	onOrOff ifTrue:[ 
		termios c_oflag: (termios c_oflag bitOr: UnixConstants ONLCR)
	] ifFalse:[ 
		termios c_oflag: (termios c_oflag bitClear: UnixConstants ONLCR)
	].

	ec := LibC tcsetattr: fd _: UnixConstants TCSANOW _: termios getHandle.
	ec == -1 ifTrue:[
		self error: 'tcgetattr() failed!'.
		^self.
	].                             

	
]
