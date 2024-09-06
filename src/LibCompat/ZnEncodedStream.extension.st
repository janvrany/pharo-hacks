Extension { #name : #ZnEncodedStream }

{ #category : #'*LibCompat' }
ZnEncodedStream >> isReadable [
	^self subclassResponsibility 
]

{ #category : #'*LibCompat' }
ZnEncodedStream >> isWritable [
	^self subclassResponsibility 
]
