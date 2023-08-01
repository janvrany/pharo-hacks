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
			spec postLoadDoIt: #postLoad.
		]

]

{ #category : #actions }
BaselineOfLibCompat >> postLoad [
	Smalltalk at: #OperatingSystem put: Smalltalk os.
	
	"
	BaselineOfLibCompat new postLoad
	"
]
