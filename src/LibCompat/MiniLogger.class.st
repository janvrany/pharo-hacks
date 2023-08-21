Class {
	#name : #MiniLogger,
	#superclass : #Object,
	#category : #LibCompat
}

{ #category : #initialization }
MiniLogger class >> initialize [
	(Smalltalk globals includesKey: #Logger) ifFalse:[
		Smalltalk globals at: #Logger put: self
	].

	"
	MiniLogger initialize 
	"
]

{ #category : #logging }
MiniLogger class >> log: message severity: severity facility: facility [
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
