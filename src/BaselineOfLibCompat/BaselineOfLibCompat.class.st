Class {
	#name : #BaselineOfLibCompat,
	#superclass : #BaselineOf,
	#category : #BaselineOfLibCompat
}

{ #category : #baselines }
BaselineOfLibCompat >> baseline: spec [
	<baseline>
	spec
		for: #pharo
		do: [
			spec package:#'LibCompat'.
		]

]
