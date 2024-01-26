Extension { #name : #CompiledMethod }

{ #category : #'*SUnit-Parametrized' }
CompiledMethod >> isTestMethod [
	self methodClass isTestCase
		ifFalse: [ ^ false ].	
	^self methodClass testSelectors includes: self selector
]
