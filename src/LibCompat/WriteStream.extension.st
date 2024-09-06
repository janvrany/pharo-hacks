Extension { #name : #WriteStream }

{ #category : #'*LibCompat' }
WriteStream >> isReadable [
	^false
]

{ #category : #'*LibCompat' }
WriteStream >> isWritable [
	^true
]
