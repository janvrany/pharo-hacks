Extension { #name : #UndefinedObject }

{ #category : #'*LibCompat' }
UndefinedObject >> ? anotherObject [
	^ anotherObject
]

{ #category : #'*LibCompat' }
UndefinedObject >> notEmptyOrNil [
	"Return true if receiver is neither `nil` nor an empty collection."
	^ false

]

{ #category : #'*LibCompat' }
UndefinedObject >> size [
	^ 0
]
