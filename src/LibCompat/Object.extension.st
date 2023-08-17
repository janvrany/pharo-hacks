Extension { #name : #Object }

{ #category : #'*LibCompat' }
Object >> ? anotherObject [
	^self
]

{ #category : #'*LibCompat' }
Object >> notEmptyOrNil [
	"Return true if receiver is neither `nil` nor an empty collection."
	^ true
]

{ #category : #'*LibCompat' }
Object >> objectAttributeAt: key [
	| attrs |
		
	attrs := self objectAttributes.
	attrs size ~~ 0 ifTrue:[
		^ attrs at: key ifAbsent: nil
	].
	^ nil
]

{ #category : #'*LibCompat' }
Object >> objectAttributeAt: key put: value [
	| attrs |
		
	attrs := self objectAttributes.
	attrs isNil ifTrue:[
		attrs := SmallDictionary new.
		self objectAttributes: attrs.
	].
	attrs at: key put: value
]

{ #category : #'*LibCompat' }
Object >> objectAttributes [
	^self subclassResponsibility 
]

{ #category : #'*LibCompat' }
Object >> objectAttributes: aDictionary [
	^self subclassResponsibility 
]
