---
layout: post
excerpt_separator: <!--more-->
title: A Fun Interpretation of Unitary Matrices
description: Why are the rows orthonormal?
permalink: unitary-matrices/
date: 2022-05-28
---

This is a proof that if the columns of the matrix are orthonormal, then the rows are also orthonormal.

Let $$U \in M_n(\mathbb{C})$$ be a square matrix such that its columns form an orthonormal basis over $$\mathbb{C}^n$$.
That is, for each pair of columns $$x_i$$ and $$x_j$$, the inner product $$x_i^* x_j = \delta_{ij}$$.<span class="sidenote-number"></span>
<span class="sidenote">
    This is the Kronecker delta. It equals $$1$$ if $$x_i = x_j$$ and $$0$$ otherwise.
</span>
If we think about matrix multiplication as a series of inner products between the rows of the first matrix and the columns of the second matrix, then this gives us the following identities:

$$(U^*U)_{ij} = x_i^* x_j = \delta_{ij} \Longrightarrow U^*U = I \Longrightarrow UU^* = I \,,$$

where the last identity follows from the fact that if $$AB=I$$, then $$BA=I$$.<span class="sidenote-number"></span>
<span class="sidenote">
    See the proof [here](https://math.stackexchange.com/questions/3852/if-ab-i-then-ba-i).
    Note that the class of square matrices $$U$$ adhering to the identity $$ U^*U = UU^* = I \,, $$ are the [unitary matrices](https://www.wikiwand.com/en/Unitary_matrix).
</span>
But this is interesting... the last identity implies that the *rows* of $$U$$ are also orthonormal!
**If the columns of the matrix are orthonormal, then why are the rows also orthonormal?**

To answer this, it helps think about matrix multiplication as a series of *outer* products: $$ U^*U = \sum_{i=1}^n x_i x_i^* \,. $$
For a pair of orthonormal vectors $$x_i$$ and $$x_j$$, the rank-one matrix $$ P_{x_i} = x_i x_i^* $$ represents the orthogonal projection onto the vector $$x_i$$.
Therefore,

$$ UU^* = \sum_{i=1}^n x_i x_i^* = P_{x_1} + \cdots + P_{x_n} = I \,. $$

Here's why the last equality holds: since the vectors $$\{x_1, \dots, x_n\}$$ form a basis over $$\mathbb{C}^n$$, the sum of $$n$$ rank-one projection matrices forms a projection into $$\mathbb C^n \,.$$ Therefore, multiplying a vector $$y \in \mathbb C^n$$ by the matrix $$UU^*= (P_{x_1} + \cdots + P_{x_n})$$ results in no loss of dimensionality since we are projecting onto the full vector space $$\mathbb C^n$$.
That is,

$$
\begin{align}
    UU^* y
    &= (P_{x_1} + \cdots + P_{x_n}) y \\
    &= P_{x_1} y + \cdots + P_{x_n} y \\
    &= c_1 x_1 + \cdots + c_n x_n \\
    &= y \,, &&\text{(It's just a change of basis!)}
\end{align}
$$

implying that $$UU^* = I \,.$$

This proof shows that orthonormal columns imply orthonormal rows, giving another intuition for the geometric behavior of unitary matrices.
