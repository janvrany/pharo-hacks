Extension { #name : #SmalltalkImage }

{ #category : #'*LibCompat' }
SmalltalkImage >> getPackageDirectoryForPackage: packageOrString [
  "Return a directory containing sources of given package or `nil` if
   it cannot be found.

	For example, if 'pharo-hacks' repository is checked out at
	`/tmp/xxx/pharo-hacks` then

	    Smalltalk getPackageDirectoryForPackage: 'LibCompat'

	returns `/tmp/xxx/pharo-hacks/src/LibCompat`. While this may
	seem weird, it is to make it compatible with Smalltalk/X.

	CAVEAT: This requires given package to be registered with one of the
	Iceberg-managed git repositories. If not (for example the package is
	loaded from command line directly from local directory) `nil` is
	returned. If anyones knows how to overcome this limitation, let
	me know."

	| package repo |

	package := packageOrString isString
						ifTrue:[RPackage named: packageOrString]
						ifFalse:[packageOrString].

	repo := IceRepository registeredRepositoryIncludingPackage: package.
	repo notNil ifTrue:[
		^ repo location / repo project sourceDirectory / package name
	].

	^nil

	"
	Smalltalk getPackageDirectoryForPackage: 'LibCompat'.
	Smalltalk getPackageDirectoryForPackage: TRCompilation package.
	Smalltalk getPackageDirectoryForPackage: GDBDebugger package.
	"
]
