Extension { #name : #Dictionary }

{ #category : #'*LibCompat' }
Dictionary >> elementAt: key ifAbsent: aBlock [
	^ (array at: (self findElementOrNil: key))
		ifNil: [ aBlock value ]
		ifNotNil: [ :assoc | assoc key ]

]
