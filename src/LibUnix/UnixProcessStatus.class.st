Class {
	#name : #UnixProcessStatus,
	#superclass : #Object,
	#instVars : [
		'wstatus',
		'pid'
	],
	#category : #'LibUnix-Processes'
}

{ #category : #'instance creation' }
UnixProcessStatus class >> pid: pid wstatus: wstatus [
	^self basicNew pid: pid wstatus: wstatus
	
]

{ #category : #accessing }
UnixProcessStatus >> code [
	"Return the exitcode (if status is #exit) or 
	 signal number (if status is #signal)"
	
	(LibC WIFEXITED: wstatus) ifTrue:[ ^ LibC WEXITSTATUS: wstatus ].
	(LibC WIFSIGNALED: wstatus) ifTrue:[ ^ LibC WTERMSIG: wstatus ].	
	^nil.
	
	
]

{ #category : #accessing }
UnixProcessStatus >> pid [
	^ pid
]

{ #category : #initialization }
UnixProcessStatus >> pid: pidValue wstatus: wstatusValue [
	pid := pidValue.
	wstatus := wstatusValue 
]

{ #category : #printing }
UnixProcessStatus >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: '(pid '.
	pid printOn: aStream.
	aStream nextPutAll: ', '.
	aStream nextPutAll: self status.
	aStream nextPutAll: ' '.
	self code printOn: aStream.
	aStream nextPutAll: ')'.
	
	
]

{ #category : #accessing }
UnixProcessStatus >> status [
	"return status as a Symbol;
   one of #exit #signal #stop #continue"      

	(LibC WIFEXITED: wstatus) ifTrue:[ ^ #exit ].
	(LibC WIFSIGNALED: wstatus) ifTrue:[ ^ #signal ].
	(LibC WIFSTOPPED: wstatus) ifTrue:[ ^ #stop ].
	(LibC WIFCONTINUED: wstatus) ifTrue:[ ^ #continue ].
	
	^nil
]

{ #category : #queries }
UnixProcessStatus >> success [
    "true if process terminated successfully"

    ^ self status == #exit and:[self code = 0]     
]

{ #category : #initialization }
UnixProcessStatus >> wstatus: anInteger [
	wstatus := anInteger
]
