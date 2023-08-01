Class {
	#name : #BinaryPipeStream,
	#superclass : #AbstractBinaryFileStream,
	#instVars : [
		'descriptor',
		'peekBuffer',
		'hanged'
	],
	#pools : [
		'UnixConstants'
	],
	#category : #'LibUnix-I/O'
}

{ #category : #'as yet unclassified' }
BinaryPipeStream class >> create [
	"Create new pipe and return a 2-element array
	 where first element is read-end and second
	 is write-end"
	
	| fds |
	
	fds := FFIArray externalNewType: 'int' size: 2.
	LibC pipe: fds getHandle.
	
	^{ self basicNew descriptor: (fds at:1) writable: false.
	   self basicNew descriptor: (fds at:2) writable: true    }
]

{ #category : #queries }
BinaryPipeStream >> atEnd [
	self closed ifTrue:[ ^ true ].
	hanged ifTrue:[
		| available |
		
		available := FFIInt32 newBuffer.
		LibC ioctl: descriptor _: FIONREAD _: available.
		available = #[0 0 0 0] ifTrue:[
			^ true.
		].
	].
	^ false
	
]

{ #category : #queries }
BinaryPipeStream >> available [
	"Return number of bytes available for reading
	 (bytes already written by the other size)"
	
	| available |
		
	available := FFIInt32 newBuffer.
	LibC ioctl: descriptor _: FIONREAD _: available.
	^available unsignedLongAt: 1
	
]

{ #category : #'open/close' }
BinaryPipeStream >> close [
	| h |
	
	h := handle.
	h notNil ifTrue:[
		handle := descriptor := nil.		
		File close: h.	
		self unregister.
	].
]

{ #category : #queries }
BinaryPipeStream >> closed [
	^handle isNil
]

{ #category : #initialization }
BinaryPipeStream >> descriptor: fd writable: writable [
	| stdioPtr |

	descriptor := fd.
	forWrite := writable.
	file := File named: '#' , descriptor printString.	
	handle := File connectToFileDescriptor: descriptor writable: writable.
	hanged := false.
	writable ifFalse:[
		self setNonBlocking.
		self	setNonBuffered.
	].
	self	register.		
			

	
	
	

]

{ #category : #accessing }
BinaryPipeStream >> fileDescriptor [
	^ descriptor
]

{ #category : #finalization }
BinaryPipeStream >> finalize [

	^ self close
]

{ #category : #initialization }
BinaryPipeStream >> handle: aCollection file: aFile forWrite: aBoolean [
	self shouldNotImplement 
]

{ #category : #accessing }
BinaryPipeStream >> next: n into: aBuffer [
	^self next: n into: aBuffer startingAt: 1
]

{ #category : #reading }
BinaryPipeStream >> peek [
	"Answer the next element of the stream, but do not advance the stream pointer. 
	If the receiver is at the end, answer nil."

	self atEnd ifTrue: [ ^ nil ].
	peekBuffer ifNotNil: [ ^ peekBuffer ].
	^ peekBuffer := self next
]

{ #category : #positioning }
BinaryPipeStream >> position [
	^self shouldNotImplement 
]

{ #category : #positioning }
BinaryPipeStream >> position: position [
	^self shouldNotImplement 
]

{ #category : #reading }
BinaryPipeStream >> readInto: readBuffer startingAt: startIndex count: count [
	| readOffset readCount |
	
	readOffset := startIndex.
	readCount  := count. 
	
	(readCount > 0 and:[peekBuffer notNil]) ifTrue:[ 
		readBuffer at: readOffset put: peekBuffer.
		readOffset := readOffset + 1.
		readCount := readCount - 1. 
	].
	
	(readCount > 0) ifTrue:[
		self readWait.
	].	
	
	"For some reason, FilePlugin has an issue reading from PTY 
	 master / slave streams. Therefore, use read() syscall directly.
	 The underlaying stdio stream is set to non-buffered mode anyway."	
	readOffset == 1 ifTrue:[
		"Read directly to the readBuffer"
		| read |
		
		read := LibC read: descriptor _: readBuffer _: readCount.
		read < 0 ifTrue:[
			self error: 'read() failed'.
			^ 0.
		].
		^ read
	] ifFalse:[
		self halt:'should implement'.
		^0
	]
		


]

{ #category : #reading }
BinaryPipeStream >> readWait [
	"Block calling thread until data are ready."

	self closed ifTrue:[ 
		self error: 'Stream closed'.
		^self.
	].
	hanged := IOSelector current readWait: descriptor. 
]

{ #category : #finalization }
BinaryPipeStream >> register [

	File register: self
]

{ #category : #finalization }
BinaryPipeStream >> unregister [

	File unregister: self
]
