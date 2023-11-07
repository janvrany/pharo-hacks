Extension { #name : #Number }

{ #category : #'*LibCompat' }
Number >> downTo: stop do: aBlock [ 
	^ self to: stop by: -1 do: aBlock
]
