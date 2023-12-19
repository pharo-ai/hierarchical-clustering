# Hierarchical Clustering

[![Build status](https://github.com/pharo-ai/hierarchical-clustering/workflows/CI/badge.svg)](https://github.com/pharo-ai/hierarchical-clustering/actions/workflows/test.yml)
[![Coverage Status](https://coveralls.io/repos/github/pharo-ai/hierarchical-clustering/badge.svg?branch=master)](https://coveralls.io/github/pharo-ai/hierarchical-clustering?branch=master)
[![Pharo version](https://img.shields.io/badge/Pharo-9-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo version](https://img.shields.io/badge/Pharo-10-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo version](https://img.shields.io/badge/Pharo-11-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo version](https://img.shields.io/badge/Pharo-12-%23aac9ff.svg)](https://pharo.org/download)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/pharo-ai/hierarchical-clustering/master/LICENSE)

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

# How to depend on it?

If you want to add a dependency on hierarchical-clustering to your project, include the following lines into your baseline method:

```Smalltalk
spec
  baseline: 'AIHierarchicalClustering'
  with: [ spec repository: 'github://pharo-ai/hierarchical-clustering/src' ].
```

If you are new to baselines and Metacello, check out the [Baselines](https://github.com/pharo-open-documentation/pharo-wiki/blob/master/General/Baselines.md) tutorial on Pharo Wiki.

