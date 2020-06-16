---
permalink: /stat-learning/lecture-1/
title: "Learning Problems and Statistical Decision Theory"
---

_The link to the full 38-minute lecture can be found [here](https://www.youtube.com/watch?v=P60kCrOc6LQ)._

> ## The Big Picture

**Statistical Learning** is a subfield of modern statics that develops concepts and methods for

  - understanding data.
  - making predictions based on the data.
  - making data-informed decisions.

Statistical learning plays a key role in science, engineering, finance, and medicine. The availability of _cheap computing power_ and the _explosion of data_ revolutionized the field of classical statistics. As a result, a dichotomy exists between classical statistics (which many of us may be familiar with from AP Statistics or introductory statistics) and modern physics:

**Classical Statistics** | **Modern Statistics**
Problems come from surveys of human populations, agricultural experiments, and industrial experiments. | Problems come from... everywhere!
Data sets are small. | Data sets are large (i.e. "big data").
Solutions are analytical, and often done by hand. | Solutions are numerical, empirical, and almost always done on a computer.

In statistical learning, we are primarily interested in the second column. Since data and data-related problems appear everywhere and computers are essentially omnipresent, modern methods for **learning from data** have been (and continue to be) developed by researchers from various fields. For example, we have the following mappings from classical fields to study to recently developed subfields:

**Classical Field** | **Recent Subfield**
Statistics | Statistical Learning
Computer Science | Machine Learning
Engineering | Pattern Recognition
Biology/Medicine | Bioinformatics
Finance | Financial Machine Learning/Quantitative Analysts

Each of these subfields have their own technologies, jargon, and terminology, which can make cross-talk between different fields difficult. Therefore, our main goal is to discuss the most fundamental, shared ideas and methods for learning from data and explaining them in a statistical framework.

> ## Types of Learning Problems:

There are three main types of learning problems in statistical learning:

  1. **Supervised Learning**: This one is probably the most well-developed. In supervised learning, we are interested in looking at a complex system that takes in input $X$ and outputs $Y$. This system is so complex that it is difficult _or even impossible_ to describe exactly. Our goal in supervised learning is to construct a statistical model for predicting the output $Y$ from input $X$ based on a certain set of training data $$\{(X_1, Y_1), \ldots, (X_N, Y_N)\}$$. This training data comes from previous observations. There are two types of supervised learning, which we will treat differently in terms of the math:
      1. **Regression**: If the output $Y$ is quantitative (continuous), then the problem is called regression. For example, regression can be used to determine how much stock to buy of which companies based on the status of the market.
      2. **Classification**: If the output $Y$ is qualitative (categorical), then the problem is called classification. This is useful in image recognition and determining whether a bank should give out a loan to a client.
  2. **Unsupervised Learning**: This one is a bit more complicated. In unsupervised learning, we're given a set of training data $\{X_1, \ldots, X_n\}$, and our goal is to understand the _structure_ of the data set. Notice that there's no outputs given in the training data, and so it is sometimes called _unlabeled data_. Some problems in unsupervised learning might involve:
      1. **Clustering**: Divide $\{X_1, \ldots, X_n\}$ into relatively distinct groups. This can be helpful in categorizing shoppers at a grocery market in order to know what to advertise to different groups of people.
      2. **Dimensionality Reduction**: Represent the data $\{X_1, \ldots, X_n\}$ in a small space: $$\{X_i\in\mathbb{R}^D\}\rightarrow \{\tilde{X}_i\in\mathbb{R}^d\}$$ with $d\ll D$. This is helpful in making programs more computationally efficient and problems more tractable.
      3. **Generative Modeling**: Model a mechanism that produced $\{X_1, \ldots, X_n\}$. One application is the generation of synthetic earthquake data.
  3. **Reinforcement Learning**: The goal is to infer optimal sequential actions based on the rewards received as a result of previous actions. Same examples of this include:
      1. Training a car to [self-drive](https://medium.com/@jeremyscohen/deep-reinforcement-learning-for-self-driving-cars-an-intro-4c8c08e6d06b) and navigate a given environment.
      2. Training an algorithm to [play chess](https://en.wikipedia.org/wiki/AlphaZero).

In this course, we will be primarily interested in _supervised learning_.

> ## Supervised Learning: Notation and Terminology

We will use the following notation with regards to inputs:

  - $$X=(X_1, \ldots, X_p)^T$$ is a vector of inputs (ada predictors, features). $p$ is the number of inputs, and $$X$$ represents a generic input vector (always a column vector in our convention).
  - $$x_i=(x_{i1}, \ldots, x_{ip})^T$$ is the $i$th observed value of $X$, with $i=1, \ldots, N$. Here, $N$ represents the number of observations, and $x_i\in\mathbb{R}^p$ is a $p$-vector.
  - $$x^{(j)}=(x_{1j}, \ldots, x_{Nj})^T$$ is the vector of all observations of an input $$X_j$$, with $$j=1, \ldots, N$$. Therefore, we can define

$$\mathbb{X}=\begin{bmatrix} x_{11} & \cdots & x_{1p} \\ \vdots & \vdots & \vdots \\ x_{N1} & \cdots & x_{Np}\end{bmatrix}=\begin{bmatrix} x_1^T \\ \vdots \\ x_N^T\end{bmatrix}=\begin{bmatrix} x^{(1)} & \cdots & x^{(p)}\end{bmatrix}$$

Here, $$x_{ij}$$ represents the value of the $j$th input in the $i$th observation.

We will use the following notation with regards to outputs:

  - $Y\in\mathbb{R}$ is a _quantitative output_ (aka response) corresponding to $X$. 
  - $y_i$ is the $i$th observed value of $Y$ that corresponds to $x_i$, with $i=1, \ldots, N$. 
  - $G\in\mathcal{G}$ is a _categorical output_ (aka class) corresponding to $X$. Here, $\mathcal{G}$ represents the set of possible groups/classes that we can group $G$ into.
  - $g_i$ is the $i$th observation of $G$ that corresponds to $x_i$, with $i=1, \ldots, N$.

In **statistical decision theory**, we are given the training data, which is in the form of $$\{(x_1, y_1), \ldots, (x_N, y_N)\}$$ for regression problems and $$\{(x_1, g_1), \ldots, (x_N, g_N)\}$$ for classification problems, and the value of the input $X$. Using this information, we want to be able to make a good prediction $\hat{Y}$ or $\hat{G}$ of the true output $Y$ or $G$. Let's start with regression.

> ## Regression

Define $X\in\mathbb{R}^p$ to be a random input, and $Y\in\mathbb{R}$ is the corresponding random output. We want to find a **prediction rule** $f:\mathbb{R}^p\rightarrow \mathbb{R}$ such that $\hat{Y}=f(X)\approx Y$. In order to measure the accuracy of this prediction, we need to define a **loss function** $$L:\mathbb{R}\times\mathbb{R}\rightarrow \mathbb{R}$$. The **expected loss** is therefore $$\mathbb{E}[L(Y, \hat{Y})]$$.

$$\mathbb{E}[L(Y, \hat{Y})]=\mathbb{E}[L(Y, f(X))]=\begin{cases} \text{small}, \quad f\text{ is good,}\\ \text{large}, \quad f\text{ is bad}\end{cases}$$

By and large, the most popular loss function is the **squared error loss function** (aka the $L_2$ loss function), which is defined by $L_2(Y, \hat{Y})=(Y-\hat{Y})^2$. The corresponding expected loss is therefore called the **mean squared error (MSE)**:

$$\text{MSE}(f)=\mathbb{E}[(Y-\hat{Y})^2]=\mathbb{E}[(Y-f(X))^2]$$

Our goal in statistical learning regression is to determine $f$ that minimizes $\text{MSE}(f)$. We can accomplish this by _conditioning on $X$_ and using the **law of total expectation**:

$$ \text{MSE}(f)=\mathbb{E}\left[\mathbb{E}\left[(Y-f(X))^{2} | X\right]\right] $$

The inner expectation value is with respect to $Y$, while the outer expectation value is with respect to $X$. Evaluating this exception value is explained [here](https://youtu.be/P60kCrOc6LQ?t=1721). The **inner conditional expectation** is derived to be

$$\mathbb{E}[(Y-f(x))^2|X=x]=\mathbb{V}[Y|X=x]+(\mathbb{E}[Y|X=x]-f(x))^2$$

Here, $\mathbb{V}$ represents the _variance_ of the random variable argument. The mean squared error is therefore the expectation value of this inner expectation value. In order to minimize this mean squared error with respect to $f$, the second term must be equal to zero (as $f$ doesn't participate in the first term), and so $$f(X)=\mathbb{E}[Y\vert X]$$. Therefor, the _best prediction_ (in terms of the $L_2$ loss function) for the response $\hat{Y}$ to input $X=x$ is 

$$f(x)=\mathbb{E}[Y|X=x]$$

This function is so important in statistical learning that it even has its own name (although uncreative): the **regression function**.

Although the $L_2$ loss function is most commonly used, there's also the $$L_1$$ loss function defined as $$L_1(Y, \hat{Y})=\vert Y-\hat{Y}\vert$$. However, this loss function is often difficult to implement in many algorithms, which is why it's not as commonly used. However, $L_1$ does have its benefits. For example, $L_1$-derived prediction functions are [more resistant to the presence of outliers](https://rishy.github.io/ml/2015/07/28/l1-vs-l2-loss/).
