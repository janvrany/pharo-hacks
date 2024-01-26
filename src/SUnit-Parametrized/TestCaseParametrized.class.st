Class {
	#name : #TestCaseParametrized,
	#superclass : #TestCase,
	#instVars : [
		'testParameters'
	],
	#category : #'SUnit-Parametrized'
}

{ #category : #'building suites' }
TestCaseParametrized class >> addToSuite: suite fromMethods: testMethods [ 
	testMethods do: [ :selector | 
			(self selector: selector) addToSuite: suite ].
	^suite
]

{ #category : #'building suites' }
TestCaseParametrized class >> buildSuiteFromMethods: testMethods [

	^testMethods
		inject: (self suiteClass named: self name asString)
		into: [:suite :selector |
			(self selector: selector) addToSuite: suite.
			suite]
]

{ #category : #queries }
TestCaseParametrized class >> isAbstract [
        "Override to true if a TestCase subclass is Abstract and should not have
        TestCase instances built from it"

        ^self == TestCaseParametrized

]

{ #category : #'instance creation' }
TestCaseParametrized class >> selector: selector [
	^super selector: selector.
]

{ #category : #'instance creation' }
TestCaseParametrized class >> selector: selector parameters: parameters [
    ^ self new 
        setTestSelector: selector;
        setTestParameters: parameters;
        yourself

]

{ #category : #private }
TestCaseParametrized >> addToSuite: aTestSuite [
    testParameters notNil ifTrue: [
        super addToSuite: aTestSuite
    ] ifFalse: [
        self parametersIterator do: [:parameters |
            (self class selector: testSelector parameters: parameters) addToSuite: aTestSuite
        ].
    ].
]

{ #category : #copying }
TestCaseParametrized >> copyForRun [
    ^ self class selector: testSelector parameters: testParameters

    "Created: / 29-01-2024 / 14:55:45 / Jan Vrany <jan.vrany@labware.com>"

]

{ #category : #running }
TestCaseParametrized >> debug [
	| suite result |
	suite := self classForTestSuite new.	
	result := self classForTestResult new.
	self addToSuite: suite.
	[ suite tests do:[:each | result runCaseForDebug: each ] ]
		ensure: [ self classForTestResource resetResources: self resources.
			result updateResultsInHistory  ].
	^ result
]

{ #category : #'parameter creation' }
TestCaseParametrized >> parameter: name values: values [
    "Create and return a test parameter named `name` with `values`"

    self assert: name isString
         description: 'Invalid parameter spec: non-string parameter name'.

    values isSymbol ifTrue: [
        self assert: values numArgs = 0
             description: 'Invalid parameter spec: values selector is not unary: ' , values.
        self assert: (self respondsTo: values)
             description: 'Invalid parameter spec: values selector not understood: ' , values.
        ^ TestParameter name: name values: (self perform: values)
    ].

    values isSequenceable ifTrue: [
        ^ TestParameter name: name values: values
    ].

    self assert: false
         description: 'Invalid parameter spec: values neither selector nor array of values'.
]

{ #category : #private }
TestCaseParametrized >> instanceVariablesToKeep [
	^ #('testSelector' 'testParameters')
]

{ #category : #accessing }
TestCaseParametrized >> parameters [
    ^ testParameters

]

{ #category : #accessing }
TestCaseParametrized >> parametersIterator [
    "
     Return an iterator (undestanding #do:) over parameter tuples to
     run the test with.

     By default, parameter definitions are taken from annotations
     (pragmas) in test method.

     Subclasses may override this method to define testcase-wide
     parameters. Recommended way to do so is:

     parametersIterator
        ^ super parametersIterator
            , (self parameter: #testcaseWide1 values: #('a' 'b'))
            , (self parameter: #testcaseWide2 values: #(true false))

     Calling super ensures that:
        (i) all testcase-wide parameter definitions specified in superclass
            are also used.
       (ii) all test-specific parameter definitions specified by test method
            are used as well.
    ."

    | method  methodParameters  strategy |

    method := self class >> testSelector.
    methodParameters := method pragmas
            select: [:pragma | #( #parameter:values: ) includes: pragma key ].
    methodParameters := methodParameters
            collect: [:pragma | pragma message sendTo: self ].
     "TODO: maybe add support for multiple strategies"
    strategy := TestParameterMatrix.
    ^ strategy forParameters: methodParameters.

    "
     (ParametrizedTestExamples selector: #test_04) parametersIterator"

    "Created: / 17-05-2024 / 16:02:15 / Jan Vrany <jan.vrany@labware.com>"
    "Modified (comment): / 19-05-2024 / 10:52:57 / Jan Vrany <jan.vrany@labware.com>"

]

{ #category : #private }
TestCaseParametrized >> performTest [
    self assert: testParameters notNil
         description: 'Test parameters have not been instantiated'.

    super performTest    
]

{ #category : #printing }
TestCaseParametrized >> printOn: aStream [
    super printOn: aStream.
    testParameters isNil ifTrue: [ 
        aStream nextPutAll: ' (uninstantiated)'
    ] ifFalse: [ 
        testParameters notEmpty ifTrue: [ 
            aStream space.
            testParameters printOn: aStream.
        ].
    ].


]

{ #category : #running }
TestCaseParametrized >> run [
	"Execute the receiver and return a test result."
		| suite result |
	suite := self classForTestSuite new.	
	result := self classForTestResult new.
	self addToSuite: suite.
	[ suite tests do:[:each | result runCase: each ] ]
		ensure: [ self classForTestResource resetResources: self resources ].
	^ result
]

{ #category : #accessing }
TestCaseParametrized >> selectorInBrowser [
    "Answer the selector string to use in various tools
     (test runners)"

    testParameters isNil ifTrue: [ 
        ^ self selector , ' {uninstantiated}'
    ].

    ^ String streamContents: [ :s |
        s nextPutAll: self selector.
        testParameters notEmpty ifTrue: [ 
            s nextPutAll: ' {'.
            testParameters do: [:each | each storeOn: s ] separatedBy: [ s nextPutAll:', ' ].
            s nextPutAll: '}'.
        ].
    ]

]

{ #category : #private }
TestCaseParametrized >> setTestParameters: anArray [
    testParameters := anArray.

]
