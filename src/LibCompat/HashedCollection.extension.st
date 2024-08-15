Extension { #name : #HashedCollection }

{ #category : #'*LibCompat' }
HashedCollection >> elementAt: key [
	^ self elementAt: key ifAbsent: [self errorKeyNotFound: key]
]

{ #category : #'*LibCompat' }
HashedCollection >> elementAt: key ifAbsent: aBlock [
	^ (array at: (self findElementOrNil: key))
		ifNil: [ aBlock value ]
		ifNotNil: [ :keyHere | keyHere ]
]
