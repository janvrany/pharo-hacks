Extension { #name : #Class }

{ #category : #'*LibCompat' }
Class >> classVarAt: classVarName [
	"Return the value of a class variable named `classVarName`.
    Returns nil if there is no such class variable."

	^self classPool at: classVarName ifAbsent:[nil].
]

{ #category : #'*LibCompat' }
Class >> classVarAt: classVarName put: value [
	self classPool at: classVarName put: value
]
