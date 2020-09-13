---
permalink: /projects/dimensions-of-coronavirus/
title: "Dimensionality of Social Distancing during the COVID-19 Pandemic"
toc: true
toc_label: "Contents"
---

One property of high-dimensional $d$-space is that the volume a $d$-dimensional body is concentrated near its surface. In fact, for a $d$-dimensional unit hypersphere, the fraction $f_{\varepsilon}$ of the volume of the sphere concentrated between radius $1-\varepsilon$ and $1$ is given by

$$f_{\varepsilon}=1-(1-\varepsilon)^d$$

The Wikipedia link [here](https://en.wikipedia.org/wiki/N-sphere) gives the proof of this mathematical fact, but essentially, since $\varepsilon<1$, this means that $f_{\varepsilon}$ approaches unity as $d\rightarrow\infty$. 

High-dimensional systems are commonly of interest in a variety of fields of science, including (but not limited to) [thermodynamics](https://en.wikipedia.org/wiki/Phase_space), [machine learning](https://en.wikipedia.org/wiki/Dimensionality_reduction), and [directed protein evolution](https://en.wikipedia.org/wiki/Directed_evolution). It turns out that modeling systems in high dimensions can also offer us more effective ways to social distance during the 2020 [COVID-19 Pandemic](https://en.wikipedia.org/wiki/Coronavirus_disease_2019).

> ## Collisions in High Dimensions

Because of how $f_{\varepsilon}$ behaves as a function of $d$, it turns out that as $d$ increases, collisions between objects in $d$-dimensional space become increasingly less frequent. Perhaps the easiest way to understand is that because the majority of a volume collection (proportional to $r^d$, where $r$ is the radius) is concentrated in towards the outer surface area (proportional to $r^{d-1}$, where $r$ is the radius), a particular particle that has equal probability of being at any radius inside the hypersphere becomes less and less likely to be encased in the volume where all of the other particles are. Another way of understanding this phenomenon is that as $d$ increases, so does the number of directions that a particular particle can travel, and so it becomes less likely that any two particles are going to collide.

This abstract notion can help inform societal decisions on social distancing parameters, particularly during a pandemic. I remember being inspired by a simple computational model published by the [Washington Post](https://www.washingtonpost.com/graphics/2020/world/corona-simulator/) that illustrated the efficacy of quarantining and social distancing in "flattening the curve."

![covid-wj](/assets/images/covid-wj.png)
_Simulation from the Washington Post._

Unfortunately for many Americans at the time of writing (September 2020), the fact of the matter is that it has been difficult for the United States to find common ground in social distancing, and so simply "asking" more of these small dots to self-isolate is difficult to accomplish.

My goal is to investigate whether playing around with other parameters of social distancing can help achieve a similar outcome in slowing the spread of COVID-19 without requiring a large proportion of the population to self-isolate.

> ## Dimensions of Social Distancing

I argue that the efficacy of social distancing can be increased simply by increasing the number of dimensions of social distancing. For the most part, the two-dimensional landscape featured by the Washington Post simulation is fairly accurate of everyday life. Aside from office buildings towering in office sky scrapers, the majority of everyday life is confined within two dimensions: the $x$ and $y$ dimensions. We all typically exist at the same ground level, and all perform our tasks at around the same time of day, such as buying groceries and going to our work offices.

However, what if we were able to _increase_ the number of dimensions that the small dots in the Washington post simulation were able to move in? This could mean working in different building floors (space permitting) to add an extra $z$ dimension of functional movement, or spacing out when we go out to work or buy groceries to add an extra time $t$ dimension, or some combination of these and other parameters.

To investigate this, I ran a simulation similar to the initial one conducted by the Washington Post linked above, except this time, I allowed the number of dimensions that each of the particles could move in to be a free parameter between $n=1$ (one spatial dimension) and $n=4$ (three spatial dimensions and one time dimension). The simulation results averaged over $n=10$ trials for each dimension are shown here:

![coronavirus-simul](/assets/images/corona.png)

In this simulation, I used the same set of parameters for each number of dimensions tested, as outlined here:

<table style="width:100%">
  <tr>
    <th>Parameter</th>
    <th>Value</th>
  </tr>
  <tr>
    <td>Total Number of Particles (People)</td>
    <td>500</td>
  </tr>
  <tr>
    <td>Number of Dimensions $d$</td>
    <td>1, 2, 3, or 4</td>
  </tr>
  <tr>
    <td>Length of the $d$-Dimensional Hypercube for Particle Interaction</td>
    <td>500</td>
  </tr>
  <tr>
    <td>Maximum Speed of a Single Particle</td>
    <td>100 per time step</td>
  </tr>
  <tr>
    <td>Number of Time Steps for the Simulation</td>
    <td>100 time steps</td>
  </tr>
  <tr>
    <td>Maximum Radius of a Single Particle</td>
    <td>25</td>
  </tr>
  <tr>
    <td>Initial Proportional of Total Population Infected</td>
    <td>1%</td>
  </tr>
  <tr>
    <td>Number of Time Steps an Infected Particle is Infected For</td>
    <td>5 to 14</td>
  </tr>
</table>

The unit of distance in the above table of parameters is simply some arbitrary choice of unit length. The speed and radius of the individual particles were randomly chosen for each of the particles in the simulation from a uniform distribution from 0 to their respective maximum values. Similarly, the number of time steps an infected particle remain infected for (and therefore could transmit the disease to susceptible members of the population) was chosen from a uniform integer distribution between 5 and 14 time steps (inclusive). These three parameters helped to account for the inherent variability in people's distance travelled every day, how close people need to be in proximity in order to get infected, and how long infected people are sick for in real life.

> ## Discussion

As we can see from the simulation data graphed above, increasing the number of dimensions available for social distancing can have a _substantial_ impact in flattening the curve of infection. For each of the curves above, I calculated the maximum number of people infected at any given time step, and also the FWHM (which can be though of as the spread/width of the bell curve) when fitting each of the curves to a Gaussian distribution:

<table style="width:100%">
  <tr>
    <th style="font-size:13pt;text-align:center">Dimension $d$</th>
    <th style="font-size:13pt;text-align:center">Peak Number Infected</th>
    <th style="font-size:13pt;text-align:center">FWHM (Time Steps)</th>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center">1</td>
    <td style="font-size:13pt;text-align:center">500</td>
    <td style="font-size:13pt;text-align:center">11</td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center">2</td>
    <td style="font-size:13pt;text-align:center">500</td>
    <td style="font-size:13pt;text-align:center">11</td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center">3</td>
    <td style="font-size:13pt;text-align:center">164</td>
    <td style="font-size:13pt;text-align:center">22</td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center">4</td>
    <td style="font-size:13pt;text-align:center">6</td>
    <td style="font-size:13pt;text-align:center">13</td>
  </tr>
</table>

As we can see from the data above, the curve is significantly flattened when we increase the number of dimensions of movement from $d=1$ or $d=2$, to $d=3$ or $d=4$ given our selected data parameters. 

The areas under each of the bell curves (AUC) can also be estimated as a function of the dimension $d$ according to the simulation data:

<table style="width:100%">
  <tr>
    <th style="font-size:13pt;text-align:center">Dimension $d$</th>
    <th style="font-size:13pt;text-align:center">AUC (Number of Particles-Time Steps)</th>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center">1</td>
    <td style="font-size:13pt;text-align:center">5253</td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center">2</td>
    <td style="font-size:13pt;text-align:center">5284</td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center">3</td>
    <td style="font-size:13pt;text-align:center">3987</td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center">4</td>
    <td style="font-size:13pt;text-align:center">64</td>
  </tr>
</table>

The AUC can be thought of as the measure of "weight" of the impact of the infection on the population, as it takes into account both the number of people infected and how long they were infected. In essence the AUC can hypothetically be an indicator for, say, the strength of the impact of the pandemic on the economy or on healthcare spending. Using our particular simulation parameters, there is a modest, promising decrease in the area under the curve going from $d=2$ to $d=3$, and and a substantial _6200% decrease_ in the AUC going from $d=3$ to $d=4$. Clearly, increasing the number of dimensions of movement in a society can also greatly reduce the impact of the pandemic on this modeled society.

> ## Limitations of the Simulation

Many people might argue that this simulation inaccurately incorporates the dimension of time into the model, due to the reasoning that we as human beings can only move "forward" in the positive $t$ direction in real life. I argue that this issue contributes minimally at best because although we can _physically_ only move in the positive $t$ direction, bidirectional movement in the temporal dimension allows us to incorporate the idea of infection from lingering aerosol virus particles or transmission via touching infected surfaces that were infected hours or even days ago into the model. Delayed transmission can be thought of as the virus traveling "back" in time in the $-\hat{t}$ direction. While this line of thinking is by no means perfect, it allows us to simplify the model by treating the temporal dimension as the same as any of the three spatial dimensions.

This model also relied on arbitrarily chosen parameters in the table [above](/projects/dimensions-of-coronavirus/index.html#dimensions-of-social-distancing) that were not necessarily based in historical and current data on the coronavirus. In order to make this model more accurate, we can attempt to choose parameters for the simulation that more accurately reflect the real-life situation around us. This would allow us to make more accurate predictions on how increasing the dimensionality of particle (human) movement will effect the efficacy of social distancing. 

Because all of the particles in our simulation are moving independently, this simulation doesn't model the inherent social structures integrated into society. That is, families and friends often travel together and national social movements can encourage large proportions of the society to move at around the same speed and in the same location, which will inevitably impact viral transmission speed. These complex factors due to human behavior were not incorporated into this simulation.

Finally, it was assumed in this simulation that all individuals were moving at some nonzero velocity, meaning voluntary self-isolation at home was not taken into account. 

> ## Conclusions

This simple simulation suggests that _even if no one self-isolates in their homes_, we can flatten the curve of infection and reduce the rate of infection when we add extra dimensions to travel. This can mean spacing out the times when students come to the library or workers report to the office, or running half of in-person classrooms on the first floor and a second half on the second floor. Other innovative solutions could even increase the number of dimensions of social movement past $n=4$. Through taking advantage of statistical physics and computer modeling, we may be able to drastically reduce the spread of COVID-19 in real life.

> ## Simulation Code

The repository for this simulation can be found [here](https://github.com/myaomeow/COVID19-Simulator). The ```src``` code is written in Java, and the data analysis and plot for this simulation was made in Microsoft Excel (also included in the repository)