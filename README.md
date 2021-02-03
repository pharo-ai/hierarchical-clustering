# Description

Hierarchical Clustering algorithms for Pharo

# Installation

```smalltalk
Metacello new
	baseline: 'AIHierarchicalClustering';
	repository: 'github://pharo-ai/hierarchical-clustering/src';
	load.
```

If you want to load the Roassal visualization support:

```smalltalk
Metacello new
	baseline: 'AIViz';
	repository: 'github://pharo-ai/viz/src';
	load: #('AIVizRoassalHC')
```

## How to depend on it?

If you want to add a dependency on hierarchical-clustering to your project, include the following lines into your baseline method:

```Smalltalk
spec
  baseline: 'AIHierarchicalClustering'
  with: [ spec repository: 'github://pharo-ai/hierarchical-clustering/src' ].
```

If you are new to baselines and Metacello, check out the [Baselines](https://github.com/pharo-open-documentation/pharo-wiki/blob/master/General/Baselines.md) tutorial on Pharo Wiki.

