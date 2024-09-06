Extension { #name : #ReadStream }

{ #category : #'*LibCompat' }
ReadStream >> isReadable [
	^true
]

{ #category : #'*LibCompat' }
ReadStream >> isWritable [
	^false
]
