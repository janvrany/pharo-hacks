Class {
	#name : #UnixConstants,
	#superclass : #SharedPool,
	#classVars : [
		'ECHO',
		'ECHOE',
		'ECHOK',
		'ECHONL',
		'FIOASYNC',
		'FIOCLEX',
		'FIONBIO',
		'FIONCLEX',
		'FIONREAD',
		'ICANON',
		'ISIG',
		'NOFLSH',
		'OCRNL',
		'OFDEL',
		'OFILL',
		'OLCUC',
		'ONLCR',
		'ONLRET',
		'ONOCR',
		'OPOST',
		'POLLERR',
		'POLLHUP',
		'POLLIN',
		'POLLNVAL',
		'POLLOUT',
		'POLLPRI',
		'POLLRDBAND',
		'POLLRDNORM',
		'POLLWRBAND',
		'POLLWRNORM',
		'TCFLSH',
		'TCGETA',
		'TCGETS',
		'TCGETX',
		'TCSADRAIN',
		'TCSAFLUSH',
		'TCSANOW',
		'TCSBRK',
		'TCSBRKP',
		'TCSETA',
		'TCSETAF',
		'TCSETAW',
		'TCSETS',
		'TCSETSF',
		'TCSETSW',
		'TCSETX',
		'TCSETXF',
		'TCSETXW',
		'TCXONC',
		'TIOCCBRK',
		'TIOCCONS',
		'TIOCEXCL',
		'TIOCGETD',
		'TIOCGICOUNT',
		'TIOCGLCKTRMIOS',
		'TIOCGPGRP',
		'TIOCGRS485',
		'TIOCGSERIAL',
		'TIOCGSID',
		'TIOCGSOFTCAR',
		'TIOCGWINSZ',
		'TIOCINQ',
		'TIOCLINUX',
		'TIOCMBIC',
		'TIOCMBIS',
		'TIOCMGET',
		'TIOCMIWAIT',
		'TIOCMSET',
		'TIOCNOTTY',
		'TIOCNXCL',
		'TIOCOUTQ',
		'TIOCPKT',
		'TIOCPKT_DATA',
		'TIOCPKT_DOSTOP',
		'TIOCPKT_FLUSHREAD',
		'TIOCPKT_FLUSHWRITE',
		'TIOCPKT_IOCTL',
		'TIOCPKT_NOSTOP',
		'TIOCPKT_START',
		'TIOCPKT_STOP',
		'TIOCSBRK',
		'TIOCSCTTY',
		'TIOCSERCONFIG',
		'TIOCSERGETLSR',
		'TIOCSERGETMULTI',
		'TIOCSERGSTRUCT',
		'TIOCSERGWILD',
		'TIOCSERSETMULTI',
		'TIOCSERSWILD',
		'TIOCSER_TEMT',
		'TIOCSETD',
		'TIOCSLCKTRMIOS',
		'TIOCSPGRP',
		'TIOCSRS485',
		'TIOCSSERIAL',
		'TIOCSSOFTCAR',
		'TIOCSTI',
		'TIOCSWINSZ',
		'TIOCVHANGUP',
		'TOSTOP'
	],
	#category : #'LibUnix-I/O'
}

