"
This class is simple drop-in replacement for `OSProcess` from Squeak, 
Cuis and Smalltalk/X based on OSSubprocess package. 

Caveat: only APIs used in Tinyrossa are implemented.
"
Class {
	#name : #OSProcess,
	#superclass : #Object,
	#instVars : [
		'command',
		'pid',
		'status'
	],
	#category : #LibCompat
}

{ #category : #'external command processing' }
OSProcess class >> command: aString [
	"Run a command in a shell process. Similar to the system(3) call in the standard C library,
	 except that aString runs asynchronously in a child process."
	
	^self new command: aString
]

{ #category : #accesing }
OSProcess >> command: aString [
	command := aString
	
]

{ #category : #initialization }
OSProcess >> initialize [
	(Smalltalk globals includesKey: #OSSUnixSubprocess) ifTrue:[
		self error: 'OSSubProcess package loaded. OSSubProcess is incompatbile with LibCompat''s OSProcess implementation.'
	].
]

{ #category : #testing }
OSProcess >> isComplete [ 
	^status notNil
]

{ #category : #testing }
OSProcess >> isRunning [ 
	^status isNil.
]

{ #category : #running }
OSProcess >> startProcess [
	pid := Smalltalk os spawn: {'/bin/sh' . '-c' . command} stdin: Stdio stdin stdout: Stdio stdout stderr: Stdio stderr exit: [ :sts | status := sts. ].
]

{ #category : #'terminating child' }
OSProcess >> terminate [
	pid isNil ifTrue:[
		self error: 'Process not (yet) running'.
		^ self.
	].
	status notNil ifTrue:[
		self error: 'Process already terminated'.
	].
	LibC kill: pid _: 15"SIGTERM"
	
]
