Class {
	#name : #BaselineOfAIHierarchicalClustering,
	#superclass : #BaselineOf,
	#category : #BaselineOfAIHierarchicalClustering
}

{ #category : #baselines }
BaselineOfAIHierarchicalClustering >> baseline: spec [

	<baseline>
	spec for: #( common ) do: [ 
		"External dependencies"
		spec
			baseline: 'CollectionExtensions' with: [ spec repository: 'github://pharo-contributions/CollectionExtensions:v1.x.x/src' ].
		spec
    			baseline: 'AIExternalDataFrame' with: [ spec repository: 'github://pharo-ai/external-dependencies' ].

		
		"pharo-ai dependencies"
		spec
			baseline: 'AIMooseLinearAlgebra' with: [ spec repository: 'github://pharo-ai/moose-linear-algebra/src' ].

		"Packages"
		spec
			package: 'AI-HierarchicalClustering' with: [ spec requires: #( 'CollectionExtensions' 'AIMooseLinearAlgebra' 'AIExternalDataFrame' ) ];
			package: 'AI-HierarchicalClustering-Tests'
			with: [ spec requires: #( 'AI-HierarchicalClustering' ) ].
			
		"Groups"
		spec
			group: 'Core' with: #( 'AI-HierarchicalClustering' );
			group: 'Tests' with: #( 'AI-HierarchicalClustering' 'AI-HierarchicalClustering-Tests' );
			group: 'default' with: #( 'Core' 'Tests' ) ]
]
