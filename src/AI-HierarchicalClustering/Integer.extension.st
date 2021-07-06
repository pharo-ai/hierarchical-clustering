Extension { #name : #Integer }

{ #category : #'*AI-HierarchicalClustering' }
Integer >> findNK [

	" Yields all n and k such that n take: k = self.
	https://math.stackexchange.com/a/103385/205 "

	| k |
	[ self > 1 ] assert.
	k := 0.
	^ Array streamContents: [ :stream | 
		  [ true ] whileTrue: [ 
			  | nmin nmax choose |
			  k := k + 1.
			  2 * k + 1 * self <= (4 ** k) ifTrue: [ ^ stream contents ].
			  nmin := self firstOver: k with: k factorial * self.
			  nmax := nmin + k + 1.
			  nmin := nmin max: 2 * k.
			  choose := nmin asInteger numberOfCombinationsTaken: k.
			  nmin to: nmax do: [ :n | 
				  choose = self ifTrue: [ 
					  stream nextPutAll: { 
							  n asInteger.
							  k asInteger }.
					  k < (n - k) ifTrue: [ 
						  stream nextPutAll: { 
								  n asInteger.
								  (n - k) asInteger } ] ].
				  choose := choose * (n + 1).
				  choose := (choose / (n + 1 - k)) ceiling ] ] ]
]

{ #category : #'*AI-HierarchicalClustering' }
Integer >> firstOver: k with: c [
    " Binary search to find smallest value of n for which n^k >= c "
	| n lo hi mid |

    n := 1.
    [ (n ** k) < c ] whileTrue: [ n := n * 2 ].
    lo := 1.
    hi := n.
    [ (hi - lo) > 1 ] whileTrue: [ 
		mid := lo + ((hi - lo) / 2).
		(mid ** k) < c
			ifTrue: [ lo := mid ]
			ifFalse: [ hi := mid ] ].
	[ (hi ** k) >= c ] assert.
	[ ((hi - 1) ** k) < c ] assert.
   ^ hi

]
