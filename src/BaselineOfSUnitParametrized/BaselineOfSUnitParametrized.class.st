Class {
	#name : #BaselineOfSUnitParametrized,
	#superclass : #BaselineOf,
	#category : #BaselineOfSUnitParametrized
}

{ #category : #baselines }
BaselineOfSUnitParametrized >> baseline: spec [
	<baseline>
	spec
		for: #pharo
		do: [
			spec package:#'SUnit-Parametrized'.
		]

]
