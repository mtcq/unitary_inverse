### Code to accompany: *[Reversing unknown quantum transformations: A universal protocol for inverting general unitary operations](https://arxiv.org/list/quant-ph/new)*
#### Marco Túlio Quintino, Qingxiuxiong Dong, Atsushi Shimbo, Akihito Soeda, and Mio Murao


This repository provides the codes used to obtain Table I and Table II in the article
[Reversing unknown quantum transformations: A universal protocol for inverting general unitary operations](https://arxiv.org/list/quant-ph/new)
#### Marco Túlio Quintino, Qingxiuxiong Dong, Atsushi Shimbo, Akihito Soeda, and Mio Murao

All codes are written in MATLAB and require:
- [CVX](http://cvxr.com/) - a Matlab-based convex modeling framework

We have also used functions of QETLAB ([QETLAB](http://www.qetlab.com/) - A MATLAB Toolbox for Quantum Entanglement), but all used functions can be find in the subfolder [QETLAB_used_functions](https://github.com/mtcq/unitary_inverse/tree/master/universal_unitary_inverse/QETLAB_used_functions).

It has been tested on Matlab R2018A, and CVX 2.1

The main scripts of this repositories are:

  - [run_unitary_inverse](https://github.com/mtcq/unitary_inverse/blob/master/universal_unitary_inverse/run_unitary_inverse.m): Obtain the maximal success probability for parallel, sequential, and general (potentially with indefinite causal order) protocols to transform 'k' uses of a 'd'-dimensional unitary into its inverse.
  - [run_unitary_transpose](https://github.com/mtcq/unitary_inverse/blob/master/universal_unitary_inverse/run_unitary_transpose.m): Obtain the maximal success probability for parallel, sequential, and general (potentially with indefinite causal order) protocols to transform 'k' uses of a 'd'-dimensional unitary into its transpose.
 
 
The scripts [run_unitary_inverse](https://github.com/mtcq/unitary_inverse/blob/master/universal_unitary_inverse/run_unitary_inverse.m) and  [run_unitary_transpose](https://github.com/mtcq/unitary_inverse/blob/master/universal_unitary_inverse/run_unitary_transpose.m) make use of the following subfunctions:

 - [find_dimension](https://github.com/mtcq/unitary_inverse/blob/master/universal_unitary_inverse/find_dimension.m): Determine the dimention of the linear space spanned by 'k' copies of 'd' dimension unitary channels
 - [is_general_protocol](https://github.com/mtcq/unitary_inverse/blob/master/universal_unitary_inverse/is_general_protocol.m): Determine the dimention of the linear space spanned by 'k' copies of 'd' dimension unitary channels
