Extension { #name : #ZnEncodedReadStream }

{ #category : #'*LibCompat' }
ZnEncodedReadStream >> isReadable [
	^true
]

{ #category : #'*LibCompat' }
ZnEncodedReadStream >> isWritable [
	^false
]

{ #category : #'*LibCompat' }
ZnEncodedReadStream >> readStream [
	^self
]
