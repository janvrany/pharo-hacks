Extension { #name : #FileReference }

{ #category : #'*LibCompat' }
FileReference >> directory [
	^ self parent
]

{ #category : #'*LibCompat' }
FileReference >> isFilename [
	^true
]

{ #category : #'*LibCompat' }
FileReference class >> separator [
	Smalltalk os isWindows ifTrue:[ ^$\ ].
	
	^$/
]