{ #category : #accessing }
UnixConstants class >> ECHO [
	^ECHO
]

{ #category : #accessing }
UnixConstants class >> OCRNL [ 
	^OCRNL 
]

{ #category : #accessing }
UnixConstants class >> ONLCR [
	^ONLCR
]

{ #category : #accessing }
UnixConstants class >> TCSANOW [ 
	^TCSANOW 
]

{ #category : #initialization }
UnixConstants class >> initialize [
 	(Smalltalk os version beginsWith: 'linux') ifTrue:[
		self initializeForLinux.
		^ self.
	].

	self error:'Unsupported Unix system'
	
	"
	UnixConstants initialize
	"
]

{ #category : #initialization }
UnixConstants class >> initializeForLinux [
 
    " 0x54 is just a magic number to make these relatively unique ('T') "

    TCGETS		:= 16r5401 .
    TCSETS		:= 16r5402 .
    TCSETSW		:= 16r5403 .
    TCSETSF		:= 16r5404 .
    TCGETA		:= 16r5405 .
    TCSETA		:= 16r5406 .
    TCSETAW		:= 16r5407 .
    TCSETAF		:= 16r5408 .
    TCSBRK		:= 16r5409 .
    TCXONC		:= 16r540A .
    TCFLSH		:= 16r540B .
    TIOCEXCL	:= 16r540C .
    TIOCNXCL	:= 16r540D .
    TIOCSCTTY	:= 16r540E .
    TIOCGPGRP	:= 16r540F .
    TIOCSPGRP	:= 16r5410 .
    TIOCOUTQ	:= 16r5411 .
    TIOCSTI		:= 16r5412 .
    TIOCGWINSZ	:= 16r5413 .
    TIOCSWINSZ	:= 16r5414 .
    TIOCMGET	:= 16r5415 .
    TIOCMBIS	:= 16r5416 .
    TIOCMBIC	:= 16r5417 .
    TIOCMSET	:= 16r5418 .
    TIOCGSOFTCAR:= 16r5419 .
    TIOCSSOFTCAR:= 16r541A .
    FIONREAD	:= 16r541B .
    TIOCINQ		:= FIONREAD .
    TIOCLINUX	:= 16r541C .
    TIOCCONS	:= 16r541D .
    TIOCGSERIAL	:= 16r541E .
    TIOCSSERIAL	:= 16r541F .
    TIOCPKT		:= 16r5420 .
    FIONBIO		:= 16r5421 .
    TIOCNOTTY	:= 16r5422 .
    TIOCSETD	:= 16r5423 .
    TIOCGETD	:= 16r5424 .
    TCSBRKP		:= 16r5425 . " Needed for POSIX tcsendbreak() "
    TIOCSBRK	:= 16r5427 . " BSD compatibility "
    TIOCCBRK	:= 16r5428 . " BSD compatibility "
    TIOCGSID	:= 16r5429 . " Return the session ID of FD "
    TIOCGRS485	:= 16r542E .
    TIOCSRS485	:= 16r542F .
    TCGETX		:= 16r5432 . " SYS5 TCGETX compatibility "
    TCSETX		:= 16r5433 .
    TCSETXF		:= 16r5434 .
    TCSETXW		:= 16r5435 .
    TIOCVHANGUP	:= 16r5437 .
    FIONCLEX	:= 16r5450 .
    FIOCLEX		:= 16r5451 .
    FIOASYNC	:= 16r5452 .
    TIOCSERCONFIG	:= 16r5453 .
    TIOCSERGWILD	:= 16r5454 .
    TIOCSERSWILD	:= 16r5455 .
    TIOCGLCKTRMIOS	:= 16r5456 .
    TIOCSLCKTRMIOS	:= 16r5457 .
    TIOCSERGSTRUCT	:= 16r5458 ." For debugging only "
    TIOCSERGETLSR   := 16r5459 ." Get line status register "
    TIOCSERGETMULTI := 16r545A ." Get multiport config  "
    TIOCSERSETMULTI := 16r545B ." Set multiport config "

    TIOCMIWAIT	:= 16r545C . " wait for a change on serial input line(s) "
    TIOCGICOUNT	:= 16r545D . " read serial port __inline__ interrupt counts "

    TIOCPKT_DATA	       := 0 .
    TIOCPKT_FLUSHREAD  :=	 1 .
    TIOCPKT_FLUSHWRITE :=	 2 .
    TIOCPKT_STOP	       := 4 .
    TIOCPKT_START      := 8 .
    TIOCPKT_NOSTOP     := 16 .
    TIOCPKT_DOSTOP     := 32 .
    TIOCPKT_IOCTL      := 64 .

    TIOCSER_TEMT       := 16r01.	" Transmitter physically empty "
	
	
	POLLIN     := 16r001.
	POLLPRI    := 16r002.
	POLLOUT    := 16r004.
	
	POLLRDNORM := 16r040.
	POLLRDBAND := 16r080.
	POLLWRNORM := 16r100.
	POLLWRBAND := 16r200.
	
	POLLERR    := 16r008.
	POLLHUP    := 16r010.
	POLLNVAL   := 16r020.	

	OPOST   := 0000001  . "/* Post-process output.  */"
	OLCUC   := 0000002  . "/* Map lowercase characters to uppercase on output.
                            (not in POSIX).  */"
	ONLCR   := 0000004  . "/* Map NL to CR-NL on output.  */"
	OCRNL   := 0000010  . "/* Map CR to NL on output.  */"
	ONOCR   := 0000020  . "/* No CR output at column 0.  */"
	ONLRET  := 0000040  . "/* NL performs CR function.  */"
	OFILL   := 0000100  . "/* Use fill characters for delay.  */"
	OFDEL   := 0000200  . "/* Fill is DEL.  */"
	
	ISIG    := 0000001   . "/* Enable signals.  */"
	ICANON  := 0000002   . "/* Canonical input (erase and kill processing).  */"
	ECHO    := 0000010   . "/* Enable echo.  */"
	ECHOE   := 0000020   . "/* Echo erase character as error-correcting
                             backspace.  */"
	ECHOK   := 0000040   . "/* Echo KILL.  */"
	ECHONL  := 0000100   . "/* Echo NL.  */"
	NOFLSH  := 0000200   . "/* Disable flush after interrupt or quit.  */"
	TOSTOP  := 0000400   . "/* Send SIGTTOU for background output.  */"
	
	TCSANOW        := 0.
	TCSADRAIN      := 1.
	TCSAFLUSH      := 2.

	"
	UnixConstants initialize
	"
]
