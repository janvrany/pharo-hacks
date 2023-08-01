Class {
	#name : #BaselineOfLibUnix,
	#superclass : #BaselineOf,
	#category : #BaselineOfLibUnix
}

{ #category : #baselines }
BaselineOfLibUnix >> baseline: spec [
	<baseline>
	spec
		for: #pharo
		do: [
			spec package:#'LibUnix'.
		]

]
