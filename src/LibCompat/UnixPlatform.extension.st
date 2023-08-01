Extension { #name : #UnixPlatform }

{ #category : #'*LibCompat' }
UnixPlatform >> pathOfCommand: command [
	| path |
	
	path := $: split: (self environment at: 'PATH').
	path do:[ :dir |
		| exe |
		
		exe := dir asFileReference / command.
		(exe exists and:[exe isExecutable]) ifTrue:[
			^ exe pathString.
		]
	].
	^nil.
	
	"
	OperatingSystem pathOfCommand:'gcc'
	OperatingSystem pathOfCommand:'gdb'
	OperatingSystem pathOfCommand:'bogus'
	"
]
