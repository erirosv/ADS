# Script

## Wrappers & Filters
Wrappers are more timeconsuming and infeasable to use for big data, take "ages" to convert

## SPSA
SPSA stands for "Simultaneous Perturbation Stochastic Approximation". It is a stochastic optimization algorithm that can be used to optimize complex objective functions, especially those that are noisy and have many parameters.

SPSA is a gradient-free optimization algorithm, which means that it does not require the calculation of gradients. Instead, it estimates the gradient of the objective function by perturbing the parameters in a random way and using the resulting function evaluations to approximate the gradient.

SPSA has been applied in various fields, including signal processing, control, machine learning, and optimization. It has been used in feature selection as well, where it is often combined with wrapper or filter approaches to identify a subset of relevant features for a given classification task.

## Barzilai and Borwein
Barzilai and Borwein (BB) is a gradient-based optimization algorithm that was proposed to efficiently solve unconstrained optimization problems. The algorithm is designed to adjust the step size adaptively using information from the gradient of the objective function.

In BB, the step size is determined based on the norm of the gradient vector, with smaller steps taken in regions with larger gradients and larger steps taken in regions with smaller gradients. The algorithm has been shown to converge quickly, and is particularly effective for problems with poorly scaled variables or noisy objective functions.

BB has been applied in various fields, including machine learning, signal processing, and image processing. It has been used in feature selection problems as well, where the objective is to select a subset of features that are most relevant for a given classification task.

## SPFSR
It is a wrapper that converts very fast which makes it appropriate to use for this big-data 

- The SPFSR (Sparse Principal Feature Selection and Ranking) algorithm is designed to perform feature selection and ranking for high-dimensional datasets. 
- The algorithm first applies principal component analysis (PCA) to the dataset to reduce its dimensionality, and then uses sparse regression to identify the most important features. 
- The identified features are then ranked based on their contribution to the regression model, and the top-ranked features are selected for further analysis. 
- The goal of the algorithm is to identify a small subset of features that are most relevant for predicting the outcome variable, while minimizing the number of irrelevant or redundant features.

Methods:
- Filter: The filter method is used as a preprocessing step to remove irrelevant features, based on their correlation with the class labels, before the wrapper algorithm is applied. The filter method they used in this study is the correlation-based feature selection (CFS) algorithm.
- Wrappers: In the wrapper method, a subset of features is selected and evaluated using a classification algorithm, and the process is repeated until the optimal subset of features is obtained. The classification algorithm they used in this study is the random forest (RF) classifier.

Filter example:
- 1000000 features, apply a filter and get 1000 of these, then apply the wrapper to find the 10 needed. 
- Filter is ignoring the manious stuff, ignoring the relation with the classifier, might even ignore the relations between the features 

The wrapper can find all this important 10 features without the use of the filter.