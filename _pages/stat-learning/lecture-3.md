---
permalink: /stat-learning/lecture-3/
title: "Methods in Classification Problems and the Bias-Variance Trade-Off"
toc: true
toc_label: "Contents"
---

_The link to the full 72-minute lecture can be found [here](https://www.youtube.com/watch?v=gVXUjkobldw)._

> ## $k$-NN vs. Linear Regression

From [last time](/stat-learning/lecture-2/index.html), we introduced the **$k$-NN ($k$ nearest neighbor) method** and also the linear regression method for quantitative statistical learning. The $k$-NN method was a "flexible" nonparametric method that approximates $f(x)$ by a _locally_ constant function. It also has a nice theoretical property that $$\hat{f}(x)\rightarrow f(x)=\mathbb{E}[Y\vert X=x]$$ as $N, k\rightarrow \infty$ and $k/N\rightarrow 0$. However, we also learned that this method suffers from the curse of dimensionality, which boils down to the fact that the $k$-NN method yields high prediction errors if the dimensionality of the data set $p\gg 1$. 

To overcome this curse of dimensionality, the **linear regression method** was introduced. It is a more "rigid" parametric method that approximates $f(x)$ by a _globally_ linear function. If we assume that $$Y\approx f(X)=X^T\beta$$, then the curse of dimensionality can be overcome. However, if this linearity assumption is wrong, then the predictions obtained by this method will be very bad.

In practical applications, most supervised statical learning methods can be viewed as being on some spectrum between the flexible $k$-NN method, which is entirely nonparametric, and the rigid linear regression method, which is inherently parametric. Furthermore, with respect to classification problems, the other type of problem encountered in [supervised learning](/stat-learning/lecture-1/index.html#types-of-learning-problems), the $k$-NN and linear regression methods are so fundamental that they can also be used to "solve" these types of classification problems. This is what we will discuss today.

> ## Statistical Decision Theory for Classification

A classification problem typically involves some input $$X\in\mathbb{R}^p$$ and some corresponding output $$G\in\mathcal{G}=\{\mathcal{G}_1, \ldots, \mathcal{G}_K\}$$. Here, $$\mathcal{G}$$ represents the set of all possible classifications. An example of this type of problem is that given a particular patient's past medical history, allergies, and diagnostic results, we may want to determine whether the patient has the common cold, the flu, or (knock on wood) the coronavirus. Our goal is to determine a prediction rule $$f:\mathbb{R}^p\rightarrow \mathcal{G}$$ such that $$\hat{G}=f(X)\approx G$$. In order to measure the accuracy of prediction, we need to define a loss function $L:\mathcal{G}\times\mathcal{G}\rightarrow \mathbb{R}$. However, the same [mean square error](/stat-learning/lecture-2/index.html#the-linear-regression-method) loss function will not work here because we cannot easily define subtraction between different groups of classification. For example, how can we "subtract" the common cold from the coronavirus? 

Perhaps the most commonly used loss function is called the **zero-one loss**, which is defined to be

$$L(G, \hat{G})=I(G\neq \hat{G})=\begin{cases} 0, \quad \text{ if }G=\hat{G},\\ 1, \quad \text{ if }G\neq \hat{G}\end{cases}$$

Here, $I$ is called an _indicator function_. Then, our expected loss can still be defined as

$$\mathbb{E}[L(G, \hat{G})]=\mathbb{E}[L(G, f(X))]=\begin{cases} \text{small} \rightarrow f\text{ is good},\\\text{large} \rightarrow f\text{ is bad} \end{cases}$$

More specifically, if we use the zero-one loss function definition, then the corresponding expected loss is called the **expected prediction error**:

$$\text{EPE}(f)=\mathbb{E}[I(G\neq \hat{G})]=\mathbb{E}[I[G\neq f(X))]$$

Our goal is to find the prediction function $f$ that minimizes $\text{EPE}(f)$. We can do this by _conditioning_ on $X$ and using the law of total expectation:

$$\text{EPE}(f)=\mathbb{E}\left[\mathbb{E}[I(G\neq f(X))\vert X]\right]$$

Here the inner expectation operator is with respect to $G$, while the outer expectation operator is with respect to $X$. Let's take a closer look at the inner conditional expectation:

$$ \mathbb{E}[I(G\neq f(x))\vert X=x)]=\sum_{k=1}^{K} I\left(\mathcal{G}_{k} \neq f(x)\right) \mathbb{P}\left(G=\mathcal{G}_{k} | X=x\right) $$

The right hand side is simply obtained by the definition of the expectation value. In order to minimize this expected prediction error, we need to find $$f(x)\in\{\mathcal{G}_1, \ldots, \mathcal{G}_K\}$$ that minimizes this expression. In other words,

$$ f(x)=\arg \min _{\mathcal{G}_{s} \in \mathcal{G}} \sum_{k=1}^{K} I\left(\mathcal{G}_{k} \neq \mathcal{G}_{s}\right) \mathbb{P}\left(G=\mathcal{G}_{k} \vert X=x\right)$$

The indicator function is equal to $0$ if $k=s$ and $1$ otherwise. Therefore, it essentially acts as the Kronecker delta function $\delta_{ks}$, and so this simplifies to

$$f(x)=\arg \min_{\mathcal{G}_s \in\mathcal{G}} \sum_{k\neq s}\mathbb{P}(G=\mathcal{G}_k\vert X=x)=\arg \min_{\mathcal{G}_s\in\mathcal{G}} \left(1-\mathbb{P}(G=\mathcal{G}_s\vert X=x)\right)$$

We can conclude this result by using the fact that the sum of all the possible probabilities equals one. This can be further rewritten as

$$f(x)=\arg \max_{\mathcal{G}_s\in\mathcal{G}}\mathbb{P}(G=\mathcal{G}_s\vert X=x)$$

Therefore, the prediction rule that _minimizes_ the $\text{EPE}(f)$ is 

$$f(x)=\arg \max_{g\in\mathcal{G}}\mathbb{P}(G=g\vert X=x)$$

This function is called the **Bayes Classifier**. In the next section, we will determine what this expression _actually_ means.

> ## The Bayes Classifier

The Bayes classifier essentially tells us that if $X=x$, then the best prediction is $$\hat{G}=\mathcal{G}_k$$ where

$$\mathbb{P}(G=\mathcal{G}_k\vert X=x)=\max_{g\in\mathcal{G}}\mathbb{P}(G=g\vert X=x)$$

This is telling us that given a particular input $X=x$, the best prediction of which class  this input will fall into is $\hat{G}=\mathcal{G}_k$, where $$\mathcal{G}_k\in\{\mathcal{G}_1, \ldots, \mathcal{G}_K\}$$ is defined by the above equation, and is essentially saying that it is the most likely classification of the given input $X=x$ with respect to all of the different possible classification groups. In other words, this is a pretty intuitive definition that doesn't quite give us a lot of information (yet).

The Bayes classifier is a classification analog of the regression function from our [previous discussions](/stat-learning/lecture-2/index.html). Both are obtained by minimizing the expected loss, although with respect to different loss functions. Both are also unknown function and we want to _learn them_ from the given training data.

In fact, the Bayes classifier and the regression function are in fact related! This can be most easily demonstrated by considering a two-class problem: $$G\in\mathcal{G}=\{\mathcal{G}_0, \mathcal{G}_1\}$$. For this problem, let's define a binary dummy-variable $Y$ with the property that $Y=0$ if $G=\mathcal{G}_0$ and $Y=1$ if $G=\mathcal{G}_1$. Given this setup, then

$$\mathbb{E}[Y\vert X=x]=(0)\mathbb{P}(G=\mathcal{G}_0\vert X=x)+(1)\mathbb{P}(G=\mathcal{G}_1\vert X=x)=\mathbb{P}(G=\mathcal{G}_1\vert X=x)$$

Meanwhile, we can calculate

$$\arg\max_{g\in\mathcal{G}}\mathbb{P}(G=g\vert X=x)=\begin{cases}\mathcal{G}_0, \quad\text{ if }\mathbb{E}[Y\vert X=x]<1/2, \\\mathcal{G}_1, \quad \text{ if }\mathbb{E}[Y\vert X=x]>1/2\end{cases}$$

Because the regression function $$f(x)=\mathbb{E}[Y\vert X=x]$$, this tells us that if the regression function is greater than $1/2$, then the Bayes classifier will return $\mathcal{G}_1$, while if it is less than $1/2$ then the Bayes classifier will return $\mathcal{G}_0$. These two systems essentially give us the same information, validating that they are in fact related. 

> ## $k$-NN and Linear Regression for Classification

Here, we'll introduce the $k$-NN classifier to be used in classification problems. The main idea is that given a new input $X=x$, let's estimate $\mathbb{P}(G=g\vert X=x)$ non-parametrically directly from the training data, and then classify $X=x$ to the class with the highest estimated probability. Here are the general steps (you should find these similar to the $k$-NN method for quantitative problems we talked about earlier):

  1. Choose $$k\in\{1, \ldots, N\}$$ where $N$ is the sample size of the training data $$\{(x_1, g_1), \ldots, (x_N, g_N)\}$$.
  2. Relax the condition $X=x$ by $X\in\mathcal{N}_k(x)$, where $\mathcal{N}_k(x)$ is the set of the $k$ closest to $x$ inputs $x_i$.
  3. Estimate the conditional probability $\mathbb{P}(G=g\vert X=x)$ by the fraction of points in $\mathcal{N}_k(x)$ whose class is $g$, given by $$\mathbb{P}(G=g\vert X=x)\approx \frac{1}{k}\sum_{i:x_i\in\mathcal{N}_k(x)} I(g_i=g)$$.
  4. Approximate the Bayes classifier: $$f(x)\approx \arg \max_{g\in\mathcal{G}}\frac{1}{k}\sum_{i:x_i\in\mathcal{N}_k(x)} I(g_i=g)$$.

This gives us the definition of the $k$-NN classifier:

$$\hat{f}(x)=\arg\max_{g\in\mathcal{G}}\sum_{x_i\in\mathcal{N}_k(x)} I(g_i=g)$$

The $k$-NN classifier can simply be thought of as the _majority vote_ in the neighborhood $\mathcal{N}_k(x)$. To illustrate this visually, consider a system with $p=2$ two-dimensional inputs $X_1, X_2$. Let's suppose that we want to use the $k=3$ nearest neighbor method to classify the input $X=x$ highlighted by the blue "x" in the figure below:

![k-nn-classifier](/assets/images/knn-classifier.png){:height="80%" width="80%"}

We encircled the points that make up the neighborhood $\mathcal{N}_3(x)$ with a blue dashed line. According to this diagram, of the three nearest neighbors of the blue point "x", two of them are of class 1 while only one of them are of class 2. Therefore, our guess would be to approximate the input blue point "x" as being in class 1 for this example. This $k$-NN classifier often performs very well (close to the optimal Bayes classifier) in low dimensions. However, in high dimensions, it suffers from the [curse of dimensionality](/stat-learning/lecture-2/index.html), as we have discussed previously. Interestingly, the choice of $k$ has a strong effect on the performance of this classifier. We will discuss later how to systematically choose $k$ in order to optimize the classifier's performance. For now, this is just a good thing to keep in mind.

We can also see how linear regression can be used for classification problems. Consider a two-class problem $$G\in\mathcal{G}=\{\mathcal{G}_0, \mathcal{G}_1\}$$. We can define a binary dummy variable $Y$ such that $Y=0$ if $G=\mathcal{G}_0$ and $Y=1$ if $G=\mathcal{G}_1$. With this definition, we can convert the training data:

$$\{(x_1, g_1), \ldots, (x_N, g_N)\}\rightarrow\{(x_1, y_1), \ldots, (x_N, y_N)\}$$

In this way, we have essentially artificially transformed our classification problem into a quantitative problem that we already know how to solve. We can use linear regression to predict $Y$ from $X$:

$$\hat{Y}=\hat{f}(X)=X^T\hat{\beta}, \quad X=\begin{bmatrix} 1 \\ X_1 \\ \vdots \\ X_p\end{bmatrix}$$

where

$$\hat{\beta}=(\mathbb{X}^T\mathbb{X})^{-1}\mathbb{X}^Ty, \quad \mathbb{X}=\begin{bmatrix} 1 & x_{11} & \cdots & x_{1p} \\ \vdots & \vdots & \vdots & \vdots \\ 1 & x_{N1} & \cdots & x_{Np} \end{bmatrix}, \quad y=\begin{bmatrix} y_1 \\ \vdots \\ y_N\end{bmatrix}$$

Using this result, we can then finally predict the class $G$ of the input $X$ as follows:

$$ \hat{G}=\begin{cases} \mathcal{G}_0, \quad \text{ if }\hat{Y}=X^T\hat{\beta}<1/2\\ \mathcal{G}_1, \quad \text{ if }\hat{Y}=X^T\hat{\beta}>1/2 \end{cases}$$

Visually, this might look something like this:

![regression-classifier](/assets/images/regression-classification.png){:height="80%" width="80%"}

This blue dotted line determined from the linear regression algorithm represents the **decision boundary** that separates the two classes from one another. In this two dimensional case, it is a simple line, but in higher dimensions, this blue dotted line is actually a [hyperplane](https://en.wikipedia.org/wiki/Hyperplane).

In principle, this technique could be used when there are more than two classes, but in actual practice it doesn't really work too well. We will discuss why this happens to be the case later.

In this brief introduction of these two classification methods in learning from both quantitative and qualitative data, there are still questions that need answering. Given a particular regression or classification problem...

  - Should we use a more flexible $k$-NN method or a more rigid linear regression method?
  - If we're using the $k$-NN method, when what value of $k$ should be use?
  - If we're using the linear regression method, then how many parameters $\beta_0, \ldots, \beta_p$ should we actually use?

To answer these questions is extremely challenging. The bottom line is that there is no "free lunch" in statistical learning: no singular method dominates all other methods over all possible data sets. However, in general, the more we assume, the more we can learn from the data, and more accurate our predictions will be, provided that our assumptions are correct. This problem of selecting the best method _for a given training data set_ from a collection of possible methods is called **model selection**.

> ## The Bias-Variance Trade-Off

One important question in model selection is called the bias-variance trade-off. To explore what this is, let's consider the following regression problem (for classification problems, the story is similar).

Suppose that $Y=f(X)+\epsilon$, where $\mathbb{E}[\epsilon]=0$ and $\mathbb{V}[\epsilon]=\sigma^2$. Then, $$\mathbb{E}[Y\vert X=x]=\mathbb{E}[f(x)+\epsilon \vert X=x]=f(x)$$, which represents the regression function that we want to learn and estimate using the training data $$T=\{(x_1, y_1), \ldots, (x_N, y_N)\}$$. Define $\hat{f}(X)$ by an approximation of $f(X)$ obtained from $T$ using some method. Our prediction for the output $Y$ from the input $X$ is $\hat{Y}=\hat{f}(X)$. If a particular model $\hat{f}$ is pretty good, then it should perform well on the training data $T$ that it was trained on (in addition other inputs outside of the training data, but that's beside the point here). The performance on the training data can be quantified by the **training error**, which is defined as

$$\overline{\text{err}}=\frac{1}{N}\sum_{i=1}^NL(y_i, \hat{f}(x_i))$$

Here, we are summing over all of the training points in the training data set. For example, if we are using the $L_2$ loss function for linear regression problems, then the training error can be defined by

$$\overline{\text{err}}=\frac{1}{N}\sum_{i=1}^N (y_i-\hat{f}(x_i))^2$$

The training error should be pretty small using a good model $\hat{f}$. Now, one possible question is can this training error be used to choose which model may be better over another?

The answer is no! This is because we are not really interested in how well $\hat{f}$ works on $T$, since we already know the outputs for $T$. We are actually interested in the accuracy $Y\approx \hat{f}(X)$ for the new, "unseen" inputs $X$. The idea is that we are more interested in how well $\hat{f}$ can "generalize" from $T$ to new data. 

Let $X$ by a new previously unseen input. The quantity of interest is the **test error**, which is also called the generalization error:

$$\text{Err}(X)=\mathbb{E}[L(Y, \hat{f}(X))]$$

Here, the expectation value is taken with respect to both $Y$ and $T$, taking $X$ as fixed. Of course, we want this error to be as small as possible. This test error can always be decomposed into the sum of three fundamental terms, the proof of which is shown in detail in [this video segment](https://youtu.be/gVXUjkobldw?t=2811). We will leave out this (rather complicated) derivation and simply give the result:

$$\text{Err}(X)=\sigma^2+\left(f(X)-\mathbb{E}(\hat{f}(X))\right)^2+\mathbb{V}[\hat{f}(X)]$$

All three of these terms are non-negative, and we want all of these to be as small as possible.

  1. $\sigma^2$ is the **irreducible error** that's simply due to the noise of the data set. We can control it, even if we know the true $f(X)$. 
  2. $$\left(f(X)-\mathbb{E}(\hat{f}(X))\right)^2$$ is the **squared bias** of $\hat{f}(X)$, and essentially quantifies the error made by approximating the true value of $f(X)$ by a model $\hat{f}(X)$. 
  3. $\mathbb{V}[\hat{f}(X)]$ is the **variance** of $\hat{f}(X)$, and quantifies the variability of $\hat{f}(X)$ with respect to $T$. Ideally, $\hat{f}(X)$ shouldn't change a lot between different training sets. 

To some degree, we can control the second and third terms be changing the flexibility of our model. In general, if the flexibility of $\hat{f}$ increases, then the bias term _decreases_, but the variance _increases_. This is called the **bias-variance trade-off**. Because of this, it is often difficult to minimize $\text{Err}$ due to this trade-off.

Intuitively, this makes sense. By definition, model flexibility (in other words, model complexity) is the ability to fit many different functional forms. With more parameters and degrees of freedom, a model becomes more flexible. For example, a model that is composed of many individually independent piecewise functions (i.e. the $k$-NN method) is much more flexible than a model that is composed of a single hyperplane (i.e. the linear regression method). Graphically, the bias-variance trade-off looks something like this:

$$\text{Err}(X)=\sigma^2+\mathbb{B}[\hat{f}(X)]^2+\mathbb{V}[\hat{f}(X)]$$

![trade-off](/assets/images/bv-tradeoff.png){:height="70%" width="70%"}

The total $\text{Err}$ is plotted in black. As we can see, as the model complexity increases, the bias decreases. This is because model complexity introduces more parameters, e.g. polynomial fit instead of linear fit for regression, which can better fit "around" the different contours of the training data set. However, more parameters means that this training method will be highly sensitive to the training data set, giving an increasingly large variance term. The resulting U-shape of the test error (the sum of all three terms) is a fundamental property that holds regardless of the statistical method being used.

Note that the training error $$\overline{\text{err}}$$ will always decrease as the model complexity increases. This tells us that the training error is a bad estimate of the test error. In general, there are two bad cases that we want to avoid:

  1. **Overfitting** happens in the regime when $\hat{f}$ has small $\overline{\text{err}}$ but large $\text{Err}$ (in other words, too high model complexity, meaning small $$\mathbb{B}^2$$ term but large $$\mathbb{V}$$). This means that the model adapts itself too closely to $T$, and it finds patterns specific to $T$, not to $f$. In other words, the model doesn't generalize well.
  2. **Underfitting** happens in the regime were $\hat{f}$ has both large $\overline{\text{err}}$ and large $\text{Err}$ (in other words, two low model complexity, meaning large $\mathbb{B}^2$ term but small $\mathbb{V}$). This means that the model is not flexible enough to approximate $f$. 

In practical applications, overfitting occurs much more often than underfitting. In general, we always want to choose the model flexibility to trade bias off with variance to minimize the test error.

> ## Trade-Off Example

Consider the $k$-regression method: $$f(x)\approx \hat{f}_k(x)=\frac{1}{k}\sum_{x_i\in\mathcal{N}_k(x)}y_i$$ for $$k\in\{1, 2, \ldots, N\}$$. Let's consider a couple of limiting functions:

  1. If $k=N$, then $$\hat{f}_N(x)=\frac{1}{N}\sum_{I=1}^N y_i$$. For a given training set, this is simply a constant! It is the average of all of the different outputs of the training set. Therefore, for any input $X$, our prediction for $Y$ using this model would be $\hat{Y}=\bar{y}$. Effectively, $\hat{f}_N$ therefore has only one parameter: the mean of the outputs $\bar{y}$. $\hat{f}_N$ can therefore be thought of as a very rigid (i.e. inflexible) method.
  2. If $k=1$, then $$\hat{f}_1(x)=y_{I(x)}$$, where $$i(x)=\arg\min_{i=1, \ldots, N} \text{list}(x, x_i)$$. In this case, we are approximating $f(x)$ by a locally constant function called a **[Voronoi tessellation](https://en.wikipedia.org/wiki/Voronoi_diagram)** of the training inputs, which is defined by $$V(x_j)=\{x:x_j\text{ is the closest to }x\text{ among all }x_1, \ldots, x_N\}$$. This means that for any $x\in V(x_j)$, we have $\hat{f}_1(x)=y_j$. Therefore, effectively, $\hat{f}_1$ has $N$ parameters. Because each training data point's single closest neighbor is itself, the training error $$\overline{\text{err}}(\hat{f}_1)=0$$. $\hat{f}_1$ can therefore be thought of as the most flexible $k$-NN method.

In general, $k$ controls the flexibility of the $k$-NN regression method. This means that as $k$ increases, the flexibility degreases. We can compute the bias and the variance and check how they behave with respect to $k$. Recall that $Y=f(X)+\epsilon$, where $\mathbb{E}[\epsilon]=0$ and $\mathbb{V}[\epsilon]=\sigma^2$. This means that

$$y_i=f(x_i)+\epsilon_i, \text{ where } \epsilon_1, \ldots \epsilon_N\text{ are iid, }\mathbb{E}[\epsilon_i]=0\text{ and }\mathbb{V}[\epsilon_i]=\sigma^2$$

Therefore, according to this model $$\hat{f}_k(x)=\frac{1}{k}\sum_{x_i\in\mathcal{N}_k(x)}(f(x_i)+\epsilon_i)$$. For simplicity, we will take $x_1, \ldots, x_n$ as fixed such that the randomness comes only from $\epsilon_1, \ldots, \epsilon_N$. The bias term is

$$\mathbb{B}[\hat{f}_k(X)]^2=(f(X)-\mathbb{E}[\hat{f}_k(X)])^2=(f(X)-\frac{1}{k}\sum_{x_i\in\mathcal{N}_k(X)}f(x_i))^2$$

This means that if the model flexibility increases, then $k$ decreases. Because the neighbors that are only nearest to the input $X$ are relevant to approximating its output, this means that $\mathbb{E}[\hat{f}_k(X)]$ will get closer and closer to $f(X)$, and so the bias $\mathbb{B}[\hat{f}_k(X)]^2$ will decrease. Now, the variance term is

$$\mathbb{V}\left[\hat{f}_{k}(X)\right]=\mathbb{V}\left[\frac{1}{k} \sum f\left(x_{i}\right)+\frac{1}{k} \sum \epsilon_{i}\right]=\frac{1}{k^{2}} \sum \mathbb{V}\left[\epsilon_{i}\right]=\frac{\sigma^{2}}{k}$$

This means that if the model flexibility increases, then $k$ decreases, and so from this formula, the variance $$\mathbb{V}[\hat{f}_{k}(X)]$$ will increase. This makes sense, as if the number of parameters increases, then it becomes more difficult to ensure that our estimates of these parameters are correct.