Extension { #name : #ZnBufferedReadStream }

{ #category : #'*LibCompat' }
ZnBufferedReadStream >> fileName [
	"Return filename of underlaying stream or nil, if not
	 reading from/writing toa file"

	^stream fileName
]
