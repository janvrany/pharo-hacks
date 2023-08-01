Class {
	#name : #SQFile,
	#superclass : #FFIStructure,
	#classVars : [
		'OFFSET_FILE',
		'OFFSET_ISSTDIOSTREAM',
		'OFFSET_LASTCHAR',
		'OFFSET_LASTOP',
		'OFFSET_SESSIONID',
		'OFFSET_WRITABLE'
	],
	#category : #'LibUnix-I/O'
}

{ #category : #'field definitions' }
SQFile class >> fieldsDesc [	
	"See extracted/plugins/FilePlugin/include/common/FilePlugin.h"
	
	^#(
	  int      sessionID
	  void*		file
"Note, ACORN is not Unix..."
"
#if defined(ACORN)
// ACORN has to have 'lastOp' as at least a 32 bit field in order to work
  int lastOp; // actually used to save file position
  char writable;
  char lastChar;
  char isStdioStream;
#else
"
		char                   writable
		char                   lastOp
		char                   lastChar
		char                   isStdioStream	
	)
	
	"
	self rebuildFieldAccessors
	"
]

{ #category : #'accessing structure variables' }
SQFile >> file [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_FILE) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
SQFile >> file: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_FILE put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
SQFile >> isStdioStream [
	"This method was automatically generated"
	^handle unsignedCharAt: OFFSET_ISSTDIOSTREAM
]

{ #category : #'accessing structure variables' }
SQFile >> isStdioStream: anObject [
	"This method was automatically generated"
	handle unsignedCharAt: OFFSET_ISSTDIOSTREAM put: anObject
]

{ #category : #'accessing structure variables' }
SQFile >> lastChar [
	"This method was automatically generated"
	^handle unsignedCharAt: OFFSET_LASTCHAR
]

{ #category : #'accessing structure variables' }
SQFile >> lastChar: anObject [
	"This method was automatically generated"
	handle unsignedCharAt: OFFSET_LASTCHAR put: anObject
]

{ #category : #'accessing structure variables' }
SQFile >> lastOp [
	"This method was automatically generated"
	^handle unsignedCharAt: OFFSET_LASTOP
]

{ #category : #'accessing structure variables' }
SQFile >> lastOp: anObject [
	"This method was automatically generated"
	handle unsignedCharAt: OFFSET_LASTOP put: anObject
]

{ #category : #'accessing structure variables' }
SQFile >> sessionID [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_SESSIONID
]

{ #category : #'accessing structure variables' }
SQFile >> sessionID: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_SESSIONID put: anObject
]

{ #category : #'accessing structure variables' }
SQFile >> writable [
	"This method was automatically generated"
	^handle unsignedCharAt: OFFSET_WRITABLE
]

{ #category : #'accessing structure variables' }
SQFile >> writable: anObject [
	"This method was automatically generated"
	handle unsignedCharAt: OFFSET_WRITABLE put: anObject
]
