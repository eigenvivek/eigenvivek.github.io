# The Conjugate Gradient Method
2022-07-06 | *Geometric underpinnings, eigenvalues, and the convergence rate*

The goals of this post are:[^1]

1. To derive the conjugate gradient method,
2. Implement and benchmark various versions with Julia, and
3. Explain the connection between eigenvalues and the convergence rate.

The code in this post can be viewed in a Jupyter Notebook [here](https://nbviewer.org/github/eigenvivek/eigenvivek.github.io/blob/main/_assets/notebooks/conjugate_gradient.ipynb).

[^1]: Notes from the Medical Vision Group's summer reading of *Numerical Optimization* by J. Nocedal, Stephen J. Wright, 1999.

## Setup

The goal of the conjugate gradient algorithm is to iteratively solve linear systems of the form $Ax = b \,$
where **we assume that $A \in M_n(\mathbb R)$ is symmetric positive definite.**[^2]
It turns out that solving such a linear system is equivalent to minimizing the quadratic form

$$f(x) = x^TAx - b^Tx + c \,.$$

To see this, look at its gradient:

$$\nabla f(x) = Ax - b \,.$$

The gradient equals zero exactly at the $x=x^*$ that minimizes the the residual of the linear system $r(x^*) = Ax^* - b\,.$[^3]
Additionally, the Hessian matrix of $f$ is $A$, which is positive definite, so it has exactly one optimum, which is a minumum!

[^2]: This may seem to be a strong assumption, but we will soon show how to bypass this for any general rectangular matrix.
[^3]: We will write that the $k$-th iterate $x_k$ has a residual of $r_k = \nabla f(x_k) = Ax_k - b \,.$

To minimize the quadratic form, we *could* use steepest descent, which is gradient descent where you take the largest step possible to minimize the loss.
However, for certain linear systems, gradient descent converges very slowly (*slowly* here means that the number of steps needed for convergence is $\gg n$, the dimension of $A$).
Instead, conjugate gradient gives an iterative optimization that is guaranteed to converge in at most $n$ steps...[^4]

[^4]: ...in exact arithmetic -- floating point accuracy means it can take a little longer, but it's still faster than gradient descent.

## Understanding conjugacy

In essence, the conjugate gradient method is simply a change of basis.
However, the basis we seek is very special:
specifically, we are looking for a set of basis vectors that are *conjugate* with respect to $A$.
Two vectors $u$ and $v$ are conjugate if they satisfy a special kind of orthogonality:

$$ u^T A v = v^T A v = 0 \,.$$

This means that after $u$ (or $v$) is transformed by $A$, it is orthogonal to $v$ (or $u$).
This basis is very useful for finding the solution to a linear system, as we'll show below.
First, a quick lemma:

### Linear independence of conjugate vectors

**Lemma 1.** If $u$ and $v$ are conjugate with respect to $A$, then they are also linearly independent.
\
*Proof:* Suppose, by way of contradiction, $u$ and $v$ are not linearly independent. Then, there exists some non-zero constant $k$ such that $u = kv$. This implies $0 = u^TAv = kv^TAv \Longrightarrow v^TAv = 0$. However, this is a contradiction because $A$ positive definite means $v^TAv > 0 \,. $

By induction, we can also show that a set of conjugate vectors are linearly independent.

### Conjugate directions method

Suppose that we have a conjugate basis $\{p_1, \dots, p_n\}$ with respect to $A$.
Since these vectors are linearly independent, we can express $x^*$ as

$$ x^* = \alpha_1 p_1 + \cdots + \alpha_n p_n \Longrightarrow Ax^* = b = \alpha_1 Ap_1 + \cdots + \alpha_n Ap_n \,. $$

Premultiplying by the vector $p_k$, we see that

$$ p_k^T b = \alpha_k p_k^T A p_k \,, $$

since the other terms cancel out by conjugacy! Therefore, we have that the coefficients are

$$ \alpha_k = \frac{p_k^T b}{p_k^T A p_k} \,, $$

which are all quantities we know how to compute. That is, changing our basis to a conjugate one makes it very easy to solve a linear system.

This simple results tells us two important facts:

1. If we have a procedure that produces a conjugate basis vector at each step, we can solve a linear system in at most $n$ steps.
2. If we have a set of conjugate basis vectors for $A$, it is trivial to solve a linear system. The brilliance of the conjugate gradient method is in how we find these vectors.

### Visualizing conjugate directions and condition number

Before discussing the generating procedure, it's useful to visualize conjugacy and our loss landscape.

Since we are working with positive definite matrices, it's useful to have a function to randomly generate them.
The procedure we use leverages the fact that $A^T A$ is gauranteed to be a positive semidefinite matrix (use the definition of positive semidefiniteness to prove this).[^5]
Therefore, we almost always generate a positive definite matrix by samping a random square matrix and premultiplying it by its transpose.

```julia
function random_psd(n::Int64=2)
    A = randn(n, 2)
    return A' * A
end
```

[^5]: Note that $A^T A$ is positive semidefinite if and only if $\mathrm{rank}(A) < n$, and the probability of this happening is very small.

Next, we plot the level sets of the quadratic form defined by our positive definite $A$.
That is, we visualize multiple elliptical curves along which $x^TAx = c$ for some constant $c$.
These let us visualize the loss landscape we are trying to optimize.

The final concept we will discuss with these curves is the **condition number**. The condition number is the ratio between the largest and smallest eigenvalues. When this number is small (i.e., closer to 1), the closer the ellipses are to a circle (*left*). This corresponds to a system that is more amenable to gradient descent: you can pick any direction to descent and make good progress. For a system with a large condition number (*right*), some directions are much more fruitful than others. This means gradient descent can take a very long time if you choose a poor starting point for the optimization.

![conjugate-gradient-ellipses](../../assets/images/conjgrad_ellipses.svg)

## Deriving the conjugate gradient method

Here, we derive conjugate gradient as an iterative method.
Note, the first search direction $p_0 = -r_0$ since it is the negative gradient.

### Finding the optimal step size $\alpha_k$

Assume we start at some point $x_0$.
For a set of conjugate directions $\{p_0, \dots, p_k\}$, we define the update function as

$$ x_{k+1} = x_k + \alpha_k p_k \,, \quad\quad\text{(Eq. 1)}$$

where $\alpha_k$ is the length that optimally descends $p_k$.
To find $\alpha_k$, we define $g(\alpha_k) = f(x_k+\alpha_kp_k)$, so that when

$$
\frac{\partial g}{\partial \alpha_k}
= (x_k + \alpha_kp_k)^TAp_k - b^Tp_k
= x_k^TAp_k + \alpha_kp_k^TAp_k - b^Tp_k
= 0 \,, $$

we have that

$$\alpha_k = \frac{p_k^T(b-Ax_k)}{p_k^TAp_k} = -\frac{p_k^Tr_k}{p_k^TAp_k} \,. $$

### Finding the next search direction $p_k$

We define the new search direction as $p_k = -r_k + \beta_kp_{k-1}$.
Premultiplying by $p_{k-1}^TA$ yields

$$ p_{k-1}^TAp_k = -p_{k-1}^TAr_k + \beta_kp_{k-1}^TAp_{k-1} \,, $$

where the LHS cancels to zero because of conjugacy.
Solving for $\beta_k$ yields

$$ \beta_k = \frac{p_{k-1}^TAr_k}{p_{k-1}^TAp_{k-1}} \,. $$

With this, we can implement the most basic version of conjugate gradient.

```julia
function slow_conjgrad(
    A::Matrix{Float64},  # Constraint matrix
    b::Vector{Float64},  # Target
    x::Vector{Float64};  # Initial guess
    tol::Float64=10e-6   # Tolerance for early stop criterion
)
    k = 1
    r = A * x - b
    p = -r
    while norm(r) > tol
        Ap = A * p  # Avoid recomputing a matrix-vector product
        α = -(r' * p) / (p' * Ap)
        x = x + α * p
        r = A * x - b
        β = (r' * Ap) / (p' * Ap)
        p = -r + β * p
        k += 1
    end
    return x, k
end
```

## Optimizing the conjugate gradient method

We can exploit properties of our vectors to make the above algorithm faster.

First, we characterize an interesting property of the residuals, $r_k$.
Premulitplying (Eq. 1) by $A$ and subtracting $b$ from both sides yields

$$ r_{k+1} = r_k + \alpha_kAp_k \,. \quad\quad\text{(Eq. 2)} $$

If we look at the first iterate, we see

$$
\begin{align*}
r_1^Tp_0
&= r_0^T p_0 + \alpha_0p_0^TAp_0 \\
&= r_0^T p_0 + \left(-\frac{p_0^Tr_0}{p_0^TAp_0}\right)p_0^TAp_0 \\
&= \vec 0 \,,
\end{align*}
$$

so, by induction, we can show that $r_k^Tp_i = 0$ for all $i=0,\dots,k-1$.
That is, the residual is orthogonal to all previous search directions!

### Simplifying $\alpha_k$

Premultiply the search direction update by the residual, $r_k \,:$

$$ -p_k^Tr_k = (-r_k)^T(-r_k) + \beta_k(-r_k)^Tp_{k-1} = r_k^Tr_k \,, $$

since the residual $r_k$ and search direction $p_{k-1}$ are orthogonal.
Therefore, we can simplify the calculation of $\alpha_k \,:$

$$ \alpha_k = -\frac{p_k^Tr_k}{p_k^TAp_k} = \frac{r_k^Tr_k}{p_k^TAp_k} \,. $$

### Simplifying $\beta_k$

We get the simplification in two steps

1. $ \alpha_kAp_k = r_{k+1} - r_k \Longrightarrow \alpha_kr_{k+1}^TAp_k = r_{k+1}^Tr_{k+1} + r_{k+1}^Tr_k = r_{k+1}^Tr_{k+1} $ since residuals are mutually orthogonal.
2. $ \alpha_k p_k^TAp_k = \left(\frac{r_k^Tr_k}{p_k^TAp_k}\right) p_k^TAp_k = r_k^Tr_k $.

Then,

$$ \beta_{k+1} = \frac{p_{k}^TAr_{k+1}}{p_{k}^TAp_{k}} = \frac{\alpha_kp_{k}^TAr_{k+1}}{\alpha_kp_{k}^TAp_{k}} = \frac{r_{k+1}^Tr_{k+1}}{r_k^Tr_k} \,. $$

This yields the most widely used form of the conjugate gradient method. We also store a few products at each iteration to optimize the implementation.

```julia
function fast_conjgrad(
    A::Matrix{Float64},  # Constraint matrix
    b::Vector{Float64},  # Target
    x::Vector{Float64};  # Initial guess
    tol::Float64=10e-6   # Tolerance for early stop criterion
)
    k = 1
    r = b - A * x
    p = r
    rsold = r' * r  # Avoid recomputing a vector-vector product
    while sqrt(rsold) > tol
        Ap = A * p  # Avoid recomputing a matrix-vector product
        α = rsold / (p' * Ap)
        x += α * p
        r -= α * Ap
        rsnew = r' * r
        if sqrt(rsnew) < tol  # Add an early-stop condition
            break
        end
        β = rsnew / rsold
        p = r + β * p
        rsold = rsnew
        k += 1
    end
    return x, k
end
```

## Benchmarking versions of the conjugate gradient method

Finally, we can benchmark these two versions of the conjugate gradient method.
Additionally, we will compare against a barebones implementation of gradient descent with line search:

```julia
function grad_descent(
    A::Matrix{Float64},  # Constraint matrix
    b::Vector{Float64},  # Target
    x::Vector{Float64};  # Initial guess
    tol::Float64=10e-6   # Tolerance for early stop criterion
)
    k = 1
    r = A * x - b
    rsquared = r' * r  # Avoid recomputing a vector-vector product
    while sqrt(rsquared) > tol
        α = -(rsquared) / (r' * A * r)
        x = x + α * r
        r = A * x - b
        rsquared = r' * r
        k += 1
    end
    return x, k
end
```

To benchmark these algorithms, we will solve a linear system where the $A \in M_n$ matrix is the Hilbert matrix,[^6] the target is $b = (1, \dots, 1)^T$, and the initial guess is $x = (0, \dots, 0)^T$.
We compare the number of iterations required for the slow conjugate gradient, fast conjugate gradient, and standard gradient descent method ($k_1$, $k_2$, and $k_3$ respectively), as well as the memory requirements, for different matrix dimensions $n \in \{2, 4, 6\}$.

[^6]: That is $(A)_{i,j} = {1}/({i + j - 1}) \,.$

```
n = 2
κ(A(n)) = 19.28
  595.201 ns (22 allocations: 1.73 KiB)
  446.126 ns (17 allocations: 1.34 KiB)
  5.812 μs (200 allocations: 15.64 KiB)
(k₁, k₂, k₃) = (3, 2, 40)
n = 4
κ(A(n)) = 15513.74
  1.071 μs (38 allocations: 3.66 KiB)
  814.062 ns (31 allocations: 3.00 KiB)
  6.203 ms (201280 allocations: 18.43 MiB)
(k₁, k₂, k₃) = (5, 4, 40256)
n = 6
κ(A(n)) = 1.495105864e7
  2.583 μs (70 allocations: 7.91 KiB)
  1.842 μs (59 allocations: 6.70 KiB)
  5.621 s (136467940 allocations: 14.23 GiB)
(k₁, k₂, k₃) = (9, 8, 27293588)
```

The fast conjugate gradient method is requires fewer iterations to achieve convergence and less memory allocation.
Additionally, the standard gradient descent method requires an absurd number of iterations for a poorly conditioned matrix!

To get a better comparison between the slow and fast versions of conjugate gradient method, we will use a larger matrix. However, any larger will take gradient descent too long, so we only compare our versions of conjugate gradient with $n \in \{5, 8, 12, 20 \} \,.$

```
n = 5
κ(A(n)) = 476607.25
  1.650 μs (54 allocations: 5.22 KiB)
  1.225 μs (45 allocations: 4.38 KiB)
(k₁, k₂) = (7, 6)
n = 8
κ(A(n)) = 1.525756434817e10
  7.417 μs (198 allocations: 25.19 KiB)
  4.238 μs (136 allocations: 17.44 KiB)
(k₁, k₂) = (25, 19)
n = 12
κ(A(n)) = 2.2872145734707476e16
  12.459 μs (262 allocations: 42.00 KiB)
  5.389 μs (143 allocations: 23.41 KiB)
(k₁, k₂) = (33, 20)
n = 20
κ(A(n)) = 4.377151386345373e16
  50.333 μs (638 allocations: 142.59 KiB)
  12.667 μs (234 allocations: 54.22 KiB)
(k₁, k₂) = (80, 33)
```

At these larger sizes of $A$, the advantage of fast conjugate gradient is clearly appreciable!

## The convergence rate and eigenvalue properties

TODO :)

