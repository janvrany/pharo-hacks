Extension { #name : #AbstractBinaryFileStream }

{ #category : #'*LibUnix' }
AbstractBinaryFileStream >> fileDescriptor [
	handle notNil ifTrue:[
		^ File fileDescriptor: handle.
	].
	self error:'Stream closed or never opened'.
]

{ #category : #'*LibUnix' }
AbstractBinaryFileStream >> setLocalEcho: aBoolean [
	File setLocalEcho: handle to: aBoolean
]

{ #category : #'*LibUnix' }
AbstractBinaryFileStream >> setNonBlocking [ 
	File setNonBlocking: handle
]

{ #category : #'*LibUnix' }
AbstractBinaryFileStream >> setNonBuffered [
	File setNonBuffered: handle
]

{ #category : #'*LibUnix' }
AbstractBinaryFileStream >> setOutputCRLF: aBoolean [
	File setOutputCRLF: handle to: aBoolean
]
