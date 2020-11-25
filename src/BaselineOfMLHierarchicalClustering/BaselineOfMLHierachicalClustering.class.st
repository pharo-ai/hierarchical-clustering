Class {
	#name : #BaselineOfMLHierachicalClustering,
	#superclass : #BaselineOf,
	#category : #BaselineOfMLHierarchicalClustering
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
				package: 'MLHierarchicalClustering'	 		with: [ spec requires: #('CollectionExtensions' 'MLLinearAlgebra') ];
				package: 'MLHierarchicalClustering-Tests' 	with: [ spec requires: #(MLHierarchicalClustering) ].
			spec 
				group: 'Core' 						with: #('MLHierarchicalClustering');
				group: 'Tests' 						with: #('MLHierarchicalClustering' 'MLHierarchicalClustering-Tests');
				group: 'default' 					with: #('Core' 'Tests') ]
]