Extension { #name : #Semaphore }

{ #category : #'*LibCompat' }
Semaphore >> waitWithTimeoutMs: timeout [
	"Wait on this semaphore for up to the given number of milliseconds, then timeout. 
	Return `nil` if the deadline expired, receiver otherwise."

	timeout isNil ifTrue:[
		self wait.
		^self
	] ifFalse:[
		(self waitTimeoutMSecs: timeout) ifTrue:[nil] ifFalse:[self].
	]
]
