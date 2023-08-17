Extension { #name : #OSPlatform }

{ #category : #'*LibCompat' }
OSPlatform >> getEnvironment: value [
	^self environment at: value ifAbsent:[nil]
]

{ #category : #'*LibCompat' }
OSPlatform >> pathOfCommand: command [
	self subclassResponsibility 
]

{ #category : #'*LibCompat' }
OSPlatform >> setEnvironment: name to: value [
	self environment at: name put: value
]
