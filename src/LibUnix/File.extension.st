Extension { #name : #File }

{ #category : #'*LibUnix' }
File class >> feof: id [	
	| filePtr |
	
	filePtr := (SQFile fromHandle: id) file.
	^ LibC feof: filePtr
]

{ #category : #'*LibUnix' }
File class >> fileDescriptor: id [
	"Given a SQFile* handle, return underlying file descriptor"

	<primitive: 'primitiveUnixFileNumber' module: 'UnixOSProcessPlugin'>
	^ self primitiveFailed
]

{ #category : #'*LibUnix' }
File class >> setLocalEcho: handle to: onOrOff [
	| fd termios ec |
	
	fd := self fileDescriptor: handle.
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
File class >> setNonBlocking: id [
	"Given a SQFile* handle, set it to non-blocking mode"

	<primitive: 'primitiveSQFileSetNonBlocking' module: 'UnixOSProcessPlugin'>
	^ self primitiveFailed
]

{ #category : #'*LibUnix' }
File class >> setNonBuffered: id [
	"Given a SQFile* handle, set it to non-buffered mode. See setbuf()."
	
	| filePtr |
	
	filePtr := (SQFile fromHandle: id) file.
	LibC setbuf: filePtr _: ExternalAddress null.
]

{ #category : #'*LibUnix' }
File class >> setOutputCRLF: handle to: onOrOff [
	| fd termios ec |
	
	fd := self fileDescriptor: handle.
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
