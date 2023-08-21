Extension { #name : #AbstractFileReference }

{ #category : #'*LibCompat' }
AbstractFileReference >> asFilename [
	^ self asFileReference
]

{ #category : #'*LibCompat' }
AbstractFileReference >> asString [
	^self pathString
]

{ #category : #'*LibCompat' }
AbstractFileReference >> baseName [
	^ self basename
]

{ #category : #'*LibCompat' }
AbstractFileReference >> directory [
	^ self parent
]

{ #category : #'*LibCompat' }
AbstractFileReference >> pathName [
	^ self pathString
]
