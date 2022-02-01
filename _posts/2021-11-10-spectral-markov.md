---
layout: post
excerpt_separator: <!--more-->
title: Some Spectral Properties of Markov Chains
description: Gershgorin and his Circles
permalink: spectral-markov-chains/
date: 2021-11-10
---

Markov chains are stoachastic models for describing discrete sequences of random behavior.
While I normally dislike probability theory because I find it incredibly confusing, I like Markov chains because they can be expressed using linear algebra (which I find much less confusing!).
This post explores the spectral properties of Markov chains<span class="sidenote-number"></span>
<span class="sidenote">
    The *spectrum* of a matrix is the set of its eigenvalues.
    Spectral properties are then the properties of the eigenvalues that give rise to special behavior.
</span>
and relates this to the limiting probabilistic behaviors of Markov chains.

Three main results are proved in this post:

1. The eigenvalues of a Markov chain are bounded within the unit circle
2. A large class of Markov chains have a unique stationary distribution
3. If the Markov chain is not diagonalizable, the limiting distributions are calculable using the Jordan Canonical Form

## Gershgorin and His Circles

A Markov chain describes the probability of transitioning from one state to another.
These transition probabilities can be summarized using a Markov matrix:

**Definition 1 (Markov matrix).**
A matrix $$M \in M_n([0, 1])$$ is a Markov matrix if the entries of each column sum to 1.<span class="sidenote-number"></span>
<span class="sidenote">
    Said another way, if $$i$$ and $$j$$ are states in a Markov chain, then $$\mathbb P( j \mapsto i ) = M_{ij}$$
</span>

The eigenvalues of a Markov matrix have a remarkable property: they're never bigger than 1 in magnitude!
To prove this, we need an underrated result from linear algebra:

**Theorem 1 (Gershgorin disc theorem).**
For the $$i$$-th row of a matrix $$A$$,
<!-- let $$G_i(A) = \{ z \in \mathbb C : | z - A_{ii} | \leq R_i \}$$ be a disc centered at $$A_{ii}$$ where the radius is the row sum $$R_i = \sum_{j \neq i} A_{ij}$$. -->
let the row sum $$R_i = \sum_{j \neq i} A_{ij}$$ be the radius of the disc centered at $$A_{ii}$$: $$G_i(A) = \{ z \in \mathbb C : | z - A_{ii} | \leq R_i \}$$.
Let the union of these discs be $$G(A) = \cup_{i=1}^n G_i(A) \,.$$
Then, $$\sigma(A) \subseteq G(A) \,.$$<span class="sidenote-number"></span>
<span class="sidenote">
    Note that $$\sigma(A) = \{\lambda \in \mathbb C : Ax = \lambda x\}$$ represents the set of all eigenvalues of $$A$$.
