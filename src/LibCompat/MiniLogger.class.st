Class {
	#name : #MiniLogger,
	#superclass : #Object,
	#classVars : [
		'AnyLoggerActive'
	],
	#category : #LibCompat
}

{ #category : #initialization }
MiniLogger class >> initialize [
	(Smalltalk globals includesKey: #Logger) ifFalse:[
		Smalltalk globals at: #Logger put: self
	].
	AnyLoggerActive := nil.

	"
	MiniLogger initialize 
	"
]

{ #category : #logging }
MiniLogger class >> log: message severity: severity facility: facility [		
	AnyLoggerActive isNil ifTrue:[
		AnyLoggerActive := SignalLogger allSubInstances anySatisfy: #isRunning.
		AnyLoggerActive ifFalse:[		
			TranscriptLogger start.
			AnyLoggerActive := true.
		].
	].	
	StringSignal emit: message         
]

{ #category : #'logging - utils' }
MiniLogger class >> trace: fmt with: arg1 [
	^self log: (fmt bindWith: arg1) severity: #trace facility: nil.
]

{ #category : #'logging - utils' }
MiniLogger class >> trace: fmt with: arg1 with: arg2 [
	^self log: (fmt bindWith: arg1 with: arg2) severity: #trace facility: nil.
]
