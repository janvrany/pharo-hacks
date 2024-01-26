Class {
	#name : #TestParameterTuple,
	#superclass : #Array,
	#type : #variable,
	#instVars : [
		'parameters'
	],
	#category : #'SUnit-Parametrized'
}

{ #category : #documentation }
TestParameterTuple class >> copyright [
"
COPYRIGHT (c) 2024 LabWare


"

]

{ #category : #'instance creation' }
TestParameterTuple class >> forParameters: parameters [
	^ (self new: parameters size)
		setParameters: parameters;
		yourself.

]

{ #category : #accessing }
TestParameterTuple >> at: indexOrName [
	indexOrName isInteger ifTrue: [
		^ super at: indexOrName
	].
	indexOrName isString ifTrue: [
		parameters withIndexDo: [:parameter :index |
			parameter name = indexOrName ifTrue: [
				^ super at: index.
			].
		].
		self errorKeyNotFound: indexOrName.
	].
	self error: 'Non integer or string index / key'

]

{ #category : #'printing & storing' }
TestParameterTuple >> printOn: aStream [
	aStream nextPut: $[.
	parameters notEmptyOrNil ifTrue: [
		(parameters at: 1) name printOn: aStream.
		aStream nextPut: $:; space.
		(self at: 1) printOn: aStream.
		2 to: parameters size do: [:i |
			aStream nextPut: $,; space.
			(parameters at: i) name printOn: aStream.
			aStream nextPut: $:; space.
			(self at: i) printOn: aStream.
		].
	].
	aStream nextPut: $].

	"Created: / 17-05-2024 / 17:57:21 / Jan Vrany <jan.vrany@labware.com>"

]

{ #category : #initialization }
TestParameterTuple >> setParameters: parametersArg [
	self assert: self size == parametersArg size.

	parameters := parametersArg.

]
