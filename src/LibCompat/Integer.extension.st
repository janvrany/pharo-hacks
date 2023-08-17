Extension { #name : #Integer }

{ #category : #'*LibCompat' }
Integer >> printLeftPaddedWith: aCharacter to: anInteger base: aRadix [ 
	^ self printPaddedWith: aCharacter to: anInteger base: aRadix 

]
