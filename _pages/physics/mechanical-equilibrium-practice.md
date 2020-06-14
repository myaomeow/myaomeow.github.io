---
permalink: /physics/mechanical-equilibrium-practice/
title: "Practice with Mechanical Equilibrium"
---

Physics problems involving mechanical equilibrium are very common. For this reason, we will practice doing a couple of these problems today.

> ## Practice with Mechanical Equilibria

> ### Example 1: Two Masses on an Inclined Plane

_This problem is adapted from Caltech's Ph1a course._

Upon an inclined plane of angle $\theta$ is placed a block of mass $m_2$. Upon $m_2$ is placed another block of mass $m_1$. The coefficient of static friction between $m_2$ and the inclined plane is $\mu_{2s}$ and the coefficient of sliding friction is $\mu_{2k}$. Likewise, the coefficient of static friction between $m_1$ and $m_2$ is $\mu_{1s}$ and the coefficient of sliding friction is $\mu_{1k}$. A force $F$ upward and parallel to the plane is applied to $m_2$.

![practice-1](/assets/images/mech-practice-1.png){:height="60%" width="60%"}

  1.  What is the acceleration of $m_2$ when $m_1$ just starts to slip on it?
  2.  What is the maximum value of $F$ before this slipping takes place?

In any of these mechanical equilibrium problems, remember that the initial step is almost always the same: **draw force diagrams and set $\sum \vec{F}=0$**. Here, we can draw the force diagrams for both masses $m_1$ and $m_2$:

![practice-1-force-diagram](/assets/images/mech-practice-1-fd.png){:height="80%" width="80%"}

This diagram is complicated, so we'll explain all of the forces we need to account for:

  1. Force of gravity. We denote the force of gravity on $m_1$ as $$\vec{F}_{1g}$$ and on $m_2$ as $$\vec{F}_{2g}$$.
  2. The applied force on $m_2$, which we denote as $\vec{F}$.
  3. The normal force on $m_2$ due to the inclined plane, denoted as $$\vec{N}_2$$. We also have the normal force on $m_2$ due to the presence of $m_1$, denoted as $\vec{N}_{12}$.
  4. By Newton's third law, there is also a normal force on $m_1$ from $m_2$, denoted as $$\vec{N}_{21}=-\vec{N}_{12}$$.
  5. The friction force on $m_2$ due to the inclined plane, denoted as $\vec{F}_{2f}$.
  6. The friction force on $m_2$ due to $m_1$, denoted as $\vec{F}_{12f}$. By Newton's third law, there is also a friction force on $m_1$ due to $m_2$, denoted as $$\vec{F}_{21f}=-\vec{F}_{12f}$$.

After accounting for all of the forces, we can write the force balance laws for both of the masses in both the $x$ and $y$ directions:

  1. $$F_{21f}-m_1g\sin\theta=0$$ and $$N_{21}-m_1g\cos\theta=0$$.
  2. $$F_{2f}+F-F_{12f}-m_2g\sin\theta=F_{2, x}$$ and $$N_2-N_{12}-F_{2g}\cos\theta=0$$.

Notice that for the second block, we did not set the right hand side of the $\hat{x}$-direction force balance equation equal to zero. This is because as hinted in the problem, although the first block may be in mechanical equilibrium, the second block may be accelerating in the $\pm\hat{x}$ direction. This is the quantity that we are interested in. 

To answer the first question, when $m_1$ just starts to slip, this means that $$F_{21f}=\mu_{1s}N_{21}$$. At the same time, this also means that $$F_{12f}=\mu_1N_{12}=\mu_1N_{21}$$ by Newton's third law. Plugging this in above gives

  1. $$\mu_{1s}N_{21}-m_1g\sin\theta=0$$ and $$N_{21}-m_1g\cos\theta=0$$.
  2. $$\mu_{2k}N_2+F-\mu_{1s}N_{21}-m_2g\sin\theta=F_{2, x}$$ and $$N_2-N_{21}-m_2g\cos\theta=0$$.

The first pair of equations gives us $N_{21}=\frac{m_1g}{\sqrt{1+\mu_{1s}^2}}$ and $\sin\theta=\frac{\mu_{1s}}{\sqrt{1+\mu_{1s}^2}}$ (meaning that $\cos\theta=\frac{1}{\sqrt{1+\mu_{1s}^2}}$). Plugging this into the last equation allows us to solve for $N_2$:

$$N_2=N_{21}+m_2g\cos\theta=\frac{(m_1+m_2)g}{\sqrt{1+\mu_{1s}^2}}$$

And plugging this into the final equation for $F_{2, x}$ and dividing by $m_{2}$ allows us to solve for the acceleration of mass $m_2$ when $m_1$ begins to slip, as desired. We'll leave this as an exercise to finish up this question. Answering part 2 of this question is easy to do as well: the idea is to take $\mu_{2k}\rightarrow 0$ (that is, there's _no kinetic friction_ between the mass $m_2$ and the inclined plane), and solve for $F$.

> ### Example 2: A Hanging Rope

_This problem is adapted from Caltech's Ph1a course._

