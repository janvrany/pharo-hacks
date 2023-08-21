Extension { #name : #Integer }

{ #category : #'*LibCompat' }
Integer >> printLeftPaddedWith: aCharacter to: anInteger base: aRadix [ 
	^ self printPaddedWith: aCharacter to: anInteger base: aRadix 

]

{ #category : #'*LibCompat' }
Integer >> printOn:stream paddedWith: padding to: size base: radix [
	| rem numDigits |
	
	rem := self abs.
	numDigits := 1.
	[ rem := rem // radix. rem > 0 ] whileTrue:[numDigits := numDigits + 1].

	numDigits < size ifTrue:[		
		stream next: size - numDigits put: padding.
	].
	self printOn: stream base: radix showRadix: false.
	
	"
	String streamContents:[:s| 1 printOn: s paddedWith: $_ to: 4 base: 10]
	"


]
