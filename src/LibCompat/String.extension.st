Extension { #name : #String }

{ #category : #'*LibCompat' }
String >> asFilename [
	^ self asFileReference 
]

{ #category : #'*LibCompat' }
String >> bindWith: a1 [
	^self bindWithArguments: { a1 }
]

{ #category : #'*LibCompat' }
String >> bindWith: a1 with: a2 [
	^self bindWithArguments: { a1 . a2 }
]

{ #category : #'*LibCompat' }
String >> bindWith: a1 with: a2 with: a3 [
	^self bindWithArguments: { a1 . a2 . a3 }
]

{ #category : #'*LibCompat' }
String >> bindWith: a1 with: a2 with: a3 with: a4 [
	^self bindWithArguments: { a1 . a2 . a3 . a4 }
]

{ #category : #'*LibCompat' }
String >> bindWithArguments: values [
	| output i percent |
	
	output := (String new: self size) writeStream.
	i := 1.
	[	(percent := self indexOf: $% startingAt: i) ~~ 0 ] whileTrue:[
		| c indexOrName |
		
		output nextPutAll: self startingAt: i to: percent - 1.		
		percent < self size ifTrue:[
			i := percent + 1.
			c := self at: i.
			c == $% ifTrue:[
				output nextPut: $%.
				i := i + 1.
			] ifFalse:[			
				| arg |
				
				[c notNil and:[c isDigit]] whileTrue:[
					indexOrName isNil ifTrue:[
						indexOrName := c digitValue.
					] ifFalse:[
						indexOrName := (indexOrName * 10) + c digitValue.
					].
					i < self size ifTrue:[						
						i := i + 1.
						c := self at: i. 
					] ifFalse:[
						i := i + 1.
						c := nil
					].					
				].
				indexOrName isNil ifTrue:[
					self error:'Invalid wildcard at ', percent printString , ': % must be followed by number'			
				].
				arg := values at: indexOrName ifAbsent:[self error: 'Invalid wildcard at ', percent printString , ': value not found'].
				output nextPutAll: arg displayString.		
			]
		]		
	].
	output nextPutAll: self startingAt: i to: self size.
	^output contents.
	
	"
	'%1 %2!' bindWith: 'Hello' with: 'World' 
	"
	
]
