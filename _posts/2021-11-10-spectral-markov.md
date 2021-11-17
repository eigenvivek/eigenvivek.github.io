---
layout: post
excerpt_separator: <!--more-->
title: Deriving Spectral Properties of Markov Chains
description: Gershgorin and his Circles
permalink: spectral-markov-chains/
date: 2021-11-10
---

## Gershgorin and His Circles

**Definition 1 (Markov matrix).**
A matrix $$M \in M_n([0, 1])$$ is a Markov matrix if for every row $$i \in \{1, \dots, n\}$$, $$\sum_{j=1}^n M_{ij} = 1 \,.$$

**Theorem 1 (Gershgorin disc theorem).**
For a matrix $$A \in M_n$$,
let $$R_i = \sum_{j \neq i} A_{ij}$$ be the radius for the disc $$G_i(A) = \{ z \in \mathbb C : | z - A_{ii} | \leq R_i \} \,,$$
and let $$G(A) = \cup_{i=1}^n G_i(A) \,.$$
Then, $$\sigma(A) \subset G(A) \,.$$<span class="sidenote-number"></span>
<span class="sidenote">
    A good proof is on [Wikipedia](https://en.wikipedia.org/wiki/Gershgorin_circle_theorem#Statement_and_proof)!
</span>

**Corollary 1 (Spectrum of Markov matrices).**
For a Markov matrix $$M \in M_n([0, 1]) \,,$$ $$\sigma(M) \subset \{ z \in \mathbb C : |z| \leq 1 \} \,.$$
\
*Proof:*
Since the rows of $$M$$ must sum to $$1$$, this means that for every row $$i$$, $$M_{ii} + R_i = 1 $$.
Therefore, the disc $$G_i(M)$$ is a subset of the unit circle and also intersects the unit circle at $$(1, 0)$$.
The same holds for the union of the discs, $$G(M)$$.
Finally, by Gershgorin, $$\sigma(M) \subset G(M) \subset \{ z \in \mathbb C : |z| \leq 1 \} \,.$$

Here is an illustration of this proof for a Markov matrix in $$M_4([0,1])$$:

![markov-gershgorin](../images/markov_gershgorin.png)

**Corollary 2 (Spectral radius of Markov matrices).**
The spectral radius of a Markov matrix is $$\rho(M) = 1$$.
\
*Proof:*
Because of the row constraint, $$M \vec{1} = \vec{1}$$, so $$\lambda = 1$$ is an eigenvalue of $$M$$.
Because the eigenvalues of $$M$$ are constrained within the unit circle by Corollary 1,
$$\lambda = 1$$ achieves the maxmum possible modulus.
In fact, the only way another eigenvalue achieves maximum modulus is if $$M_{ii} = 0$$ for some $$i$$.
Therefore, $$\rho(M) = 1$$.

This is a very powerful sets of results!
They show that if our Markov matrix is diagonalizable (i.e., $$M = SDS^{-1}$$ for $$S \in M_n$$ invertible and $$D \in M_n$$ diagonal),
then $$M^k = SD^kS^{-1}$$ will converge to some steady state distribution as $$k \to \infty$$, 
and the steady state will correspond the the eigenvectors of $$M$$ whose eigenvalues equal the spectral radius.

## Future questions to answer
These will slowly be addressed in future versions of this post.

- What are the algebraic and geometric multiplicities of $$\lambda = 1$$?
- How does $$\vec{1}$$ being an eigenvector of $$M$$ not contradict the Perron-Frobenius theorem?
- How many steady state distributions can $$M$$ have?
- What happens if $$M$$ is not diagonalizable?
