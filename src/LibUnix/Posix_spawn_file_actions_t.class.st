Class {
	#name : #'Posix_spawn_file_actions_t',
	#superclass : #FFIStructure,
	#classVars : [
		'IsLinux'
	],
	#category : #'LibUnix-Processes'
}

{ #category : #'field definition' }
Posix_spawn_file_actions_t class >> byteSize [
	IsLinux ifTrue:[
		"FIXME: this number is emprical value I've got on 
		 my amd64 linux system. This demonstrates the fundamental
		problem of nearly all FFI implementations."
		^ 80
	].

	self error: '(Yet) unsupported system'

]

{ #category : #initialization }
Posix_spawn_file_actions_t class >> initialize [
	IsLinux := Smalltalk os version beginsWith: 'linux'
]
