# Deriving PCA from the Courant--Fischer Theorem
2021-09-06 | *A variational eigenvalue characterization of principle components*

Principal Component Analysis (PCA) is one of my favorite algorithms because (1) it is foundational and broadly applicable, and (2) it can be derived using approaches from many different mathematical fields.[^1]

[^1]: The second chapter of [Vidal et al. (2015)](https://link.springer.com/content/pdf/10.1007/978-0-387-87811-9.pdf) presents PCA from three different perspectives: statistical, geometric, and rank-minimization.

Typically, these derivations involve optimizing a high-dimensional objective function with Lagrange multipliers. Instead, the Courant--Fischer Theorem, a fundamental theorem from linear algebra, can be used to more simply arrive at a solution to this optimization problem.[^2]

[^2]: This post synthesizes ideas I encountered in Matrix Analysis ([JHU.AMS.792](https://www.amazon.com/Matrix-Analysis-Second-Roger-Horn/dp/0521548233)) and Unsupervised Learning ([JHU.BME.692](http://www.vision.jhu.edu/teaching/learning/learning17/)).

In this post, we prove the Courant--Fischer Theorem, use it to derive PCA, and finally consider some technical points from the derivation.

## Formulating PCA as a matrix optimization problem

One view of PCA can be motivated by the following question:

> Given a set of high-dimensional data points, what are the **directions of maximal variance?**

Represent one such high-dimensional data point with a random vector $x \in \mathbb{R}^D$ and assume the following:

- $\mathbb{E}[x] = 0$ (i.e., the vector is *mean-centered*), and
- $\mathrm{rank}(\Sigma_x) \geq d$, where $\Sigma_x$ is the covariance matrix of $x$ and $d \ll D$ is the dimensionality of our embedding.

These assumptions lead us to the following definition:

**Definition 1 (Principal Components of $x$).**
The $d$ principal components (PCs) of $x$ are a set of mutually uncorrelated[^3] random variables $\vec{y} \in \mathbb{R}^d$ defined as

$$y_i = \langle u_i, x \rangle \in \mathbb{R},\quad u_i \in \mathbb{R}^D \text{ and } \lVert u_i \rVert_2 = 1,\quad i=1,\dots,d \,,$$

such that the variance of $y_i$ is maximized subject to

$$\mathrm{Var}(y_1) \geq \cdots \geq \mathrm{Var}(y_d) > 0 \,.$$

[^3]: That is, $\mathrm{cov}(y_i, y_j) = 0$ for all $i \neq j$.

We can derive an important characterization of the PCs from this definition:

**Lemma 1.** $\mathrm{Var}(y_i) = u_i^*\Sigma_x u_i \,.$
\
*Proof:*
This follows from the definition of variance:

\begin{align*}
    \mathrm{Var}(y_i)
    &= \mathbb{E}[y_i^2] - \cancel{\mathbb{E}[y_i]^2} &&\text{(Given $\mathbb{E}[x] = 0$.)} \\
    &= \mathbb{E}[u_i^* x u_i^* x] &&\text{(By definition of $y_i$.)} \\
    &= \mathbb{E}[u_i^* x x^* u_i] &&\text{(The dot product is commutative.)} \\
    &= u_i^* \mathbb{E}[x x^*] u_i &&\text{(Expectation is linear.)} \\
    &= u_i^*\Sigma_x u_i \,.
\end{align*}

Therefore, we are looking for the vectors $u_i$ that maximize this [quadratic form](https://en.wikipedia.org/wiki/Quadratic_form)!

We need one final result before we can apply the Courant--Fischer Theorem:

**Lemma 2.** The covariance matrix of a random variable is Hermitian.[^4]
\
*Proof:*
$$\Sigma_x^* = (\mathbb{E}[xx^*] - \mathbb{E}[x]\mathbb{E}[x^*])^* = \mathbb{E}[(xx^*)^*] - \mathbb{E}[x^*]\mathbb{E}[(x^*)^*] = \Sigma_x \,.$$

[^4]: A matrix $A$ is Hermitian if $A = A^*$ (i.e., a more general form of symmetry that applies to complex matrices).

## Proving the Courant--Fischer Theorem

The Courant--Fischer Theorem provides a very useful bound on all possible quadratic forms of a Hermtian matrix in a subspace using the eigenvalues of the matrix.

**Theorem 1 (Courant--Fischer).**
Let $A \in M_n$ be a Hermitian matrix with eigenvalues $\lambda_1 \geq \cdots \geq \lambda_n$ and corresponding eigenvectors $u_1, \dots, u_n$.
Then,

$$ \lambda_k =
\min_{\substack{\cal{V} \subseteq \mathbb{C}^n \\ \mathrm{dim}\cal{V} = n-k}}
\max_{\substack{x \in \cal{V}^\perp \\ x \neq \vec{0}}}
\frac{x^* A x}{x^* x} \,. $$

*Proof:*
Because $A$ is Hermitian, it is unitarily diagonalizable. Let $\cal{U} = \mathrm{span}\{ u_1, \dots, u_k \}$. Then, the intersection of $\cal U$ and $\cal V^\perp$ has a dimension of at least $1$.[^5]

[^5]: From the Inclusion-Exclusion Principle: \begin{align*} \dim (\mathcal{U} \cap \mathcal{V^\perp}) &= \dim \cal U + \dim \cal V^\perp - \dim(\cal U \cup \cal V^\perp) \\ &= k + (n - k + 1) - \dim(\cal U \cup \cal V^\perp) \\ &\geq k + (n - k + 1) - n \\ &= 1 \,. \end{align*}

Let $w \in \cal U \cap \cal V^\perp$ and express $ w = \sum_{i=1}^k c_i u_i $ (a linear combination of the first $k$ eigenvectors). Then,

$$ \begin{align*}
    \frac{w^* A w}{w^* w}
    = \frac{\sum_{i=1}^k \lambda_i c_i^2}{\sum_{i=1}^k c_i^2}
    \geq \lambda_k \frac{\sum_{i=1}^k c_i^2}{\sum_{i=1}^k c_i^2}
    = \lambda_k \,,
\end{align*} $$

with equality if $w = u_k \Rightarrow \cal V^\perp = \mathrm{span}\{u_1, \dots, u_{k-1}\} \,.$

**Corollary 1.** As a direct consequence of the Courant--Fischer Theorem, for any matrix $A$ as in Theorem 1,

$$ \lambda_k =
\max_{x \perp \{u_1, \dots, u_{k-1}\}}
\frac{x^* A x}{x^* x} \,. $$

This vastly simplifies the constrained optimization problem presented in Lemma 1 -- no need for Lagrange multipliers!

## Deriving PCA

**Theorem 2 (Principal Component Analysis).**
Given a random variable $x$ with covariance matrix $\Sigma_x \in M_n$ with eigenvalues $\lambda_1 \geq \cdots \geq \lambda_n$ and associated normalized eigenvectors $u_1, \dots, u_n$, the $i$-th principal component of $x$ is

$$ y_i = \langle u_i, x \rangle \,.$$

*Proof:* From Lemma 1, we have that $ \mathrm{Var}(y_i) = u_i^* \Sigma_x u_i \text{ with } \lVert u_i \rVert_2 = 1 $. From the Courant--Fischer Theorem, we have that

$$ \max_{u \in \mathbb{C}^n} \mathrm{Var}(y_1) = \max_{u \in \mathbb{C}^n} \frac{u^* \Sigma_x u}{u^* u} = \lambda_1 \,.$$

That is, the first principal component of $x$ is in the direction of the eigenvector corresponding to the largest eigenvalue.
Recall that, by definition, the principal components are mutually uncorrelated.
This implies that, unless $\Sigma_x$ is the zero matrix, $\lambda_1 > 0 \Rightarrow u_1 \perp u_2$.[^6]

Therefore,

$$ \max_{u \perp \{u_1\}} \mathrm{Var}(y_2) = \max_{u \perp \{u_1\}} \frac{u^* \Sigma_x u}{u^* u} = \lambda_2 \,.$$

By induction, we can show that the uncorrelatedness of the principal components implies the orthogonality of their underlying vectors, continuing to enable use of the Courant--Fischer Theorem. Thus, PCA has been derived!

[^6]: By the definition of uncorrelatedness, \begin{align*} 0 &= \mathrm{Cov}(y_1, y_2) \\ &= \mathbb{E}[u_1^* x u_2^* x] \\ &= \mathbb{E}[u_1^* x x^* u_2] \\ &= u_1^* \mathbb{E}[x x^*] u_2 \\ &= u_1^*\Sigma_x u_2 \\ &= (\Sigma_x u_1)^* u_2 \\ &= \lambda_1 u_1^*u_2 \,. \end{align*}

## Technical Considerations

> What if $\lambda_i$ is complex? Which eigenvalue is "largest" in this case?

It is true that there is no total ordering on the complex numbers (see [here](https://math.stackexchange.com/questions/487997/total-ordering-on-complex-numbers)), so there would be no "largest" eigenvalue, as such... However, we have shown that $\Sigma_x$ is Hermitian, so $\sigma(\Sigma_x) \subseteq \mathbb{R}\,.$[^7]

[^7]: This is because Hermitian matrices are unitary diagonalizable, and the diagonal matrix, which is comprised of the eigenvalues, is itself Hermitian.

> Okay, but what if $\lambda_i < 0$? That wouldn't be a valid variance.

Any covariance matrix $\Sigma_x$ is positive semi-definite,[^8] so we also know that the eigenvalues of $\Sigma_x$ are non-negative, i.e., $\sigma(\Sigma_x) \subseteq \mathbb{R}_{\geq 0}\,.$

[^8]: For any vector $z \neq \vec{0}$, \begin{align*} z^* \Sigma_x z &= \mathbb{E}[z^* xx^* z] - \mathbb{E}[z^* x]\mathbb{E}[x^* z] \\ &= \mathbb{E}[(z^* x)^2] - \mathbb{E}[z^* x]^2 \\ &= \mathrm{V}(z^* x) \\ &\geq 0 \,. \end{align*}

> What happens if $\lambda_i = \lambda_j$ for $i \neq j$?

Recall that $\Sigma_x$ is Hermitian, and therefore is unitarily diagonalizable. This implies that every eigenvalue of $\Sigma_x$ has equal geometric and algebraic multiplicities.[^9] Therefore, for repeated eigenvalues, we can pick any orthonormal eigenvectors from the eigenspace of $\lambda = \lambda_i = \lambda_j$, meaning the PCs are defined only up to a rotation.

[^9]: This follows from the Jordan Canonical Form!