---
permalink: /stat-learning/lecture-2/
author_profile: false
title: "Methods in Regression Problems"
toc: true
toc_label: "Contents"
---

_The link to the full 66-minute lecture can be found [here](https://www.youtube.com/watch?v=hTvGbpqaNJA)._

From [last time](/stat-learning/lecture-1/index.html), we learned that in regression problems where the input $X\in\mathbb{R}^p$ and output $Y\in\mathbb{R}$, then the optimal prediction of the output to input $X=x$ is given by the **regression function**:

$$f(x)=\mathbb{E}[Y\vert X=x]$$

This is a nice theoretical result, but in many real-life applications, this regression function $f(x)$ is unknown, and so if we want to use it for generating predictions, we need to be able to easily estimate it. There are different methods for estimating this function, which we'll talk about today.

> ## The Nearest-Neighbor Method

This method is perhaps the most straightforward and "natural" method to estimate the regression function. The main idea is that we will estimate $\mathbb{E}[Y\vert X=x]$ _non-parametrically_ directly from the training data. In this method, we're given the training data $D$, explicitly written as

$$ D=\{ (x_1, y_1), \ldots, (x_N, y_N)\}$$

In the nearest-neighbor method, we make the following estimate: $\mathbb{E}[Y\vert X=x]\approx \text{Avg}[y_i\vert x_i=x]$, where $\text{Avg}$ simply means taking the average of all of the observed outputs $y_i$ given a particular value of $x_i$.

However, one problem with this method is that the set $$\{y_i\vert x_i=x\}$$ consists of one point, or could even be empty. This means that there's nothing really to take the "average" here. To overcome this problem, we will use a common technique in applied mathematics and relax this constraint that $x_i$ is exactly equal to $x$. We do this by averaging over the $y_i$ where $x_i\in\mathcal{N}_k(x)$, where $\mathcal{N}_k(x)$ is the set of $k$ closest inputs $x_i$ to $x$. This leads to the following approximation of the regression function:

$$f(x)\approx \hat{f}(x)=\frac{1}{k}\sum_{i:x_i\in\mathcal{N}_k(x)} y_i$$

This approximation is called the **$k$-nearest neighbor method** (abbreviated as the $k$-NN method). An illustration of this method for $k=3$ is shown here in one dimension:

![nearest-neighbor](/assets/images/nearest-neighbor.png){:height="80%" width="80%"}

Here, we're trying to approximate $f(x)$ for the particular value of $x$ highlighted in red. $f(x)$ is unknown. In order to do this, we use the three training data points in closest proximity to $x$, which compose the set $$\mathcal{N}_k(x)$$. Note that $$\mathcal{N}_k(x)$$ does _not_ include the actual value of $x$. The average of the three labels for the $x_i\in\mathcal{N}_3(x)$ is then used to approximate $f(x)$. This same methodology can be used in any number of dimensions. More formally, the definition of the $k$-nearest neighbor method approximation is

$$f(x)=\mathbb{E}[Y \vert X=x] \approx \frac{1}{k} \sum_{i: x_{i} \in \mathcal{N}_{k}(x)} y_{i}=\hat{f}(x)$$

Implicitly, there are two approximations here in saying that $f(x)\approx \hat{f}(x)$:

  1. The _expectation_ is approximated by the empirical average. As $N, k\rightarrow\infty$, the approximation becomes better.
  3. The _condition_ $x_i=x$ is relaxed by $x_i\in\mathcal{N}_k(x)$. As $N\rightarrow \infty$, points in $\mathcal{N}_k(x)$ become closer to $x$, and the corresponding approximation becomes better.

An important fact is that in using this method, $\hat{f}(x)\rightarrow f(x)$ as $N, k\rightarrow\infty$ such that $\frac{k}{N}\rightarrow0$. This statement is proved by [Devroy et al](https://www.researchgate.net/publication/230675276_A_Probablistic_Theory_of_Pattern_Recognition), but we will not discuss it here. This tells is that theoretically, the $k$-nearest neighbor method is a universal solution to the regression problem. However, this sounds a bit suspicious and too good to be true. It's very rare to find one universal solution that works all the time in applied mathematics or the applied sciences.

Practically, our issue is that $f(x)\approx \hat{f}(x)$ may not be accurate because **all data sets have finite $N, k$**. This is especially the case if $p=\text{dim }X$ is large. The convergence of $\hat{f}(x)\rightarrow f(x)$ will still hold, but generally, the speed of convergence decreases as $p$ increases. This phenomenon is what we call the **curse of dimensionality**. 

> ## The Curse of Dimensionality

The curse of dimensionality is a general term used to describe situations where regression methods perform well at low numbers of dimensions, but experience some phenomenon where they become increasingly inefficient as the number of dimensions increases. Let's see some of the phenomenon that contribute to the curse of dimensionality in the case of the $k$-NN method:

  1. $k$-NN is a _local_ method. This means that $f(x)$ is approximated based in information provided on $$\mathcal{N}_k(x)$$. This set $$\mathcal{N}_k(x)$$ contains $\alpha=k/N\ll1$ proportion of the total training data points. In practical applications, $k$ could be $4$ or $5$ while $N\sim 1000$, so $\alpha$ is usually quite small.
  2. In higher-dimensions, $$\mathcal{N}_k(x)$$ becomes increasingly non-local. It gets larger and further away from $x$ in distance. To illustrate this, consider the following:

Suppose $x_1, \ldots, x_N$ are uniformly distributed in $C_p=[0, 1]^p$, which is a $p$-dimensional unit hypercube. To capture a fraction $\alpha$ of the sample by $C_p(l)=[0, l]^p\subset C_p$, we would need to choose $l\in[0, 1]$ such that $\text{volume}(C_p(l))=\alpha$. This requires

$$l^P=\alpha \longrightarrow l=\alpha^{1/p}$$

Note that $l\rightarrow 1$ as $p\rightarrow \infty$. This simple example shows is that no matter how small $\alpha$ is, we need to take larger and larger ranges of the data that therefore become less and less local as $p$ becomes large.

Another issue is that as the dimensionality increases, the training samples $x_1, \ldots, x_N$ can only sparsely populate the high-dimensional input space $\mathbb{R}^p$. This issue increases exponentially with more and more dimensions added. Furthermore, in higher dimensions $x_1, \ldots, x_N$ are close to the "boundary" of the sample. To illustrate this, consider $N$ inputs uniformly distributes in $B_p$, which is a $p$-dimensional unit ball centered at the origin. We denote this as $$x_1, \ldots, x_N\in\mathcal{U}(B_p)$$. Suppose that we want to use a $k$-NN method for estimating the output at the origin. Let $D$ be the distance from the origin to the nearest neighbor. That is,

$$ D=\text{min}\{\vert\vert X_1\vert\vert, \ldots\vert\vert X_1\vert\vert \}$$

The CDF of $D$ can be shown to be $F_D(d)=1-(1-d^p)^N$. Let's use the median $\tilde{d}$ as a proxy for a typical value of $D$. Therefore,

$$F_D(\tilde{d})=\frac{1}{2}\rightarrow \tilde{d}=\left[(1-\left(\frac{1}{2}\right)^{1/N}\right]^{1/p}$$

This means that $\bar{d}\rightarrow 1$ as $p\rightarrow \infty$. This is related to the fact that the volume of [$p$-dimensional sphere](/projects/hyperspheres/index.html) is concentrated near the surface of the sphere.

Why does this matter for the $k$-NN method? This is bad for the $k$-NN method because instead of interpolating between $$x_i\in\mathcal{N}_k(x)$$, in high dimensions, the $k$-NN method will have to _extrapolate_ from them because $x$ will not be "in between" its nearest neighbors. If the dimension of the input space $p$ is large, then  the nearest neighbors $$\mathcal{N}_k(x)$$ are likely to be far from the target input $x$, and so the $k$-NN method is likely to have large prediction errors.

These issues validate that the $k$-NN method suffers from the curse of dimensionality. 

> ## The Linear Regression Method

To overcome this issue, we can try to _model_ $f(X)$ instead of estimating it. Suppose the $f(X)$ is linear, such that

$$f(x)=\beta_0+\beta_1X_1+\cdots+\beta_pX_p$$

We can also define the following matrices:

$$\beta=\begin{bmatrix} \beta_0 \\ \beta_1 \\ \vdots \\ \beta_p\end{bmatrix}, \quad X=\begin{bmatrix} 1 \\ X_1 \\ \vdots \\ X_p\end{bmatrix}$$

This allows us to write $f(X)=X^T\beta$, where $X, \beta\in\mathbb{R}^{p+1}$. The **mean squared error** is then

$$ \text{MSE}(f)=\mathbb{E}\left[(Y-\hat{Y})^{2}\right]=\mathbb{E}\left[\left(Y-X^{T} \beta\right)^{2}\right] =\text{MSE}(\beta)$$

We can minimize this mean squared error with respect to $\beta$. To find $\beta$ that minimizes the MSE, standard calculus tells us that we need to solve $\nabla_{\beta}\text{MSE}(\beta)=0$. It can be shown that

$$\nabla_{\beta}\text{MSE}(\beta)=-2\mathbb{E}[(Y-X^T\beta)X]$$

This allows us to set the right hand side equal to zero, which gives us the following constraint equation:

$$\mathbb{E}[Y X]-\mathbb{E}\left[X^{T} \beta X\right]=0 \quad \longrightarrow \beta=\mathbb{E}[XX^T]^{-1}\mathbb{E}[XY]$$

The full derivation of this can be found [here](https://youtu.be/hTvGbpqaNJA?t=1597). This value of $\beta$ is a theoretically optimal value of model parameters. We want to estimate $\beta$ using the training data $$\{(x_1, y_1), \ldots, (x_N, y_N)\}$$. We can make the following approximations:

  - $$\mathbb{E}\left[X X^{T}\right] \approx \frac{1}{N} \sum_{i=1}^{N} x_{i} x_{i}^{T}=\frac{1}{N}\mathbb{X}^T\mathbb{X}$$
  - $$\mathbb{E}\left[X Y\right] \approx \frac{1}{N} \sum_{i=1}^{N} x_{i} y_{i}=\frac{1}{N}\mathbb{X}^Ty$$

Therefore, using the training data, we can make the estimating that

$$\hat{\beta}=\left(\mathbb{X}^{T} \mathbb{X}\right)^{-1} \mathbb{X}^{T} y\approx \beta$$

If we assume that the relationship between $X$ and $Y$ is approximately linear with $Y\approx f(X)=X^T\beta$, then we can estimate $\beta\approx \hat{\beta}$ from the training data and use $\hat{Y}=\hat{f}(X)=X^T\hat{\beta}$ as a predictor for $Y$. This is the classical **linear regression model**.

> ## Accuracy of Linear Regression

Suppose that the linearity assumption holds approximately with $Y=X^T\beta+\epsilon$, where $\epsilon\sim\mathcal{N}(0, \sigma^2)$ represents some "Gaussian" noise parameter. We are interested in the following two questions:

  1. How accurate is the linear regression in this case?
  2. Does the accuracy suffer from the curse of dimensionality?

To address these two questions, let's derive the expected mean squared error with respect to the input $X$:

$$\text{MSE}(X)=\mathbb{E}[(Y-\hat{Y})^2]=\mathbb{E}[(X^T\beta+\epsilon-X^T\hat{\beta}]$$

This expectation value is with respect to the noise parameter $\epsilon$ and the training data $$\{\mathbb{X}, y\}$$. [It can be shown](https://youtu.be/hTvGbpqaNJA?t=2463) that $\hat{\beta}=\beta+(\mathbb{X}^T\mathbb{X})^{-1}\mathbb{X}^Te$, where $e$ is the column vector of noise parameters for each training point. Therefore, leaving the (rather complicated and involved) derivation again to the linked video, we can ultimately show that

$$\text{MSE}(X)\approx \sigma^2+\frac{\sigma^2}{N}p$$

As intuitively expected, the prediction accuracy increases as the sample size $N$ increases, decreases as the "noise strength" $\sigma^2$ increases, and decreases as the dimension $p$ increases. However, the prediction error will be large if the linearity assumption is not satisfied.

One important observation is that if $Y\approx X^T\beta$, when we can _suppress_ the curse of dimensionality by making $\sigma^2/N$ small enough. If $\sigma^2/N$ is all, then the growth in the prediction error associated with the increase of $p$ is negligible.
