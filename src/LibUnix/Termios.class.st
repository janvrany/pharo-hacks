Class {
	#name : #Termios,
	#superclass : #FFIStructure,
	#classVars : [
		'OFFSET_C_CFLAG',
		'OFFSET_C_IFLAG',
		'OFFSET_C_LFLAG',
		'OFFSET_C_OFLAG',
		'cc_t',
		'speed_t',
		'tcflag_t'
	],
	#category : #'LibUnix-I/O'
}

{ #category : #'field definition' }
Termios class >> byteSize [
	(Smalltalk os version beginsWith: 'linux') ifTrue:[
		^68 "60 + 8 bytes safe area"
	].

	self error:'Unsupported Unix system'.
	^nil
]

{ #category : #'field description' }
Termios class >> fieldsDesc [	
	(Smalltalk os version beginsWith: 'linux') ifTrue:[
		^self fieldsDescForLinux.
	].

	self error:'Unsupported Unix system'.
	^nil
	
	
]

{ #category : #'field description' }
Termios class >> fieldsDescForLinux [
	"See bits/termios.h
			bits/termios-struct.h				
	"			
	tcflag_t := "unsigned "'int'.
	cc_t := "unsigned "'int'.
	speed_t := "unsigned "'char'.
		
	^ #(
			tcflag_t c_iflag           "/* input mode flags */"
			tcflag_t c_oflag           "/* output mode flags */"
			tcflag_t c_cflag           "/* control mode flags */"
			tcflag_t c_lflag           "/* local mode flags */"
			"cc_t c_line"                "/* line discipline */"
			"cc_t c_cc[32]"              "/* control characters */"
			"speed_t c_ispeed"           "/* input speed */"
			"speed_t c_ospeed"           "/* output speed */"
	)
	
	"
	self rebuildFieldAccessors
	"
	
]

{ #category : #'accessing structure variables' }
Termios >> c_cflag [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_C_CFLAG
]

{ #category : #'accessing structure variables' }
Termios >> c_cflag: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_C_CFLAG put: anObject
]

{ #category : #'accessing structure variables' }
Termios >> c_iflag [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_C_IFLAG
]

{ #category : #'accessing structure variables' }
Termios >> c_iflag: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_C_IFLAG put: anObject
]

{ #category : #'accessing structure variables' }
Termios >> c_lflag [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_C_LFLAG
]

{ #category : #'accessing structure variables' }
Termios >> c_lflag: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_C_LFLAG put: anObject
]

{ #category : #'accessing structure variables' }
Termios >> c_oflag [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_C_OFLAG
]

{ #category : #'accessing structure variables' }
Termios >> c_oflag: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_C_OFLAG put: anObject
]
