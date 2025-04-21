Extension { #name : #ArrayedCollection }

{ #category : #'*LibCompat' }
ArrayedCollection class >> with: firstObject with: secondObject with: thirdObject with: fourthObject with: fifthObject with: sixthObject with: seventhObject [
	"Answer a new instance of me, containing only the 7 arguments as elements."

	| newCollection |
	newCollection := self new: 7.
	newCollection at: 1 put: firstObject.
	newCollection at: 2 put: secondObject.
	newCollection at: 3 put: thirdObject.
	newCollection at: 4 put: fourthObject.
	newCollection at: 5 put: fifthObject.
	newCollection at: 6 put: sixthObject.
	newCollection at: 7 put: seventhObject.
	^ newCollection
]

{ #category : #'*LibCompat' }
ArrayedCollection class >> with: firstObject with: secondObject with: thirdObject with: fourthObject with: fifthObject with: sixthObject with: seventhObject with: eighthObject [
	"Answer a new instance of me, containing only the 8 arguments as elements."

	| newCollection |
	newCollection := self new: 8.
	newCollection at: 1 put: firstObject.
	newCollection at: 2 put: secondObject.
	newCollection at: 3 put: thirdObject.
	newCollection at: 4 put: fourthObject.
	newCollection at: 5 put: fifthObject.
	newCollection at: 6 put: sixthObject.
	newCollection at: 7 put: seventhObject.
	newCollection at: 8 put: eighthObject.
	
	^ newCollection
]
