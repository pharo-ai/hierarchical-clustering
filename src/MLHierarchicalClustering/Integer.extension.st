Extension { #name : #Integer }

{ #category : #'*MLHierarchicalClustering' }
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
