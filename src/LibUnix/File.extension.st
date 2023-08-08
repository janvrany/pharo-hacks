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
