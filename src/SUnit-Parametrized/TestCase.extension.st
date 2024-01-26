Extension { #name : #TestCase }

{ #category : #'*SUnit-Parametrized' }
TestCase >> addToSuite: aTestSuite [
    aTestSuite addTest: self

]
