Extension { #name : #ZnEncodedStream }

{ #category : #'*LibCompat' }
ZnEncodedStream >> fileName [
	"Return filename of underlaying stream or nil, if not
	 reading from/writing to a file"

	^stream fileName
]

{ #category : #'*LibCompat' }
ZnEncodedStream >> isReadable [
	^self subclassResponsibility 
]

{ #category : #'*LibCompat' }
ZnEncodedStream >> isWritable [
	^self subclassResponsibility 
]
