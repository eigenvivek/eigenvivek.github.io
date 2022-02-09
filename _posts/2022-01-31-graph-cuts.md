---
layout: post
excerpt_separator: <!--more-->
title: Graph Cuts, Graph Laplacians, and λ2
description: Another interesting eigenvalue application.
permalink: graph-cuts/
date: 2022-01-31
---

## Defining the Graph Cut Problem

Let $$G = (V, E)$$ be a graph with $$|V| = n$$.
The goal of the graph cut problem is to find a subset of the vertex set $$S \subset V$$ that minimizes the cut ratio<span class="sidenote-number"></span>
<span class="sidenote">
    The cut ratio can be thought of as quantifying the amount of information that is lost when a cut is performed.
    Note, there are many different cost functions one can use to define the graph cut problem.
    For example, if $$|S|$$ is replaced with $$d(S)$$ (the degree of the nodes in $$S$$), the new quantity is called the *conductance* of a cut.
</span>

$$
\begin{equation}
    \phi(S) = \frac{e(S)}{\min\{|S|, |S^c|\}} \,,
\end{equation}
$$

where $$e(S) = e(S^c)$$ is the number of edges connecting $$S$$ and $$S^c$$.

We can encode which subset each vertex belongs to with a binary vector $$x \in \{-1, +1\}^n$$.
Then, $$e(S) = \frac{1}{4} \sum_{(i,j) \in E} (x_i - x_j)^2$$.
With this binary representation, this essentially becomes an integer programming problem!
However, this problem is NP-hard,<span class="sidenote-number"></span> so solving it requires a few relaxations...
<span class="sidenote">
    See [here](https://en.wikipedia.org/wiki/Cut_(graph_theory)#Maximum_cut) for more details.
</span>
Before doing so, it is useful to first define the graph Laplacian and prove a few properties.

## Spectral Properties of the Graph Laplacian

In this context, *spectral* refers to the spectrum of eigenvalues.
To get eigenvalues, we need a matrix.
We can represent a grpah as a matrix using either the adjecency matrix $$A \in M_n(\{0, 1\})$$ and the degree matrix $$D \in M_n(\{0, 1, \dots, n-1\})$$.

**Definition 1 (The Graph Laplacian).**
The graph Laplacian is a matrix representation of graph $$G$$. It is written as $$L_G = D - A$$ where $$D$$ is the degree matrix and $$A$$ is the adjacency matrix of the graph.
Since we assume $$G$$ is undirected, $$A$$ is a symmetric matrix, and therefore, so is $$L_G$$.

**Theorem 1.** A graph Laplacian has eigenvector $$\vec 1$$ with eigenvalue 0.
\
*Proof:* $$L_G \vec 1 = (D - A) \vec 1 = D \vec 1 - A \vec 1 = \vec 0$$.

**Corollary 1.** For a complete graph $$K$$, any vector perpendicular to $$\vec 1$$ is also an eigenvector of the graph Laplacian.
\
*Proof:*
Since $$G$$ is complete, the graph Laplacian can be written as $$L_K = (n-1)I - (\mathbf 1 - I) = nI - \mathbf 1$$
If $$v \perp \vec 1$$, then $$\require{cancel}L_k v = nIv - \cancelto{0}{\mathbf 1 v} = nv$$.
This also proves that the eigenvalue $$1$$ has algebraic multiplicity $$n-1$$.

## Relaxing the Graph Cut Problem

First, note that

$$
\begin{align}
    |S| |S^c|
    &= \left(\sum_{i \in V} \mathbb{1}(x_i = +1)\right) \left(\sum_{j \in V} \mathbb{1}(x_j = -1)\right) \\
    &= \sum_{i, j \in V} \mathbb{1}(x_i = +1)\mathbb{1}(x_j = -1) \\
    &= \frac{1}{2} \sum_{i, j \in V} \mathbb{1}(x_i \neq x_j) \\
    &= \frac{1}{4} \sum_{i < j} (x_i - x_j)^2 \,,
\end{align}
$$

allowing us to rewrite the cut ratio as<span class="sidenote-number"></span>
<span class="sidenote">
    $$\sum_{i < j} = \sum_{j=1}^n \sum_{i=1}^{j-1}$$.
</span>

$$
\begin{equation}
    \phi'(S) = \frac{e(S)}{|S||S^c|} = \frac{\sum_{(i,j) \in E} (x_i - x_j)^2}{\sum_{i < j} (x_i - x_j)^2} \,.
\end{equation}
$$

One very interesting and surprising fact is that the sum of squared pairwise differences in the numerator and denominator of $$\phi'$$ can be written in terms of matrix products using the *graph Laplacian*.<span class="sidenote-number"></span>
<span class="sidenote">
    See Definition 1 in [this section](#spectral-properties-of-the-graph-laplacian).
</span>
Specifically, we can write

$$
\begin{equation}
\sum_{(i,j) \in E} (x_i - x_j)^2 = x^T L_G x
\quad\text{and}\quad
\sum_{i < j} (x_i - x_j)^2 = x^T L_K x \,,
\end{equation}
$$

where $$L_G$$ is the graph Laplacian of $$G$$ and $$L_K$$ is the graph Laplacian of the complete graph on $$V$$.<span class="sidenote-number"></span>
<span class="sidenote">
    To prove this, we can use the fact that every Laplacian can be written as a sum of edge Laplacians, $$L_G = \sum_{(i, j) \in E} L_{ij} = \sum_{(i, j) \in E} (e_i - e_j)(e_i - e_j)^T$$. Then $$x^T L_G x = \sum_{(i, j) \in E} x^T(e_i - e_j)(e_i - e_j)^Tx$$
    $$= \sum_{(i, j) \in E} (x_i - x_j)^2 \,.$$
    Note that this also proves that the Laplacian is positive semi-definite.
</span>

This, along with the fact
$$\begin{equation}
    \min\{|S|, |S^c|\} \geq |S| |S^c| \geq \frac{1}{2} \min\{|S|, |S^c|\} \,,
\end{equation}$$
allows us to bound this re-expressed cut ratio:

$$
\begin{equation}
    \phi(S) \leq \phi'(S) \leq 2 \phi(S) \,.
\end{equation}
$$

While removing the $$\min$$ in the denominator makes $$\phi'$$ a convex objective, the minimization problem is still NP-hard because of the support of $$x$$.
We can further relax the problem by letting $$x \in \mathbb{R}^n$$ since we can threshold the values of $$x$$ to make it binary.
Then, note that WLOG, we can also assume that $$\sum_{i = 1}^n x_i = 0$$ since we could arbitrarily shift $$x$$ however we wanted.<span class="sidenote-number"></span>
<span class="sidenote">
    This innocuous constraint also buys us $$x \perp \vec 1$$. To see this, think about the sum in terms of a dot product.
</span>
Therefore, our final optimization problem is

$$
\begin{equation}
    \min_\stackrel{x \in \mathbb R^n}{x \perp \vec 1} \frac{x^T L_G x}{x^T L_K x} \,.
\end{equation}
$$

To solve this elegantly, we will appeal to classical properties of the graph Laplacian.

## Solving the Graph Cut Relaxation

Since we can assume that $$x \perp \vec 1$$, Corollary 1 allows us to rewrite our optimization problem as

$$
\begin{equation}
    \min_\stackrel{x \in \mathbb R^n}{x \perp \vec 1} \frac{x^T L_G x}{x^T L_K x}
    =
    \frac{1}{n} \min_\stackrel{x \in \mathbb R^n}{x \perp \vec 1} \frac{x^T L_G x}{x^Tx} \,.
\end{equation}
$$

This bounded quadratic form is present in many optimization problems,
and since the graph Laplacian is symmetric, we can solve it using the Courant--Fischer theorem.<span class="sidenote-number"></span>
<span class="sidenote">
    For background on the Courant--Fischer theorem, see [this derivation of PCA](https://vivekg.dev/pca-courant-fischer/).
    In this proof, we use the variant of Courant--Fischer where the eigenvalues are sorted in ascending order.
    The statement is mostly the same, except the min-max becomes a max-min.
</span>
Specifically, appealing to [Corollary 1 in the PCA derivation](https://vivekg.dev/pca-courant-fischer/),
we can solve $$\min_{x \in \mathbb R^n,\ x \perp \vec 1} \frac{x^T L_G x}{x^Tx} = \lambda_2$$, where $$\lambda_1=0 \leq \lambda_2 \leq \cdots \lambda_n$$ are the eigenvalues of $$L_G$$.
Note that we know the eigenvalues of $$L_G$$ are non-negative because we proved that $$L_G$$ is positive semi-definite in deriving the approximate objective function.

Therefore, the final solution to the graph cut relaxation is

$$\begin{equation}
\min_{S \subset V} \phi'(S) = \frac{\lambda_2}{n} \,.
\end{equation}$$
