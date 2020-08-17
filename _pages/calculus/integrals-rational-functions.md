---
permalink: /calculus/integrals-rational-functions/
title: "Integrals of Rational Functions"
toc: true
toc_label: "Contents"
---

Today, our sole focus is in evaluating integral expressions where the integrand is some sort of _rational function_. That is, we are interested in evaluating integrals of the form

$$\int dx\text{ }\frac{f(x)}{g(x)}$$

where $f(x), g(x)$ are polynomials. Let's consider one of the most basic rational functions out there first.

> ## Integral of $1/x$

Let's us evaluate the antiderivative

$$\int dx\text{ }\frac{1}{x}$$

Suppose first that $x>0$. We can define the variable $u$ such that $x=e^u$, and so therefore, $u=\ln x$ and also $dx=e^udu$. It is important for us to assume here that $x>0$ because the natural logarithm of a negative number is not defined. Making this substitution into this integral gives

$$\int dx\text{ }\frac{1}{x}=\int du\text{ }\frac{e^u}{e^u}=\int du=u+C=\ln x+C$$

What about in the case where $x<0$? In this case, let's instead define the variable $u$ such that $x=-e^u$, and so therefore, $u=\ln(-x)$ and also $dx=-e^udu$. Notice that from this modified choice in $u$, the logarithm expression $\ln(-x)$ is well-defined because $-x$ is positive when $x<0$. Making this $u$-substitution into this integral gives

$$\int dx\text{ }\frac{1}{x}=\int du\text{ }\frac{-e^u}{-e^u}=\int du=u+C=\ln (-x)+C$$

Combining the results from both the positive and the negative cases, we can write that in general for all intervals involving real $x\neq 0$,

<div class="notice--success">
<p style="font-size:13pt">$$\int dx\text{ }\frac{1}{x}\ln\vert x\vert +C$$</p>
</div>

We have now proven how to evaluate the integral expressions of the form $\int dx\text{ }\frac{1}{x}$.

> ## Getting a Little More Complicated

Of course, this integral result can be combined with all of the integration framework that we have done so far, including techniques such as $u$-substitution and integration by parts. Let's go over a few example problems to illustrate how this works.

> ### Example 1

Suppose that we want to evaluate the integral expression

$$\int dx\text{ }\frac{2x-1}{x^2-x-6}$$

After learning techniques on [$u$-substitution](/calculus/u-substitution/index.html), we might keenly notice that the derivative of the denominator is the function in the numerator. Therefore, we can define $u=x^2-x-6$ and therefore $\frac{du}{dx}=2x-1$, meaning that $du=(2x-1)dx$. Making this substitution gives

$$\int du\text{ }\frac{1}{u}=\log\vert u\vert = \log \vert x^2-x-6\vert+C$$

> ### Example 2

Next, let's evaluate the integral expression

$$\int dx\text{ }\tan x$$

We can rewrite this integrand expression in terms of sine and cosine functions to get $$\int dx\text{ }\frac{\sin x}{\cos x}$$, upon which we notice that the numerator is related to the derivative of the denominator. Therefore, we can define the variable $u=\cos x$ and so $du=-\sin (x)dx$. Making this substitution into the integral gives

$$\int dx\text{ }\tan x=-\int du\text{ }\frac{1}{u}=-\ln\vert u\vert + C=-\ln\vert \cos x\vert +C$$

> ## Partial Fraction Decomposition

Imagine that we _slightly_ modified the integral from the first example above to now be in the form of

$$\int dx\text{ }\frac{2}{x^2-x-6}$$

