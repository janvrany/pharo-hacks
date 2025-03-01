Extension { #name : #ZnBufferedWriteStream }

{ #category : #'*LibCompat' }
ZnBufferedWriteStream >> fileName [
	"Return filename of underlaying stream or nil, if not
	 reading from/writing toa file"

	^stream fileName
]
