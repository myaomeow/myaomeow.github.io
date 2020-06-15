---
permalink: /calculus/intro-to-derivatives/
title: "Introduction to Derivatives"
---

[Last time](/calculus/limits-and-continuity/index.html), we asked the question of what happens when we want to find the slope of a secant lint between two points $(x, f(x))$ and $(x+h, f(x+h))$ for some parameter $h$. The slope $m$ of this secant line is

$$m=\frac{f(x+h)-f(x)}{h}$$

Today, we'll see what happens as we take the limit as $h\rightarrow 0$. That is, what happens when the two points begin to approach each other? To think about this problem, let's go back to Problem 3 from [last time](/calculus/limits-and-continuity/index.html), where we considered the function $f(x)=x^2$. Let's evaluate the slope $m$ from above for this function:

$$m=\frac{(x+h)^2-x^2}{h}=\frac{x^2+2xh+h^2-x^2}{h}=\frac{2xh+h^2}{h}=2x+h$$

We're interested in what happens in the limit as $h\rightarrow 0$. In this case, this limit is pretty easy to evaluate:

$$\lim_{h\rightarrow 0}m=\lim_{h\rightarrow 0}(2x+h)=2x+0=2x$$

What is this statement telling us? As $h\rightarrow 0$, the secant line starts to become the _tangent line_ that is tangent to the curve $f(x)$ at a particular value of $x$. We call this a tangent line because locally, it only intersects $f(x)$ at one point. The slope of this tangent line is called the **derivative**. Based on our calculations from above, the derivative, which we'll denote as $m$ for now, is defined to be

$$m=\lim_{h\rightarrow 0}\frac{f(x+h)-f(x)}{h}$$

![derivative-x^2](/assets/images/derivative-1.png){:width="70%" height="70%"}

The above figure illustrates an example of a tangent line that is tangent to the curve $f(x)=x^2$ at the point $(2, 4)$. Based on our formula from above, the slope of this tangent line at this point is $m=2(2)=4$. Since we know that the point $(2, 4)$ lies on this tangent line, we could use the point-slope formula to then write down the explicit form of the tangent line. This is just an illustrative example of what a derivative is: _the derivative describes the slopes of tangent lines to a curve $f(x)$_.

> ## Derivative Notation

In reality, derivatives aren't denoted as $m$. There are two common ways to denote the derivative of a function $f(x)$: (1) prime notation and (2) Leibniz notation. Prime notation looks like this:

$$f'(x)=\lim_{h\rightarrow 0}\frac{f(x+h)-f(x)}{h}$$

The presence of a $'$ symbol denotes that we're taking the derivative of the function. Leibniz notation looks like this:

$$\frac{df}{dx}=\frac{d}{dx}[f(x)]=\lim_{h\rightarrow 0}\frac{f(x+h)-f(x)}{h}$$

For reasons that we'll talk about later, I _highly recommend_ you use the Leibniz notation, but you should be familiar with and able to read/use both types of derivative notations.

> ## Properties of the Derivative

Fundamentally, a derivative is defined as a limit. This means that many properties about limits can also apply to derivatives:

  1. In order for a derivative to exist, it shouldn't matter whether we approach the limit from the left or from the right. In other words, the limit must be defined from either direction. This makes sense, since we know that that $\lim_{x\rightarrow c}$ only exists when the limits $\lim_{x\rightarrow c^-}$ and $\lim_{x\rightarrow c^+}$ are equal. As an example, the derivative at $x=0$ of $f(x)=\vert x\vert$ does not exist. In general piece-wise discontinuous functions (like a step function) and functions with sharp edges (like an absolute value function).
  2. A derivative can only exist then the function is defined there. For these reasons, rational functions like $1/x$ have an undefined derivative at $x=0$, and $\sin(1/x)$ also has an undefined derivative at $x=0$.
  3. For the above reasons and a few more, we can arrive at a pretty substantial conclusion:

> Differentiability implies continuity.

This statement means that if a function is differentiable at some point $x=x_0$, then we are _guaranteed_ that the function is also continuous at the same point $x=x_0$. This also means that if we know that the function is _not_ continuous at a given point, it must also not be differentiable at that point too. However, note that the converse is not true: if the function is continuous at some point $x=x_0$, it does **not** necessarily mean that the function is is also differentiable at that same point.

