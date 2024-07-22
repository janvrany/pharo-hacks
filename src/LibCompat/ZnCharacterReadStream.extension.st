Extension { #name : #ZnCharacterReadStream }

{ #category : #'*LibCompat' }
ZnCharacterReadStream >> nextChunk [
	"Answer the contents of the receiver, up to the next terminator character. Doubled terminators indicate an embedded terminator character."

	| terminator out ch |
	terminator := $!.
	out := (String new: 1000) writeStream.
	self skipSeparators.
	[ (ch := self next) isNil ]
		whileFalse: [
			ch == terminator
				ifTrue: [
					self peek == terminator
						ifTrue: [ self next	"skip doubled terminator" ]
						ifFalse: [ ^ out contents	"terminator is not doubled; we're done!" ] ].
			out nextPut: ch ].
	^ out contents
]

{ #category : #'*LibCompat' }
ZnCharacterReadStream >> skipSeparators [
	[self atEnd not and:[self peek isSeparator]] whileTrue:[
		self next.
	]
]
