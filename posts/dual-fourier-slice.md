# Dual of the Fourier Slice Theorem
2022-12-25 ☾ *Swapping slices and projections and spaces and frequencies*

The Fourier Slice Theorem is a classical result in signal processing result that establishes an equivalence between projections in the spatial domain and slices in the frequency domain. It's very useful for image reconstruction tasks, particularly in medical imaging (e.g., reconstructing 3D CT and MRI volumes from 2D images).

## The Fourier Slice Theorem

In 3D volume of data $\mathbf V : \mathbb R^3 \mapsto \mathbb R$, the Fourier Slice Theorem states that (the Fourier transform of a projection of $\mathbf V$) is equal to (an orthogonal slice of the Fourier transform of $\mathbf V$).[^1]

[^1]: **Theorem 1 (Fourier Slice Theorem).** $p_\theta(\mathbf V) = \mathcal F^{-1} \circ S_{\theta^\perp} \circ \mathcal F(\mathbf V)$ where $p_\theta(\cdot)$ is a projection in the spatial domain via rays at angle $\theta$, $S_{\theta^\perp}(\cdot)$ is an orthogonal slice in the frequency domain at angle $\theta^\perp$, and $\mathcal F(\cdot)$ is the Fourier transform.

For illustration, we provide a proof of the Fourier Slice Theorem in 2D, although these ideas can be generalized to arbitrary dimensions.

Simplifications:
- The Fourier transform is equivariant to rotation,[^2] so we can assume $\theta = 0$ (i.e., we are projecting onto the $x$-axis) without loss of generality.
- Projection onto the $x$-axis is invariant to the $y$-intercept, so we can assume $y = 0$ without loss of generality.

[^2]: $\mathcal F \circ R = R \circ \mathcal F$ where $R$ is a rotation matrix.

Preliminary objects:
- Let $f : \mathbb R^2 \to \mathbb R$ be a continuous representation of 2D image.
- Let $p(x) = \int_{\mathbb R} f(x, y) \mathrm{d}y$ be the projection of $f$ onto the $x$-axis.
- $F(k_x, k_y) = \iint_{\mathbb R^2} f(x,y) e^{-2\pi i (xk_x + yk_y)} \mathrm{d}x \mathrm{d}y$ is the 2D Fourier transform of $f$.

Using these definitions, we can derive
\begin{align*}
    S(k_x)
    &= F(k_x, 0) \\
    &= \iint_{\mathbb R^2} f(x,y) e^{-2\pi i (xk_x + y\cancel{k_y})} \mathrm{d}x \mathrm{d}y \\
    &= \int_{\mathbb R} \left( \int_{\mathbb R} f(x, y) \mathrm{d}y \right) e^{-2\pi i xk_x} \mathrm{d}x \\
    &= \int_{\mathbb R} p(x) e^{-2\pi i xk_x} \mathrm{d}x \\
    &= P(k_x) \,,
\end{align*}
where $P(\cdot)$ is the Fourier transform of the projection $p(\cdot)$.
This establishes the 2D version of the Fourier Slice Theorem.


## Dual of the Fourier Slice Theorem

Using the same machinery, we can derive a dual of the Fourier Slice Theorem with projection in the frequency domain and slicing in the spatial domain.[^3]

[^3]: **Theorem 2 (Dual of the Fourier Slice Theorem).** $P_\theta(\mathbf V) = \mathcal F^{-1} \circ P_{\theta^\perp} \circ \mathcal F(\mathbf V)$.

Preliminary objects:
- Let $P(k_x) = \int_{\mathbb R} F(k_x, k_y) \mathrm{d}k_y$ be the projectino of $F$ onto the $k_x$-axis.
- $f(x, y) = \iint_{\mathbb R^2} F(k_x, k_y) e^{2\pi i (xk_x + yk_y)} \mathrm{d}k_x \mathrm{d}k_y$ be the 2D inverse Fourier transform of $F$.

Similarly, we can derive
\begin{align*}
    s(x)
    &= f(x, 0) \\
    &= \iint_{\mathbb R^2} F(k_x, k_y) e^{2\pi i (xk_x + \cancel{y}k_y)} \mathrm{d}k_x \mathrm{d}k_y \\
    &= \int_{\mathbb R} \left( \int_{\mathbb R} F(k_x, k_y) \mathrm{d}k_y \right) e^{2\pi i xk_x} \mathrm{d}k_x \\
    &= \int_{\mathbb R} P(k_x) e^{2\pi i xk_x} \mathrm{d}k_x \\
    &= p(x) \,,
\end{align*}
where $s(\cdot)$ is the inverse Fourier transform of $S(\cdot)$.
This establishes a duality for slicing and projection in the spatial and frequency domains, respectively.


## Etymological Implications

The most immediate utility of this result is in helping to unify the meaning of *tomography*. By Wikipedia's definition,[^4]

> The word **tomography** is derived from Ancient Greek τόμος tomos, "slice, section" and γράφω graphō, "to write" or, in this context as well, "to describe."

[^4]: https://en.wikipedia.org/wiki/Tomography

In modern engineering, tomography refers to the acquisition of image slices via a penetrating wave. It encompasses many modalities beyond medical imaging, such as sonar and radar.
However, within medical imaging, many modalities that do not involve slicing are often referred to as tomographic, such as X-ray imagign and CT.
The Fourier Slice Theorem and the dual proved herein can help to unify these definitions.

- **X-ray:** The Fourier Slice Theorem shows that X-ray projections in the spatial domain are equivalent to orthogonal slices in the frequency domain. Slicing = tomography!
- **CT:** CTs are reconstructed from multiple X-ray images acquired at different angles, so therefore, they are also tomographic.
- **MRI:** MRI machines acquire slices of the frequency domain, so they too are tomographic.
- **Ultrasound:** Acoustic waves are used to acquire slices of the spatial domain in ultrasound. The dual theorem shows that these slices are equivalent to projections in the frequency domain.

In this way, the Fourier Slice Theorem can help to unify the meaning of tomography across many modalities.