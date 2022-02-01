---
layout: post
excerpt_separator: <!--more-->
title: Graph Cuts and Cheeger's Inequality
description: Another interesting eigenvalue application.
permalink: graph-cuts/
date: 2022-01-31
---

## Spectral Properties of the Graph Laplacian

**Definition 1 (The Graph Laplacian).**
The graph Laplacian is a matrix representation of graph as $$L = D - A$$ where $$D$$ is the degree matrix and $$A$$ is the adjacency matrix of the graph.

**Theorem 1.** A graph Laplacian has eigenvector $$\vec 1$$ with eigenvalue 0.
\
*Proof:* $$L \vec 1 = (D - A) \vec 1 = D \vec 1 - A \vec 1 = \vec 0$$.

**Corollary 1.** For a complete graph $$G$$, any vector perpendicular to $$\vec 1$$ is also an eigenvector of the graph Laplacian. \
\
*Proof:* 
Since $$G$$ is complete, the graph Laplacian can be written as $$(n-1)I - (\mathbf 1 - I) = nI - \mathbf 1$$.<span class="sidenote-number"></span>
<span class="sidenote">
    WLOG, assume $$G = (V, E)$$ and $$|V| = n$$.
</span>
If $$v \perp \vec 1$$, then $$\require{cancel}L v = nIv - \cancelto{0}{\mathbf 1 v} = nv$$.
