---
permalink: /physics/mechanical-equilibrium-revisited/
title: "Mechanical Equilibrium: Rotational Motion"
toc: true
toc_label: "Contents"
---

> ## Newton's Laws

In this module, we'll be continuing to investigate how our working physics framework describes into our current understanding of rotating systems. Let's review Newton's laws for rotating systems that we introduced last time:

  1. If the net torque on an object is zero, the object will remain at constant angular velocity. This means things that are at rest, stay at rest, and things that are rotating continue to move at constant angular velocity.
  2. The sum of all the torques on an object, $\sum \vec{\tau}$, is called the net torque $\vec{\tau}_{\text{net}}$, and is given by $$\sum \vec{\tau}=\vec{\tau}_{\text{net}}\propto\vec{\alpha}$$, where $\vec{\alpha}$ is the angular acceleration. We will talk about what the proportionality constant exactly is later.
  3. For two objects $1$ and $2$ in contact, $$\vec{\tau}_{1\rightarrow 2}=-\vec{\tau}_{2\rightarrow 1}$$.

Today, we'll be talking about systems in _mechanical equilibrium_ and how this relates to these set of laws.

> ## Mechanical Equilibrium

We have talked about what it means for a system to be in **mechanical equilibrium** [before](/physics/mechanical-equilibrium/index.html#mechanical-equilibrium), but our previous definition did not take into account all of our new framework describing the net torque and how it affects the rotations of a system. In order for a system to be in mechanical equilibrium, it still remains true that the system cannot have any linear acceleration, meaning that $\sum \vec{F}=0$ still. However, we also have to assert that the system cannot have any _angular acceleration_ either! This means that things that are rotating shouldn't suddenly start rotating, and things that are rotating should continue to rotate at a constant angular velocity. This means that we now also have another requirement for mechanical equilibrium: the net torque must also be zero. This now gives us two conditions for mechanical equilibrium that must both be simultaneously satisfied:

<div class="notice--info">
<p style="font-size:13pt"> $$\sum \vec{F}=0, \quad \sum \vec{\tau}=0$$</p>
</div>

Wait a second... if we think back to systems like the inclined plane or the hanging masses, we never talked about the net torque requirement before! Does that mean that our previous physics work was wrong? It turns out that we're in the clear. The reason why is that in all of our previous physical setups, nothing was ever rotating! There was no axis of rotation or any circular motion, and so the net torque $\sum \vec{\tau}$ was always equal to zero, meaning that this second equilibrium requirement on the net torque was always implicitly satisfied.

Of course, this is not generally the case. If system components have the potential to rotate, then we need to consider the requirement on the net torque a bit more carefully. We'll talk about some the common problems involving mechanical equilibrium in the context of rotating systems here.

> ## See-Saws

[See-saws](https://en.wikipedia.org/wiki/Seesaw) are common structures that can be found in a lot of playgrounds, and essentially rely on the imbalance of torque applied on either side of the pivot on the see-saw. A standard see-saw problem might look something like this:

![rot-eq-1](/assets/images/rot-eq-1.png){:height="80%" width="80%"}

In this setup, we assume arbitrarily that $m_2\geq m_1$, and we want to know where to place $m_2$ on the see-saw such that the see-saw doesn't rotate or "teeter-totter" to one side or the other. In order words, we need to make sure that we 