Extension { #name : #String }

{ #category : #'*LibCompat' }
String >> asFilename [
	^ self asFileReference 
]
