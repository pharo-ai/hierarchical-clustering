Class {
	#name : #BaselineOfMLHierachicalClustering,
	#superclass : #BaselineOf,
	#category : #BaselineOfMLHierachicalClustering
}

{ #category : #baselines }
BaselineOfMLHierachicalClustering >> baseline: spec [
  <baseline>
	spec
		for: #(common)
		do: [ 
			spec
				baseline: 'CollectionExtensions'
				with: [ spec repository: 'github://pharo-contributions/CollectionExtensions:v1.x.x/src' ];
				
				baseline: 'MLLinearAlgebra'
				with: [ spec repository: 'github://pharo-ai/MLLinearAlgebra/src' ].

			spec 
				package: 'MLHierachicalClustering'	 with: [ spec requires: #('CollectionExtensions' 'MLLinearAlgebra') ].
			spec 
				group: 'Core' 						with: #('MLHierachicalClustering');
				group: 'Tests' 						with: #('MLHierachicalClustering' 'MLHierachicalClustering-Tests');
				group: 'default' 					with: #('Core' 'Tests') ]
]