</span>
\
*Proof:* A good explanation is avilable on [Wikipedia](https://en.wikipedia.org/wiki/Gershgorin_circle_theorem#Statement_and_proof).

We can augment the Gershgorin disc theorem with a quick lemma connecting the eigenvalues of $$A$$ and $$A^*$$:

**Lemma 1.**
Given a matrix $$A \in M_n$$, $$\sigma(A) = \sigma(A^*)$$.
\
*Proof:*
The lemma holds since $$A$$ and $$A^*$$ have the same characteristic polynomial:
$$\det(A^*- \lambda I) = \det((A - \lambda I)^*) = \det(A - \lambda I) \,.$$

Thanks to Lemma 1, we can equivalently define $$R_i$$ in the Gershgorin disc theorem to be the *column sum*, $$\sum_{i \neq j} A_{ij}$$, instead of the row sum.
Now, the first main result follows:

**Corollary 1 (Spectrum of Markov matrices).**
The eigenvalues of a Markov matrix $$M \in M_n([0, 1]) \,,$$ are bounded within the unit circle.<span class="sidenote-number"></span>
<span class="sidenote">
    Said mathematically, $$\sigma(M) \subseteq \{ z \in \mathbb C : |z| \leq 1 \} \,.$$
</span>
\
*Proof:*
Since the columns of $$M$$ must sum to $$1$$, this means that for every column $$i$$, $$M_{ii} + R_i = 1$$.
Therefore, the disc $$G_i(M)$$ is a subset of the unit circle that also intersects the unit circle at $$(1, 0)$$.
<!-- The same holds for the union of the discs, $$G(M)$$. -->
Therefore, by Theorem 1, $$\sigma(M) \subseteq G(M) \subseteq \{ z \in \mathbb C : |z| \leq 1 \}$$.

Here is an illustration of this proof for a Markov matrix in $$M_4([0,1])$$.
Interestingly, this picture also shows us that the only way we can have an complex eigenvalue with magnitude 1 is if one of the $$M_{ii} = 0$$...
more on this later.

![markov-gershgorin](../images/markov_gershgorin.png)

Next, we ask what is the largest eigenvalue of a Markov matrix?

**Corollary 2 (Spectral radius of Markov matrices).**
The spectral radius of a Markov matrix is $$\rho(M) = 1$$ and $$\rho(M) \in \sigma(M)$$.
\
*Proof:*
Let $$\vec{1} \in \mathbb R^n$$ be a column vector of all 1s.
We can then write the column sum constraint as $$M^*\vec{1} = \vec{1}$$.
Note that this equation shows that $$\lambda = 1$$ is an eigenvalue of $$M^*$$ (and by Lemma 1, also an eigenvalue of $$M$$).
Because the eigenvalues of $$M$$ are constrained within the unit circle by Corollary 1,
$$\lambda = 1$$ achieves the maximum possible modulus.
<!-- In fact, the only way another eigenvalue achieves maximum modulus is if $$M_{ii} = 0$$ for some $$i$$. -->
Therefore, $$\rho(M) = 1$$ and $$\rho(M) \in \sigma(M)$$.

*Remark:*
This is a very powerful sets of results!
They show that if our Markov matrix is diagonalizable (i.e., $$M = SDS^{-1}$$ for $$S \in M_n$$ invertible and $$D \in M_n$$ diagonal),
then $$M^k = SD^kS^{-1}$$ will converge to some steady state distribution as $$k \to \infty$$,
and the steady state will correspond the the eigenvectors of $$M$$ whose eigenvalues equal the spectral radius.<span class="sidenote-number"></span>
<span class="sidenote">
    What happens if $$M$$ is not diagonalizable?
    In this case, we have to use the Jordan Canonical Form (JCF) of $$M$$ (more on this later).
</span>

## The Perron--Frobenius Theorem

**Definition 3 (Positive and non-negative matrices).**
A matrix $$A \in M_n(\mathbb R)$$ is positive (written $$A > 0$$) if all entries of $$A$$ are positive.
Similarly, if all the entries of $$A$$ are non-negative, then $$A$$ is non-negative as well (i.e., $$A \geq 0$$).

The Perron--Frobenius Theorem gives many results about positive matrices.
To study Markov matrices, we focus on one of them:

**Theorem 2 (Perron--Frobenius).**
If $$A \in M_n(\mathbb R)$$ is positive, then $$\rho(A)$$ is an eigenvalue of $$A$$ with algebraic multiplicity 1.

**Corollary 3.**
Theorem 2 still applies if $$A$$ is non-negative and irreducible.

By definition, Markov matrices are non-negative.
If a Markov matrix is irreducible, then the Perron--Frobenius theorem says that $$rho(M)=1$$ is a simple eigenvalue of $$M$$.
Since the geometric multiplicity of an eigenvalue is bounded above by its algebraic multiplicity, that means that there is only a single eigenvector $$x$$ such that $$Ax = x$$.
This vector $$x$$, scaled so that its entries sum to 1, is the steady state distribution of $$M$$.

## Future questions to answer

These will slowly be addressed in future versions of this post.

- What happens if $$M$$ is not diagonalizable?
- How does this connect to deterministic discrete linear dynamic systems?
