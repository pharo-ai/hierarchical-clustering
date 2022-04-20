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
			baseline: 'AIExternalDependencies'
			with: [ spec
				loads: #('DataFrameGroup');
				repository: 'github://pharo-ai/external-dependencies' ].
		
		"pharo-ai dependencies"
		spec
			baseline: 'AILinearAlgebra' with: [ spec repository: 'github://pharo-ai/linear-algebra/src' ].

		"Packages"
		spec
			package: 'AI-HierarchicalClustering' with: [ spec requires: #( 'CollectionExtensions' 'AILinearAlgebra' 'AIExternalDependencies' ) ];
			package: 'AI-HierarchicalClustering-Tests'
			with: [ spec requires: #( 'AI-HierarchicalClustering' ) ].
			
		"Groups"
		spec
			group: 'Core' with: #( 'AI-HierarchicalClustering' );
			group: 'Tests' with: #( 'AI-HierarchicalClustering' 'AI-HierarchicalClustering-Tests' );
			group: 'default' with: #( 'Core' 'Tests' ) ]
]
