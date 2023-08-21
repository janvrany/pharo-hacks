Extension { #name : #Stream }

{ #category : #'*LibCompat' }
Stream >> nextPutAll: aCollection startingAt: startIndex to: stopIndex [
	| count |
	
	count := stopIndex - startIndex + 1.
	^self next: count putAll: aCollection startingAt: startIndex.
]

{ #category : #'*LibCompat' }
Stream >> nextPutLine: aCollection [ 
	self nextPutAll: aCollection.
	self cr. 
]
