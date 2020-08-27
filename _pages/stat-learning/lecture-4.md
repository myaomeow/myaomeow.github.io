---
permalink: /stat-learning/lecture-4/
author_profile: false
title: "Linear Algebra of Linear Regression"
toc: true
toc_label: "Contents"
---

_The link to the full 77-minute lecture can be found [here](https://www.youtube.com/watch?v=DjIgj2vJ1nw)._

This lecture assumes that you have a background in some of the fundamental concepts of linear algebra, including (but not limited to) the [rank](https://en.wikipedia.org/wiki/Rank_(linear_algebra)), [kernel](https://en.wikipedia.org/wiki/Kernel_(linear_algebra)), and [image](https://staff.csie.ncu.edu.tw/chia/Course/LinearAlgebra/sec3-1.pdf) of matrices, the [fundamental theorem of algebra](https://en.wikipedia.org/wiki/Fundamental_theorem_of_linear_algebra), [linear dependence vs. independence](https://en.wikipedia.org/wiki/Linear_independence), [positive definite and positive semidefinite](https://en.wikipedia.org/wiki/Definite_symmetric_matrix) matrices, and the [inverse](https://en.wikipedia.org/wiki/Invertible_matrix) (and [pseudo-inverse](https://mathworld.wolfram.com/Pseudoinverse.html)) of matrices, among other topics. Check on the links above for quick reviews of these important topics.

Our goal for this lecture is to dive more in-depth into the linear regression method.

> ## Residual Sum of Squares

Suppose we want to predict $Y\in\mathbb{R}$ based on inputs (_predictors_) $X_1, \ldots, X_p$. Our prediction is $\hat{Y}=f(X)\approx Y$. In linear regression, we are assuming that $f(X)$ takes on the very specific linear form $$f(X)=\beta_0+\sum_{j=1}^p \beta_jX_j=X^T\beta$$, where

$$X=\begin{bmatrix} 1 \\ X_1 \\ \vdots \\ X_p\end{bmatrix}, \quad \beta=\begin{bmatrix} \beta_0 \\ \beta_1 \vdots \\ \beta_p \end{bmatrix}$$

Here, $\beta$ is our vector of unknown parameters or coefficients. The inputs $X_1, \ldots, X_p$ can come from different sources, such as:

  - Quantitative inputs $X_j\in\mathbb{R}$
  - Transformations of quantitative inputs $X_j=\log \tilde{X}_j$, $X_j=e^{\tilde{X}_j}$, etc.
  - Basic expansions, such as $X_2=X_1^2$, $X_3=X_1^3$, $\ldots$, $X_p=X_1^p$. This is especially useful if you don't think that the data is actually linear by eye-balling it, but still want to use linear regression methods.
  - Interactions between inputs, such as $X_1$, $X_2$, $X_3=X_1X_2$.
  - Dummy coding of categorical inputs. For example, if $\xi$ has 3 categories (say, red, blue, and green), then we can create $X_1$, $X_2$, $X_3$ to represent $\xi$:

$$ X_1=\begin{cases} 1, \quad \text{if }\xi=\text{red}, \\ 0, \quad \text{otherwise}\end{cases}, \quad X_2=\begin{cases} 1, \quad \text{if }\xi=\text{blue}, \\ 0, \quad \text{otherwise}\end{cases}, \quad X_3=\begin{cases} 1, \quad \text{if }\xi=\text{green}, \\ 0, \quad \text{otherwise}\end{cases}$$

Note that in this last example, we cannot simply define a single dummy variable $X_1$ that equals, say, 0 when $\xi$ is red, 1 when $\xi$ is blue, and 2 when $\xi$ is green. This is because such a method artificially defines an implicit ordering between the three different categories that is actually not representative of our system. For example, according to this system, red and green would be "more different" (meaning their corresponding $X_1$ values are further away from one another) then red and blue, but in actuality, we don't want to have such an ordering.

The linear regression model is called "linear" because it is linear in its parameters $\beta_0, \beta_1, \ldots, \beta_p$. When we introduced linear regression in [Lecture 2](/stat-learning/lecture-2/index.html), we found that using the mean square error loss function, it was true that

$$\beta=\mathbb{E}[XX^T]\mathbb{E}[XY]$$

This column vector of parameters could be estimated according to the following definitions:

$$\hat{\beta}=(\mathbb{X}^T\mathbb{X})^{-1}\mathbb{X}^Ty, \quad \mathbb{X}=\begin{bmatrix} 1 & x_{11} & \cdots & x_{1p} \\ \vdots & \vdots & \vdots & \vdots \\ 1 & x_{N1} & \cdots & x_{Np} \end{bmatrix}, \quad y=\begin{bmatrix} y_1 \\ \vdots \\ y_N\end{bmatrix}$$

As we will see, it is instructive to see how $\beta$ can be estimated _directly_ from the training data using the **residual sum of squares**, which is defined as

$$\text{RSS}(\beta)=\sum_{i=1}^N (y_i-x_i^T\beta)^2$$

As always, our goal is to minimize this quantity. $\text{RSS}$ is essentially a finite sample version of the $\text{MSE}$, up to a factor of $1/N$ which is irrelevant for minimization. Through considerations using the residual sum of squares, we can optimize the vector of parameters $\beta$ directly from the training data.

Geometrically, the $\text{RSS}$ is an intuitive measure of the _quality_ of the linear fit to the data. For example, if $\text{RSS}(\beta_1)<\text{RSS}(\beta_2)$, then this means that the linear fit corresponding to $\beta_1$ is better. Let is denote $\hat{\beta}$ to be the value of $\beta$ that minimizes the $\text{RSS}$: $\hat{\beta}=\arg \min_{\beta\in\mathbb{R}^{p+1}}\text{RSS}(\beta)$. Note that if there are multiple possible values of $\beta$ that each individually minimize the residual sum of squares, then $\hat{\beta}$ could actually represent a set of solution $\beta$ column vectors. $\hat{\beta}$ has important linear algebraic interpretation. To derive this, let's rewrite the $\text{RSS}$ in matrix form:

$$\text{RSS}(\beta)=\vert\vert y=\mathbb{X}\beta \vert \vert^2$$

Here, the $\vert\vert$ operator corresponds to the Euclidian norm. Therefore, we can see that since the square is minimized when the magnitude of the square root is minimized, then we can also define $\hat{\beta}$ as 

$$\hat{\beta}=\arg \min_{\beta\in\mathbb{R}^{p+1}} \vert \vert \mathbb{X}\beta-y\vert \vert$$

In other words, $\hat{\beta}$ is a solution of the _linear system_ $\mathbb{X}\beta=y$ in the least squares sense. This interpretation of $\hat{\beta}$ allows us to conclude that a **global minimizer of $\text{RSS}$ exists**, since linear systems always have least squares solutions from our knowledge of linear algebra. A sketch of the proof for this is linked [here](https://youtu.be/DjIgj2vJ1nw?t=939).

> ## Normal Equation


> ## Ordinary Least Squares