<!-- There are many analyses of the convergence rate of conjugate gradient, which show that the convergence rate is $\mathcal O(\sqrt{\kappa(A)})$, where $\kappa(A)$ is the condition number of $A$.
This is more efficient than the standard gradient descent method, which requires $O(\kappa(A))$ iterations.

In addition to being faster than standard gradient descent, conjugate gradient also has an advantage when the eigenvalues of $A$ have a special structure.
Specifically, if $A$ has eigenvalues $0 < \lambda_1 \leq \cdots \leq \lambda_n $, we have that

$ ||x_{k+1} - x^*||_A^2 \leq \left(\frac{\lambda_{n-k} - \lambda_1}{\lambda_{n-k} + \lambda_1}\right)^2 ||x_0 - x^*||_A^2 \,. $

This says that the bound on the decrease in error on the $(k+1)$-th iterate is proportional to the ratio $\left(\frac{\lambda_{n-k} - \lambda_1}{\lambda_{n-k} + \lambda_1}\right)^2$.
By the triangle inequality, we have that

$$
\left(\frac{\lambda_{n-k} - \lambda_1}{\lambda_{n-k} + \lambda_1}\right)^2
= \left(\frac{\lambda_{n-k} - \lambda_{n-k-1}}{\lambda_{n-k} + \lambda_{n-k-1}}\right)^2
- \left(\frac{\lambda_{n-k-1} - \lambda_1}{\lambda_{n-k-1} + \lambda_1}\right)^2
$$ -->