Class {
	#name : #ParametrizedTestExamples,
	#superclass : #TestCaseParametrized,
	#category : #'SUnit-Parametrized-Examples'
}

{ #category : #documentation }
ParametrizedTestExamples class >> copyright [
"
COPYRIGHT (c) 2024 LabWare


"

]

{ #category : #'parameter values' }
ParametrizedTestExamples >> floatValues [
	^ { Float nan . -1.0 . -0.01 . -0.0 . 0.0 . 0.01 . 1.0 . Float fmax . Float infinity }

	"Created: / 17-05-2024 / 17:18:19 / Jan Vrany <jan.vrany@labware.com>"

]

{ #category : #accessing }
ParametrizedTestExamples >> parametersIterator [
	"Following is simple hack to make testcase-wide parameter available
	 only for test_05. Normally one would (only) write it along the lines
	 of code below next line."
	testSelector ~~ #test_05 ifTrue: [ ^ super parametersIterator ].

	^ super parametersIterator
		, (self parameter: #y values: #(100))

	"Modified: / 18-05-2024 / 00:18:00 / Jan Vrany <jan.vrany@labware.com>"

]

{ #category : #tests }
ParametrizedTestExamples >> test_01 [
	"This is a simple test with no parameters.

	 Old non-parametrized tests works just fine. This is
	 handy when migrating existing tests to parametrized
	 ones."

	self assert: testParameters isEmpty

	"Created: / 01-05-2024 / 14:03:12 / Jan Vrany <jan.vrany@labware.com>"
	"Modified: / 01-05-2024 / 17:01:55 / Jan Vrany <jan.vrany@labware.com>"
	"Modified (comment): / 17-05-2024 / 23:14:41 / Jan Vrany <jan.vrany@labware.com>"

]

{ #category : #tests }
ParametrizedTestExamples >> test_02 [
	"A simple parametrized test taking one parameter named #val.

	 A parameter has its name and set of values and (here) it is
	 specified using an annotation (pragma):
	"
	<parameter: #val values: #(1 2 3)>
	"
	 Inside the test, you may access parameters by
	 name via `testParameters` instance variable.
	"
	self assert: ((testParameters at:#val) between: 1 and: 3)

	"Created: / 01-05-2024 / 14:13:49 / Jan Vrany <jan.vrany@labware.com>"
	"Modified (format): / 18-05-2024 / 22:07:25 / Jan Vrany <jan.vrany@labware.com>"

]

{ #category : #tests }
ParametrizedTestExamples >> test_03 [
	"A simple parametrized test taking two integer parameters.

	 It is possible to have as many parameters as one wants.
	 The test is then run for every combination: in this
	 case, this test is run 9 times with combinations

		 a: 1, b: 1
		 a: 1, b: 2
		 a: 1, b: 3
		 ...
		 a: 3, b: 3
	"
	<parameter: #a values: #(1 2 3)>
	<parameter: #b values: #(1 2 3)>

	| a b |

	a := testParameters at:#a.
	b := testParameters at:#b.

	self assert: (a + b) < 7

	"Created: / 17-05-2024 / 16:52:56 / Jan Vrany <jan.vrany@labware.com>"
	"Modified (format): / 18-05-2024 / 22:07:30 / Jan Vrany <jan.vrany@labware.com>"

]

{ #category : #tests }
ParametrizedTestExamples >> test_04 [
	"A parametrized test taking one Float parameter with values
	 specified by method.

	 Sometimes it may be useful to specify values in separate method -
	 for example because values cannot be expressed a literals or
	 one wants to read values from file or allow customization in
	 subclasses or any other reason.

	 To do that, simple use selector in parameter specification,
	 rather than (literal) list of values. This selector is then
	 sent to the test (self) to obtain actual values.
	"
	<parameter: #val values: #floatValues>


	self assert: (testParameters at: #val) isFloat

	"Created: / 17-05-2024 / 17:18:57 / Jan Vrany <jan.vrany@labware.com>"
	"Modified (format): / 18-05-2024 / 22:07:37 / Jan Vrany <jan.vrany@labware.com>"

]

{ #category : #tests }
ParametrizedTestExamples >> test_05 [
	"A parametrized test using testcase-wide parameters

	 By default, test parameters (if any) are specified by
	 the test itself (by annotation). However in some cases
	 one wants to specify parameters for all tests in a
	 testcase. To do so, simply override #parametersIterator
	 in the testcase, like:

		 parametersIterator
			^ super parametersIterator
				, (self parameter: #testcaseWide1 values: #('a' 'b'))
				, (self parameter: #testcaseWide2 values: #(true false))

	 It is a good idea to use  'super parametersIterator' as in
	 above code - this way, each test can specify its own, test-specific
	 parameters too!
	"
	<parameter: #x values: #(10 20 30)>

	self assert: (testParameters at: #x) < (testParameters at: #y)

	"Created: / 17-05-2024 / 23:34:20 / Jan Vrany <jan.vrany@labware.com>"
	"Modified (format): / 18-05-2024 / 22:07:42 / Jan Vrany <jan.vrany@labware.com>"

]