> ## Differentiability Implies Local Linearity

Let's go back to the first graph of this page where we plotted the function $y=x^2$ and the tangent line of this function at the point $(2, 4)$. Imagine that we zoomed in really close to this particular point $(2, 4)$. Although the tangent line and actual function aren't necessarily equal, they do look very similar. This can often be used to our advantage to approximate function values that would otherwise be difficult to evaluate. Let's say that we know the derivative of a function, and also a point that lies on the function:

$$ df/dx\text{ and }f(a)=b\text{ are given and for some }a, b$$

Using this information, we can derive a _linear approximation_ for the function that's pretty good close to the point $(a, b)$ on the graph.

$$ y-a=\left.\frac{df}{dx}\right\vert_{x=a, y=b}(x-b)$$

The slope in the point-slope notation here is the derivative $df/dx$ evaluated at the particular point $(a, b)$. This result is called the tangent line approximation and can be used to approximate values of $y$ near $x=a$.

> ## Visualizing Derivatives

A very common type of problem asks you to graph both $f(x)$ and $df/dx$ on the same graph given one versus the other. There are three rules involving the first derivative that you should know:

  1. If $df/dx>0$ at a particular point, then $f(x)$ is increasing at that point.
  2. If $df/dx<0$ at a particular point, then $f(x)$ is decreasing at that point.
  3. If $df/dx=0$ at a particular point, then $f(x)$ has a _critical point_ at that point.

A rather unhelpful, but technically correct, definition of a **critical point** is a point where the first derivative is equal to zero. A more practical definition is a critical point is a local extremum (meaning minimum or maximum) or a saddle point. Here are three of the most common examples for critical points:

![extrema](/assets/images/extrema.png){:width="70%" height="70%"}

Let's go over a simple example to illustrate this. Consider the following graph of the derivative of $$f(x)$$:

![piecewise-derivative](/assets/images/piecewise-derivative.png){:width="50%" height="50%"}

Our goal is to sketch what $$f(x)$$ looks like given this graph of $$f'(x)$$. For $x<x_1$, $f'(x)$ is just some constant positive number, meaning that $f(x)$ is increasing by the same amount all the time irregardless of the value of $x$ we're at, so long as $x<x_1$. This corresponds to an increasing linear function. For $x_1\leq x<x_2$, $f'(x)$ is a constant negative number, and so by similar reasoning, this corresponds to a decreasing linear function. For $x\geq x_2$, $f'(x)=0$, and so the function $f(x)$ isn't decreasing or increasing: it is just remaining at some constant value since its rate of change is zero. Therefore, superimposing the graphs of $f(x)$ and $f'(x)$ together, we might have something that looks like

![piecewise-derivative](/assets/images/piecewise-derivative-2.png){:width="50%" height="50%"}

We'll be able to further improve our graph function sketches once we introduce the notion of the [second derivative](/calculus/higher-order-derivatives/index.html). Sketching either $f(x)$ or $f'(x)$ (or both) involves practice to get a strong intuition about how functions and their derivatives behave.

> ## Exercises

### Problem 1

Earlier, we asserted that just because a function is continuous at a given point does not mean that it is also differentiable at that same point. Give two different examples of shapes of functions that are continuous at at least one point, but not differentiable at that point.

### Problem 2

Consider the function $f(x)$ that we graphed above in our discussion involving using the piecewise constant $f'(x)$ function to sketch $f(x)$. This function can also be the derivative of another function, which we can denote as $F(x)$. That is, $dF/dx=f(x)$. Using our sketch of $f(x)$ above, sketch out the general shape of $F(x)$. 

### Problem 3

Consider a function $y=f(x)$ with a derivative given by

$$\frac{df}{dx}=x-y-2$$

At $x=-1$, $y$ is known to be $3$.

  1. Using this information, construct a tangent line approximation of the value of $y$ near $x=-1$. 
  2. It is known that the actual value of $y$ at $x=-0.9$ is $y(-0.9)\approx 2.434$. How good is your approximation at $x=-0.9$?
  3. It is known that the actual value of $y$ at $x=0$ is $y(0)=-3+7e^{-1}\approx -0.425$. How good is your approximation at $x=0$?
