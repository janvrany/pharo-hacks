Class {
	#name : #TestParameterMatrix,
	#superclass : #TestAsserter,
	#instVars : [
		'parameters'
	],
	#category : #'SUnit-Parametrized'
}

{ #category : #documentation }
TestParameterMatrix class >> copyright [
"
COPYRIGHT (c) 2024 LabWare


"

]

{ #category : #'instance creation' }
TestParameterMatrix class >> forParameters: arg [
	"Create & return a new instance for arg."

	^ self basicNew initializeWithParameters: arg

]

{ #category : #adding }
TestParameterMatrix >> , parameterOrMatrix [
	^ TestParameterMatrix forParameters: (self parameters , parameterOrMatrix parameters)

	"Modified (format): / 18-05-2024 / 21:28:10 / Jan Vrany <jan.vrany@labware.com>"

]

{ #category : #enumerating }
TestParameterMatrix >> do: aBlock [
	self from: 1 to: parameters size combineInto: (TestParameterTuple forParameters: parameters) thenDo: aBlock

	"Modified (format): / 18-05-2024 / 21:27:46 / Jan Vrany <jan.vrany@labware.com>"

]

{ #category : #private }
TestParameterMatrix >> from: start to: stop combineInto: tuple thenDo: block [
	start > stop ifTrue: [
		block value: tuple copy.
	] ifFalse: [
		(parameters at: start) values do: [:each |
			tuple at: start put: each.
			self from: start + 1 to: stop combineInto: tuple thenDo: block
		].
	].

	"Created: / 16-05-2024 / 13:57:57 / Jan Vrany <jan.vrany@labware.com>"

]

{ #category : #initialization }
TestParameterMatrix >> initializeWithParameters: parametersArg [
	self assert: parametersArg isSequenceable.

	parameters := parametersArg

]

{ #category : #testing }
TestParameterMatrix >> isEmpty [
	^ self size == 0

	"Created: / 16-05-2024 / 17:58:26 / Jan Vrany <jan.vrany@labware.com>"

]

{ #category : #testing }
TestParameterMatrix >> isEmptyOrNil [
	^ self isEmpty

	"Created: / 16-05-2024 / 17:58:33 / Jan Vrany <jan.vrany@labware.com>"

]

{ #category : #accessing }
TestParameterMatrix >> parameters [
	^ parameters

]

{ #category : #queries }
TestParameterMatrix >> size [
	^ parameters inject: 1 into: [ :sizeSoFar :parameter | sizeSoFar * parameter values size ].

	"Created: / 16-05-2024 / 17:55:26 / Jan Vrany <jan.vrany@labware.com>"

]
