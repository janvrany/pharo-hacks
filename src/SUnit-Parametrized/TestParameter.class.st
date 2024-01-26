Class {
	#name : #TestParameter,
	#superclass : #TestAsserter,
	#instVars : [
		'name',
		'values'
	],
	#category : #'SUnit-Parametrized'
}

{ #category : #documentation }
TestParameter class >> copyright [
"
COPYRIGHT (c) 2024 LabWare


"

]

{ #category : #'instance creation' }
TestParameter class >> name: name values: values [
	^ self basicNew initializeWithName: name values: values

]

{ #category : #adding }
TestParameter >> , parameterOrMatrix [
	^ TestParameterMatrix forParameters: (self parameters , parameterOrMatrix parameters)

	"Modified (format): / 18-05-2024 / 21:28:05 / Jan Vrany <jan.vrany@labware.com>"

]

{ #category : #initialization }
TestParameter >> initializeWithName: nameArg values: valuesArg [
	self assert: nameArg isString.
	self assert: valuesArg isSequenceable.

	name := nameArg.
	values := valuesArg.

]

{ #category : #accessing }
TestParameter >> name [
	^ name

]

{ #category : #accessing }
TestParameter >> parameters [
	^ Array with: self

]

{ #category : #accessing }
TestParameter >> values [
	^ values

]
