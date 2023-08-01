Extension { #name : #AbstractFileReference }

{ #category : #'*LibCompat' }
AbstractFileReference >> asFilename [
	^ self asFileReference
]

{ #category : #'*LibCompat' }
AbstractFileReference >> baseName [
	^ self basename
]

{ #category : #'*LibCompat' }
AbstractFileReference >> directory [
	^ self parent
]
