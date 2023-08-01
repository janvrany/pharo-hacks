Extension { #name : #ZnEncodedStream }

{ #category : #'*LibUnix' }
ZnEncodedStream >> fileDescriptor [
	^stream fileDescriptor 
]

{ #category : #'*LibUnix' }
ZnEncodedStream >> setLocalEcho: aBoolean [
	stream setLocalEcho: aBoolean
]

{ #category : #'*LibUnix' }
ZnEncodedStream >> setOutputCRLF: aBoolean [
	stream setOutputCRLF: aBoolean
]
