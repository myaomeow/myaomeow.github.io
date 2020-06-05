---
permalink: /physics/newton-laws-and-kinematics/
title: "Newton's Laws and Kinematic Equations"
---

> ## Newton's Laws

Newton's Laws describe the classical motion of any object. They are:

  1. If the net force on an object is zero, the object will remain at constant velocity. This means things that are at rest, stay at rest, and things that are moving continue to move at constant velocity.
  2. The sum of all the forces on an object, $\sum \vec{F}$, is called the net force $\vec{F}_{\text{net}}$, and is given by $$\sum \vec{F}=\vec{F}_{\text{net}}=m\vec{a}$$.
  3. For two objects $1$ and $2$ in contact, $$\vec{F}_{1\rightarrow 2}=-\vec{F}_{2\rightarrow 1}$$.

A force $\vec{F}$ is a vector quantity and defined to be the product of an object's mass $m$ and acceleration $\vec{a}$. The unit of force is the Newton $\text{N}=\text{kg}\cdot\text{m}\cdot\text{sec}^{-2}$.

> ## Kinematic Equations

Kinematic equations apply for any motion in a given dimension _assuming constant acceleration_. They are:
  1. $x_f=x_i+v_it+\frac{1}{2}at^2$
  2. $v_f=v_i+at$
  3. $x_f=x_i+\frac{v_i+v_f}{2}t$
  4. $v_f^2=v_i^2+2a(x_f-x_i)$

The $f$ subscript denotes a final quantity and $i$ subscript denotes an initial quantity. For projectile trajectory problems involving gravity, $a=g\approx 10\text{ m}\cdot\text{sec}^{-2}$. Remember that gravity always acts in the $-\hat{y}$ direction!

> ## Work and Energy

Work $W$ is defined by

$$
W=\int_{\vec{x}_i}^{\vec{x}_f}d\vec{x}\cdot\vec{F}(\vec{x}) \text{ or } W=\int_{x_i}^{x_f}dx\text{ }F(x)
$$

The first definition above is in 2- or 3- dimensions and is the more general case (we will talk about how to actually evaluate such an integral later). You will most likely find the second definition of work given more useful. Work is the space-integral of force. Energy $U$ is defined by

$$
-\vec{\nabla}U=\vec{F}(\vec{x}) \text{ or } -\frac{dU}{dx}=F(x)
$$

Again, the notation in the first definition is probably unfamiliar, so just ignore it for now. If you look at the definitions of work and energy, you can see that $W=-F$. We say that work $W$ is _path-independent_ if $F$ is a _conservative force_ (which is most forces). Note that in order to do work on an object, the object must move (in other words, holding a brick in the air but not moving it does no work!). The unit of force is the Joule $\text{J}=\text{kg}\cdot\text{m}^2\cdot\text{sec}^{-2}$.

> ## Exercises

### Problem 1

An electron is traveling in the $+\hat{x}$ direction at an initially constant speed of $v=2.10\times 10^7\text{ m}\cdot\text{sec}^{-1}$. The electron enters an electric field at time $t=0$ that deflects the electron by giving it a constant acceleration of $5.30\times 10^{15}\text{ m}\cdot\text{sec}^{-2}$ in the $+\hat{y}$ direction.

  1. How long does it take for the electron to cover a horizontal distance of $6.2\times10^{-2}\text{ m}$?
  2. What is the vertical displacement of the electron during this time?

### Problem 2

Consider a one-dimensional system with a position-dependent force $F(x)$ acting on a particle over the entirety of the real number line.

  1. Take $$F(x)=e^{-\vert x\vert}$$. What is the work required to 'push' the particle from $$x=-1$$ to $$x=1$$?
  2. Take $$F(x)=e^{-\vert x\vert}$$. What is the work required to 'push' the particle from $$x=-\infty$$ to $$x=\infty$$?
  3. Take $F(x)=xe^{-x}$. What is the total energy stored in the system between $x=0$ and $x=\infty$?
  4. It is not possible to calculate the total energy of the system described in Part (3) above from $x=-\infty$ to $x=\infty$. Why? \textit{Hint: What is the value of $F(x)$ at $x=-\infty$?}
