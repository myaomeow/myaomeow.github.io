---
permalink: /calculus/chain-rule/
title: "The Chain Rule"
---

Today, we'll be learning about the **chain rule**, which is arguably one of the most powerful differentiation techniques out there. The utility of the Leibniz notation will also really show today over that of the prime notation as well. To motivate our discussion of the chain rule, consider the following function $f(x)=(x+2)^{9}$. Using the current differentiation tools available to us, we would probably have to expand out the right hand side using the binomial theorem, and then differentiate the binomial terms one by one. This is extremely tedious and a bit unreasonable. To make this easier, we can use the chain rule. 

Conceptually, the chain rule relies on the fact that we can think of a derivative $df/dx$ as a sort of ratio between two very small quantities: $df$ and $dx$. Although this isn't _entirely_ a fraction, it is a pretty good way of thinking about it. Recall that given a fraction $a/b$, we can always rewrite it as $\frac{a}{b}=\frac{a}{c}\frac{c}{b}$. The chain rule is simply applying this concept to derivatives:

> $$\frac{df}{dx}=\frac{df}{d\eta}\frac{d\eta}{dx}$$

What is $\eta$? $\eta$ is a variable that can be whatever you want: basically an expression that is most convenient for you to evaluate. As an example, let's go back to our original example of $f=(x+2)^9$. We can rewrite this function as $f=\eta^9$, where $\eta=x+2$. Now, the derivative of $f$ with respect to $\eta$ is $\frac{df}{d\eta}=9\eta^8$ by the power rule. The derivative of $\eta$ with respect to $x$ is $1$, since we learned that the derivative of any linear function is just the slope of that function. Therefore, plugging these expressions into the definition of the chain rule defined above, we have

$$\frac{d}{dx}\left[(x+2)^9\right]=9\eta^8\cdot 1=9\eta^8$$

Obviously, we want our final answer in terms of $x$, not $\eta$, and so we can substitute back in $\eta=x+2$ to get our final answer:

$$\frac{d}{dx}\left[(x+2)^9\right]=9(x+2)^8$$

And that's it! If you happened to expand out this binomial expression, you would find that you get the exact same result as first expanding out the original function $f(x)=(x+2)^9$ and then differentiating. 

The chain rule can also be used multiple times in conjunction. For example, if it is advantageous to define a variable $\eta_2$ in terms of $x$, and then a variable $\eta_1$ in terms of $\eta_2$, and then the function $f$ in terms of $\eta_1$, then you can always use the chain rule by applying the same exact methodology:

$$\frac{df}{dx}=\frac{df}{d\eta_1}\frac{d\eta_1}{d\eta_2}\frac{d\eta_2}{dx}$$

For example, consider the function $f(x)=\sqrt{(x+2)^9+3}$. We want to evaluate its first derivative using the chain rule. Define the variable $\eta_2=x+2$. This gives us $f=\sqrt{\eta_2^9+3}$. Define the variable $\eta_1=\eta_2^9+3$. This gives us $f=\sqrt{\eta_1}=\eta_1^{1/2}$. We can easily evaluate the derivatives of each of these smaller expressions using only the power rule:

$$\frac{df}{d\eta_1}=\frac{d}{d\eta_1}\left[\eta_1^{1/2}\right]=\frac{1}{2\sqrt{\eta_1}}$$

Similarly,

$$\frac{d\eta_1}{d\eta_2}=\frac{d}{d\eta_2}\left[\eta_2^9+3\right]=9\eta_2^8,\quad\frac{d\eta_2}{dx}=\frac{d}{dx}\left[x+2\right]=1$$

Combining all of these results using the chain rule gives

$$\frac{df}{dx}=\frac{1}{2\sqrt{\eta_1}}\cdot(9\eta_2^8)\cdot 1=\frac{9\eta_2^8}{2\sqrt{\eta_2^9+3}}=\frac{9(x+2)^8}{2\sqrt{(x+2)^9+3}}$$

Note that this derivative would be essentially impossible to evaluate without the chain rule. In general, you can always introduce any number of variables as per your convenience:

$$ \frac{df}{dx}=\frac{df}{d\eta_1}\frac{d\eta_1}{d\eta_2}\cdots\frac{d\eta_{n-1}}{d\eta_n}\frac{d\eta_n}{dx}$$

We call instances like these _nested chain rules_ where you have more than one $\eta$ variable.

The chain rule can also be expressed in terms of the prime notation (although I don't necessarily recommend this). It might look something like this:

$$f'(x)=f'(g(x))\cdot g'(x)$$

Personally, I find this notation to be a bit clunky and so I don't particularly like using it. Furthermore, how would we even represent nested chain rule instances using this notation? Something like

$$f'(x)=f'(g(h(x)))\cdot g'(h(x))\cdot h'(x)$$

seems too clunky and confusing for my liking. The chain rule is an instance where the Leibniz notation is much more convenient than the prime notation.

> ## Exercises

> ### Problem 1

Differentiate the following functions using the chain rule. Identify any intermediate variables $\eta_1, \eta_2, \ldots$ as necessary, and write down the corresponding derivatives $\frac{df}{d\eta_1}, \frac{d\eta_1}{d\eta_2}, \ldots$ as well in order to show your work.

  1. $k(x)=(2x^2+x)^{99}$
  2. $m(x)=(4t^2-3t+2)^{-1}$
  3. $n(z)=\sqrt[3]{1-8z}$

> ### Problem 2

Find the second derivatives of the three functions $k(x), m(x), n(z)$ from Problem 1, again using the chain rule.

> ### Problem 3

Suppose that we have some function $f(x)$ that is guaranteed to have a first and second derivative (i.e. is twice differentiable). $f(x)$ satisfies the property

$$f(x^2)=f(x)+x^2$$

  1. What is $f'(1)$?
  2. What is $$f''(1)$$?

Your answers should be numbers, not algebraic expressions.