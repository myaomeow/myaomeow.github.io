---
title: "Bytes, Conditionals, and Loops"
date: 2020-06-03T23:34:30-04:00
categories:
  - blog
tags:
  - Java
---

## Bytes

A _bit_ is a ``0`` or a ``1``. Bits can be combined to represent numbers in binary representation. For example, the numbers 0 through 7 can be represented in binary by

  - 0 → ``000``
  - 1 → ``001``
  - 2 → ``010``
  - 3 → ``011``
  - 4 → ``100``
  - 5 → ``101``
  - 6 → ``110``
  - 7 → ``111``

In general, if you want to represent the numbers 0 through 2<sup>n</sup>-1 (or -2<sup>n-1</sup> to 2<sup>n-1</sup>-1 if you care about negative numbers too), you need at least _n_ bits. One _byte_ is 8 bits. Therefore, using _z_ bytes of data, we can represent the numbers from 0 to 2<sup>8z</sup>-1$ (or -2<sup>8z-1</sup> to 2^<sup>8z-1</sup>-1 if, again, you care about negative numbers). The range of numbers we can represent depends on the number of bytes we use: more bytes equals more numbers!