---
layout: post
excerpt_separator: <!--more-->
title: A Quick Formulation of Compressed Sensing
description: A very, very mininal derivation of the optimization
permalink: compressed-sensing/
date: 2021-12-27
---

Compressed sensing is a singal processing method for reconstructing a signal from an undersampled set of measurements.
Here, we will derive the optimization problem at the core of compressed sensing.

- Let $$x$$ be the true signal.
- Let $$x \stackrel{\mathcal U}{\mapsto} s$$ be the representation of $$x$$ in a functional basis space.
- Let $$x = \Psi s$$ for some universal transform basis $$\Psi$$ (e.g., Fourier, wavelet, etc.).
- Let $$y = Cx$$ be the *measured* signal, where $$C$$ is the measurement matrix.

Our objective is to obtain a *subsampled* version of $$s$$ from $$y$$, and then recover $$s \stackrel{\mathcal U^{-1}}{\mapsto} x$$,
i.e.,
\begin{equation}
    \min_s \frac{1}{2} ||y - C\Psi s||_2^2 \,. \tag{Opti 0}
\end{equation}

As stated, this optimization is a underspecified / indeterminate problem (i.e., there are infinitely many solutions for $$s$$),
so we constrain the solutions to be sparse:
\begin{equation}
    \min_s \frac{1}{2} ||y - C\Psi s||_2^2 + \lambda||s||_0 \,. \tag{Opti 1}
\end{equation}

However, minimizing $$l_0$$ norms is NP hard,<span class="sidenote-number"></span>
<span class="sidenote">
    Because it requires combinatorial optimization.
</span> so we relax the problem with the $$l_1$$ norm:
\begin{equation}
    \min_s \frac{1}{2} ||y - C\Psi s||_2^2 + \lambda||s||_1 \,. \tag{Opti 2}
\end{equation}

This is a well-defined problem, and is solvable with linear programming (e.g., basis pursuit, denoising/matching).
Additionally, Optimization 2 is equivalent to Optimization 1 under certain conditions (e.g., $$\nu$$-incoherence) and constraints on $$C\Psi$$.
Then, given a noisy, downsampled measurement $$y$$, solve Optimization 2 to get $$\hat s$$, and predict the original signal to be $$\hat x = \Psi \hat s$$ which is equivalent to $$\hat s \stackrel{\mathcal U^{-1}}{\mapsto} \hat x$$.
