Extension { #name : #BlockClosure }

{ #category : #'*LibCompat' }
BlockClosure >> on: exception1 do: handler1 on: exception2 do: handler2 [
	^ [ self on: exception1 do: handler1 ]
	         on: exception2 do: handler2


]
