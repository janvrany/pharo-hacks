Extension { #name : #Collection }

{ #category : #'*LibCompat' }
Collection >> notEmptyOrNil [
	"Return true if receiver is neither `nil` nor an empty collection."
	^ self notEmpty

]
