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

A list is an example of an **abstract data type (ADT)**, which is an abstract, mathematical classification for certain types of data types. ADTs are defined by the methods, fields, and properties that are available to the user when they use an implementation of the particular ADT. Each ADT is a general class of different ADT implementations. For example, a list is an ADT, and two different ADT implementations are ```ArrayList``` and ```LinkedList```s.

In Java, abstract data types can be thought of as ```interface```s, which are a collection of abstract methods. An _implementation_ of an ```interface``` then actually explicitly writes out what each of the abstract methods does. For example, the abstract methods that are compose the list ```interface``` can be found at this link [here](https://docs.oracle.com/javase/8/docs/api/java/util/List.html).

Let's suppose that we wanted to write our implementation of list ```interface```. Some of the methods in the Java list ```interface``` are a bit too advanced for us to actually implement, so let's define our own list ```interface```:

```java
public interface MyListInterface<E> {
    // Add an element to the end of the list.
    public void add(E element);

    // Get an element at a particular index.
    // Return null if index is invalid.
    public E get(int index);

    // Change the element at the particular index.
    // Return the previous element at that index.
    // Return null and do nothing if index is invalid.
    public E set(int index, E element);

    // Remove the element at the particular index.
    // Return the previous element at that index.
    // Return null and do nothing if index is invalid.
    public E remove(int index);

    // Insert the element at the particular index.
    public void insert(int index, E val);

    // Clear the whole list.
    public void clear();

    // Return the index of the first index of an object
    // in the list. Otherwise, if the object isn't found,
    // return -1.
    public int indexOf(Object o);

    // Return the number of elements in the list.
    public int size();

    // Convert the list into an array.
    public E[] toArray();

    // Return whether the number of elements is zero in the list.
    public boolean isEmpty();
}
```

This code is contained in its own standalone file ```MyListInterface.java```. Any data structure that chooses to implement this ```MyListInterface``` interface is expected to implement at least all of these different methods. 