Extension { #name : #LibC }

{ #category : #'*LibUnix' }
LibC class >> WEXITSTATUS: wstatus [
	"Returns the exit status of the child.  This consists 
	 of the least significant 8 bits of the status argument 
	 that the child specified in a call to exit(3) or _exit(2) 
	 or as the argument for a return statement in main().  
	 This macro should be employed only if WIFEXITED returned true."
	
	^(wstatus & 16rFF00) >> 8
]

{ #category : #'*LibUnix' }
LibC class >> WIFCONTINUED: wstatus [
	"Returns true if the child process was resumed 
	 by delivery of SIGCONT."
	
	^wstatus == 16rFFFF	

]

{ #category : #'*LibUnix' }
LibC class >> WIFEXITED: wstatus [
	"Returns true if the child terminated normally, that is, 
	 by calling exit(3) or _exit(2), or by returning from main()."
	
	^(self WTERMSIG: wstatus) == 0
	
	
]

{ #category : #'*LibUnix' }
LibC class >> WIFSIGNALED: wstatus [
	"Returns true if the child process was terminated by a signal."
	
	^ ((((wstatus) & 16r7f) + 1) >> 1) > 0
	
]

{ #category : #'*LibUnix' }
LibC class >> WIFSTOPPED: wstatus [
	"Returns true if the child process was stopped by 
	 delivery of a signal; this is possible only if the 
	 call was done using WUNTRACED or when the child is 
	 being traced (see ptrace(2))."
	
	^(((wstatus) & 16rff) == 16r7f)
]

{ #category : #'*LibUnix' }
LibC class >> WTERMSIG: wstatus [
	"Returns the number of the  signal that caused 
	 the child process to terminate.  This macro should
	 be employed only if WIFSIGNALED returned true."
	
	^wstatus & 16r7F
]

{ #category : #'*LibUnix' }
LibC class >> close: fd [
	^ self ffiCall: #(int close(int fd)) module: LibC
]

{ #category : #'*LibUnix' }
LibC class >> feof: stream [
	^ self ffiCall: #( int feof( void* stream ) ) module: LibC  
]

{ #category : #'*LibUnix' }
LibC class >> grantpt: fd [
	^ self ffiCall: #(int grantpt(int fd)) module: LibC
]

{ #category : #'*LibUnix' }
LibC class >> ioctl: fd _: request _: param [
	^ self ffiCall:#( int ioctl(int fd, long request, void* param) )  module: LibC  
]

{ #category : #'*LibUnix' }
LibC class >> kill: pid _: sig [
	^ self ffiCall:#(int kill(int pid, int sig))  module: LibC
	
]

{ #category : #'*LibUnix' }
LibC class >> open: pathname _: flags [
	^ self ffiCall: #(int open(char* pathname, int flags)) module: LibC
]

{ #category : #'*LibUnix' }
LibC class >> pipe: pipefd [
	^ self ffiCall:#( int pipe(void* pipefd))  module: LibC
]

{ #category : #'*LibUnix' }
LibC class >> poll: fds _: nfds _: timeout [
	^ self ffiCall:#(  int poll(void* fds, long nfds, int timeout) )  module: LibC
]

{ #category : #'*LibUnix' }
LibC class >> posix_openpt: flags [
	^ self ffiCall:#( int posix_openpt(int flags)) module: LibC  
]

{ #category : #'*LibUnix' }
LibC class >> posix_spawn: pid _: path _: file_actions _: attrp _: argv _: envp [
	^ self ffiCall:#( int posix_spawnp(int* pid, char* path, 
										void* file_actions, void* attrp,
          						char* argv[],
                       char* envp[]) )  module: LibC  
]

{ #category : #'*LibUnix' }
LibC class >> posix_spawn_file_actions_adddup2: file_actions _: fildes _: newfildes [
	^ self ffiCall:#( int posix_spawn_file_actions_adddup2(#Posix_spawn_file_actions_t *
file_actions, int fildes, int newfildes)) module: LibC  
]

{ #category : #'*LibUnix' }
LibC class >> posix_spawn_file_actions_destroy: file_actions [
	^ self ffiCall:#( int posix_spawn_file_actions_destroy(#Posix_spawn_file_actions_t *
file_actions)) module: LibC  
]

{ #category : #'*LibUnix' }
LibC class >> posix_spawn_file_actions_init: file_actions [
	^ self ffiCall:#( int posix_spawn_file_actions_init(#Posix_spawn_file_actions_t *
file_actions)) module: LibC  
]

{ #category : #'*LibUnix' }
LibC class >> posix_spawnp: pid _: file _: file_actions _: attrp _: argv _: envp [
	^ self ffiCall:#( int posix_spawnp(int* pid, char* file, 
										void* file_actions, void* attrp,
          						char* argv[],
                       char* envp[]) )  module: LibC  
]

{ #category : #'*LibUnix' }
LibC class >> ptsname: fd [
	^ self ffiCall: #(char* ptsname(int fd)) module: LibC
]

{ #category : #'*LibUnix' }
LibC class >> read: fd _: buf _: count [
	^ self ffiCall: #(int read(int fd, void* buf, int count)) module: LibC
]

{ #category : #'*LibUnix' }
LibC class >> setbuf: stream _: buf [
	^ self ffiCall:#( void setbuf(void* stream, char* buf))  module: LibC
	
]

{ #category : #'*LibUnix' }
LibC class >> tcgetattr: fd _: termios_p [
	^ self ffiCall:#( int tcgetattr(int fd, void* termios_p) )  module: LibC  
]

{ #category : #'*LibUnix' }
LibC class >> tcsetattr: fd _: optional_actions _: termios_p [
	^ self ffiCall:#( int tcsetattr(int fd, int optional_actions, void* termios_p) )  module: LibC  
]

{ #category : #'*LibUnix' }
LibC class >> unlockpt: fd [
	^ self ffiCall: #(int unlockpt(int fd)) module: LibC
]

{ #category : #'*LibUnix' }
LibC class >> waitpid: pid _: wstatus _: options [
	^ self ffiCall:#( int waitpid(int pid, int *wstatus, int options))  module: LibC
	
]
