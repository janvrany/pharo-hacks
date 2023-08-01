Class {
	#name : #Pollfd,
	#superclass : #FFIStructure,
	#classVars : [
		'OFFSET_EVENTS',
		'OFFSET_FD',
		'OFFSET_REVENTS'
	],
	#category : #'LibUnix-I/O'
}

{ #category : #'field description' }
Pollfd class >> fieldsDesc [	
	"See poll()"
	
	^#(
	  int   fd
	 	short events
		short revents
	)
	
	"
	self rebuildFieldAccessors
	"
]

{ #category : #'accessing structure variables' }
Pollfd >> events [
	"This method was automatically generated"
	^handle signedShortAt: OFFSET_EVENTS
]

{ #category : #'accessing structure variables' }
Pollfd >> events: anObject [
	"This method was automatically generated"
	handle signedShortAt: OFFSET_EVENTS put: anObject
]

{ #category : #'accessing structure variables' }
Pollfd >> fd [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_FD
]

{ #category : #'accessing structure variables' }
Pollfd >> fd: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_FD put: anObject
]

{ #category : #'accessing structure variables' }
Pollfd >> revents [
	"This method was automatically generated"
	^handle signedShortAt: OFFSET_REVENTS
]

{ #category : #'accessing structure variables' }
Pollfd >> revents: anObject [
	"This method was automatically generated"
	handle signedShortAt: OFFSET_REVENTS put: anObject
]
