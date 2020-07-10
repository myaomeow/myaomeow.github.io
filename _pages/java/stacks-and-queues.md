---
permalink: /java/abstract-data-types/
title: "Abstract Data Types"
toc: true
toc_label: "Contents"
---

In our discussion about [```ArrayList```s](/java/lists-and-arrays/index.html) and [```LinkedList```s](/java/linked-lists-and-matrices/index.html), we briefly discussed the properties of the **List interface**. These two List implementations were different in terms of utilizing computer memory and how worked "under-the-hood," but from an outside program, they looked exactly the same. That is, the List interface has a certain number of special properties about it:

  - It can multiple individual elements that are all of the same variable type.
  - It can maintain the order of the elements.
  - It can add, remove, access, and do many other things with the elements of the list.
  - We can create lists, print lists, copy them, compare them, and a variety of other basic procedures.

The list can be thought of as having some set of _fundamental_ properties for the user of the class. Any class that is able to implement all of these fundamental properties can therefore be considered a list.

A list is an example of an **abstract data type (ADT)**, which is an abstract, mathematical classification for certain types of data types. ADTs are defined by the methods, fields, and properties that are available to the user when they use an implementation of the particular ADT. Each ADT is a general class of different ADT implementations. For example, a list is an ADT, and two different ADT implementations are ```ArrayList``` and ```LinkedList```s. This is because they _implement_ all of the fundamental methods of the list ADT, including methods like ```.get()```, ```.add()```, ```.remove()```, and others.

> ## Java Interfaces

In Java, ADTs are represented by something known as **interfaces**.