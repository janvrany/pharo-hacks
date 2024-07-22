Extension { #name : #ZnCharacterReadStream }

{ #category : #'*LibCompat' }
ZnCharacterReadStream >> skipSeparators [
	[self atEnd not and:[self peek isSeparator]] whileTrue:[
		self next.
	]
]
