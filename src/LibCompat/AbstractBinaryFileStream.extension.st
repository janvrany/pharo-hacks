Extension { #name : #AbstractBinaryFileStream }

{ #category : #'*LibCompat' }
AbstractBinaryFileStream >> fileName [
	"Return filename this stream reads from/writes to."

	^self file name asFilename
]

{ #category : #'*LibCompat' }
AbstractBinaryFileStream >> readStream [
	^ self
]

{ #category : #'*LibCompat' }
AbstractBinaryFileStream >> writeStream [
	^ self
]