A rope of length $2l$ and uniform density (here: mass per unit length) $\rho$ is hanging over a nail in a wall with a piece of length $l$ on both sides. Friction, the thickness of the nail, and the thickness of the rope are negligible. When one creates a slight length difference between the two sides, a net force will start to act on the rope, and it will slide off the nail, faster and faster.

  1. When the length on one side is $l+x$ (with $0 < x < l$), what is the net force on the rope?
  2. Find the velocity as a function of $x$. _Hint: make use of $\frac{dv}{dt}=\frac{dv}{dx}\frac{dx}{dt}$._ What is the velocity when the rope completely comes off the nail?

When both sides of the rope are the same length, then our physical intuition tells us that the rope is in mechanical equilibrium. This is because the gravitational force is equal on both sides of the rope. What happens when the length on one side is $l+x$? The gravitational force on this side is $F_{>}=mg=\rho(l+x)g$. Meanwhile, the gravitational force on the other side is $F_{<}=mg=\rho(l-x)g$. Therefore, the magnitude of the net downwards force on the rope is

$$ F_{\text{net}}=F_{>}-F_{<}=\rho(l+x)g-\rho(l-x)g=2\rho xg$$

This answer the first question. The mass of the entire rope is $2\rho l$, meaning that the acceleration of the rope due to this force is $a=\frac{dv}{dt}=\frac{xg}{l}$. At this point, we can make the educated guess that $v=\frac{dx}{dt}=x\sqrt{g/l}$, which that $\frac{dv}{dx}=\sqrt{g/l}$. Plugging this into the hint gives us the expected result, allowing us to conclude that the velocity of the rope as a function of $x$ is given by

$$\vec{v}=-x\sqrt{\frac{g}{l}}\hat{y}$$

and so the velocity $$\vec{v}_{\max}$$ when the rope completely comes off at $x=l$ is $\vec{v}_{\text{max}}=-\hat{y}\sqrt{gl}\hat{y}$.

> ### Example 3:

Two blocks of mass $m$ and $M$ are connected via pulley with a configuration shown below:

![practice-3](/assets/images/mech-practice-3.png){:height="60%" width="60%"}

The coefficient of static friction is $\mu_s$ between the block and surface. What is the minimum and maximum mass $M$ so that no sliding occurs?

Again, let's refer back to our problem-solving algorithm from Problem 1. First, let's draw the force diagrams for both of the masses:

![mech-practice-3-fd](/assets/images/mech-practice-3-fd.png){:height="60%" width="60%"}

From [last time](/physics/pulleys/index.html), we know that the pulley gives us that equal magnitude of acceleration and also equal force. This means that $T_M=T_m$ and the acceleration magnitudes are the same. We can then write down the mechanical equilibrium force balance laws for mass $M$, given that we have $mg-T_m=mg-T_M=ma$ for mass $m$:

  1. $T_M+F_f-Mg\sin\theta=Mg+\mu_sN-Mg\sin\theta=Ma$
  2. $N-Mg\cos\theta=0$

This tells us that $N=Mg\cos\theta$, and so plugging this into the first equation and using $T_M-mg=ma$ gives us a system of equations to solve for $a$: $a=\frac{mg-Mg(\sin\theta-\mu_s\cos\theta)}{M+m}$. We want the acceleration to be zero, and solving for $M$ gives $M=\frac{m}{\sin\theta-\mu_s\cos\theta}$. 

This represents our first bound on $M$. Notice that in this diagram, the force of friction is in the $+\hat{x}$ direction. Intuitively, this occurs when the mass $M$ is so massive that it has the "desire" to slide down the ramp, even with the extra force of being tethered to mass $m$. $M$ could be very light and therefore be pulled upwards by the mass $m$ as well. In this case, the force of friction would run in the opposite direction, giving us the following force diagrams:

![mech-practice-3-fd-2](/assets/images/mech-practice-3-fd-2.png){:height="60%" width="60%"}

This changes our $\hat{x}$ equilibrium equation to $T_m-\mu_sN-Mg\sin\theta=Ma$, and after plugging in $N=Mg\cos\theta$ once more, $M=\frac{m}{\sin\theta+\mu_s\cos\theta}$. Therefore, our range of possible $M$ values before the block begins to slip is

$\frac{m}{\sin\theta+\mu_s\cos\theta}< M <\frac{m}{\sin\theta-\mu_s\cos\theta}$

> ## Exercises

> ### Problem 1

_This problem is adapted from [this link](https://www.real-world-physics-problems.com/pulley-problems.html)._

A block of mass $M$ is pulled using a pulley at constant velocity along a surface inclined at angle $\theta$. The coefficient of kinetic friction is $\mu_k$, between block and surface. Determine the pulling force $F$.

![practice-5](/assets/images/mech-practice-4.png){:height="70%" width="70%"}

> ### Problem 2

_This problem is adapted from [this link](https://www.real-world-physics-problems.com/pulley-problems.html)._

A block of mass $m$ is lifted at constant velocity using the two pulleys shown.

![practice-5](/assets/images/mech-practice-5.png){:height="30%" width="30%"}

Determine the magnitude of the pulling force $F$. Ignore the mass of the pulleys.