Now, this problem suddenly became a lot harder. Recall that the technique we used to approach [example 1](/calculus/integrals-rational-functions/index.html#example-1) is to make a $u$-substitution based on the fact that the derivative of the denominator was in the numerator. However, this is no longer the case! We can try some number of attempts at making some $u$-substitutions, but none of them will work in this case. To approach more complicated integrals like this, we need an advanced technique called *partial fraction decomposition*.

> ### Example 3

**Partial Fraction Decomposition** is essentially decomposing a complicated fraction _with a factorable denominator_ into a sum of simpler fractions. For example consider the fraction

$$y=\frac{1}{6}$$

Notice that we can factor the denominator as $2\cdot 3$, and so

$$y=\frac{1}{2\cdot 3}$$

Let's assume that we can rewrite this fraction as a sum of fractions _where the denominators are the factored components of the original denominator_. In other words, we can assume that  

$$y=\frac{1}{2\cdot 3}=\frac{A}{2}+\frac{B}{3}$$

for some constants $A, B$. To solve for these constants, we can multiply both sides of this equation by the original denominator, $6$, to get

$$6y=6\frac{1}{6}=1=3A+2B$$

Therefore, we simply just need to choose a suitable $A$ and $B$ such that $3A+2B=1$. After experimenting with a few values, we can choose $A=1$ and $B=-1$. Therefore, we have decomposed the original fraction into

$$y=\frac{1}{6}=\frac{1}{2}-\frac{1}{3}$$

> ### Example 4

While we are able to perform fraction decomposition on regular "numerical" fractions, this isn't really of much help to us in the context of calculus and integration. So, let's try a harder example and decompose the fraction

$$I=\frac{2}{x^2-x-6}$$

Notice that the denominator can be factored as $x^2-x-6=(x-3)(x+2)$. Therefore, based on the example above, let's try defining an $A$ and $B$ such that

$$I=\frac{2}{x^2-x-6}=\frac{A}{x-3}+\frac{B}{x+2}$$

If we multiply both sides of this equation by the unfactored denominator $x^2-x-6=(x-3)(x+2)$, then

$$2=A(x+2)+B(x-3)=(A+B)x+(2A-3B)$$

There are no $x$ terms on the left hand side, and so the coefficient $A+B=0$ necessarily. Meanwhile, $2=2A-3B$. This gives us a system of equations in order to solve for constants $A$ and $B$. Solving this algebraically gives $B=-2$ and $A=2$, and so

$$I=\frac{2}{x^2-x-6}=\frac{2}{x-3}-\frac{2}{x+2}$$

This completes the fraction decomposition process.

Note that the fraction $I$ was the exact integrand for the motivating example [above](/calculus/integrals-rational-functions/index.html#partial-fraction-decomposition). Therefore, going back to this earlier example and using our result, we have shown that

$$\int dx\text{ }\frac{2}{x^2-x-6}=\int dx\text{ }\frac{2}{x-3}-\int dx\text{ }\frac{2}{x-2}$$

This is good! On the left hand side, we were presented with an integral with no clear way of how to approach it, but through decomposing the problem into a set of easier integrals, on the right hand side, this problem can be tackled now through straightforward $u$-substitution. We can define the variable substitutions $u=x-3$ and $v=x-2$, such that $du=dx$ and $dv=dx$. Therefore,

$$\int dx\text{ }\frac{2}{x^2-x-6}=2\int du\text{ }\frac{1}{u}-2\int dv\text{ }\frac{1}{v}=2(\ln\vert u\vert -\ln\vert v\vert)+C$$

Further simplifying and substituting back the definitions of $u$ and $v$:

$$\int dx\text{ }\frac{2}{x^2-x-6}=2\ln\left\vert\frac{u}{v}\right\vert+C=\ln\left(\frac{x-3}{x-2}\right)^2+C$$

This illustrates how the technique of partial fraction decomposition can be used to evaluate a variety of integral expressions involving rational functions.

> ## Advanced Fraction Decomposition

In this section, we will discussed some of the more nuanced cases of partial fraction decomposition that you should be aware of.

> ### Repeated Roots

Consider the problem of decomposing the following fraction:

$$\frac{1}{(x+2)^2(x-1)}$$

Ordinarily, based on the previous example, we might be inclined to guess that this fraction will be decomposed into a form $$\frac{1}{(x+2)^2(x-1)}=\frac{A}{x+2}+\frac{B}{x-1}$$. However, this is _not_ the case! The issue is that we also need to account for the fact that the $(x+2)$ root is repeated in the denominator:

$$\frac{1}{(x+2)^2(x-1)}=\frac{A}{x+2}+\frac{B}{(x+2)^2}+\frac{C}{x-1}$$

In general, assume that the factor $f(x)$ is repeated $n$ times in the denominator. The fraction decomposition will look like

$$\frac{A_1}{f(x)}+\frac{A_2}{f^2(x)}+\cdots+\frac{A_{n-1}}{f^{n-1}(x)}+\frac{A_n}{f^n(x)}+(\text{any other factors})$$

> ### Higher Power Factors

Consider the problem of decomposing the following fraction:

$$\frac{1}{x^4-1}$$

Through using the difference of squares formula $a^2-b^2=(a+b)(a-b)$, we can decompose this fraction as

$$\frac{1}{x^4-1}=\frac{1}{(x^2+1)(x^2-1)}=\frac{1}{(x^2+1)(x+1)(x-1)}$$

Based on the previous examples, we might be inclined to guess that this fraction will be decomposed into a form $$\frac{1}{(x^2+1)(x+1)(x-1)}=\frac{A}{x^2+1}+\frac{B}{x+1}+\frac{C}{x-1}$$. However, this is _not_ the case! The issue is that we also need to account for the fact that the $x^2+1$ root is a polynomial of order $2$ in the denominator:

$$\frac{1}{x^4-1}=\frac{Ax+B}{x^2+1}+\frac{C}{x+1}+\frac{D}{x-1}$$

In general, assume an unfactorable factor $f(x)$, a polynomial of degree $n$, is in the denominator. The fraction decomposition will look like

$$\frac{A_{n-1}x^{n-1}+A_{n-2}x^{n-2}+\cdots+A_1x+A_0}{f(x)}+(\text{any other factors})$$

> ## Exercises

> ### Problem 1

<p style="font-size:13pt">Decompose the following set of fractions:</p>
<ol>
  <li style="font-size:13pt">$$\frac{e^x}{(e^x-1)(e^x+3)}$$</li>
  <li style="font-size:13pt">$$\frac{3x+1}{x^2(x^2+25)}$$</li>
  <li style="font-size:13pt">$$\frac{4x^3+16x+7}{(x^2+4)^2}$$</li>
</ol>
  
> ### Problem 2

<p style="font-size:13pt">Evaluate the following integral expressions:</p>
<ol>
  <li style="font-size:13pt">$$\int\frac{\cos x}{\sin^3x+\sin x}dx$$</li>
  <li style="font-size:13pt">$$\int\frac{\sec^2 x}{\tan^3x-\tan^2 x}dx$$</li>
  <li style="font-size:13pt">$$\int_3^4\frac{x^3-2x^2-4}{x^3-2x^2}dx$$</li>
</ol>
<p style="font-size:13pt"><em>Hint: Before approaching the last integral, try to carry out <a href="https://www.math.ucla.edu/~noah/teaching/math3b-w19/partial-fractions.pdf">fraction long division</a> first.</em></p>