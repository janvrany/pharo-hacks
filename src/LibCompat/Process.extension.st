Extension { #name : #Process }

{ #category : #'*LibCompat' }
Process >> isDead [
	^self isTerminated 
]
