Extension { #name : #Exception }

{ #category : #'*LibCompat' }
Exception class >> newException [
	^ self new
]

{ #category : #'*LibCompat' }
Exception >> parameter [
	^self tag
]

{ #category : #'*LibCompat' }
Exception >> parameter: anObject [
	self tag: anObject 
]

{ #category : #'*LibCompat' }
Exception >> raise [
	^self signal
]

{ #category : #'*LibCompat' }
Exception class >> raiseErrorString: aString [
	^self signal: aString
]
