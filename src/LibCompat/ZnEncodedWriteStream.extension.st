Extension { #name : #ZnEncodedWriteStream }

{ #category : #'*LibCompat' }
ZnEncodedWriteStream >> isReadable [
	^false
]

{ #category : #'*LibCompat' }
ZnEncodedWriteStream >> isWritable [
	^true
]

{ #category : #'*LibCompat' }
ZnEncodedWriteStream >> writeStream [
	^self
]
