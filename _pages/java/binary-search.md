---
permalink: /java/binary-search/
title: "Binary Search"
toc: true
toc_label: "Contents"
---

Last time, we learned about [recursion](/java/recursion/index.html), which we introduced as a powerful programming technique where the function calls itself. In this lesson, we'll learn about one of the most commonly tested and referenced algorithms that relies on the use of recursion. This algorithm is called **binary search**.

> ## The Setup

Imagine that we have a _sorted_ list of elements. For example, we could have a sorted list of integers:

![binary-search-1](/assets/images/binary-search-1.png){:height="70%" width="70%"}

Again, note that the list elements are _sorted_ in increasing order. The fact that the list is sorted is very important (we'll discuss why this is below). 

Our problem statement is that we want to search for whether a particular element (integer) is in this sorted list. Using our current programming methods available to us, our most promising method would probably be to iterate over every single element in the list and check if it is equal to the element that we're searching for.

```java
/* 
 * Searches list for element, and returns the index of 
 * the element if found. Otherwise, returns -1.
 */
public static int linearSearch(int[] list, int element) {
    for (int i = 0; i < list.length; i++) {
        if (list[i] == element) { return i; }
    }

    return -1;
}
```

This is a completely valid way of searching for a particular element. We call this method of searching **linear search**. Unfortunately, it turns out that this method is pretty slow and will take computers a long time to run, especially when there are a lot of elements present in the list. It also doesn't take advantage of the fact that the elements of the list are sorted. We want to determine a potentially faster method of searching that takes advantage of the fact that the list is sorted: this method is called **binary search**.

> ## Binary Search

The idea behind the binary search is that we can first divide the array into two halves, and compare the element we're searching for (call it $x$) with the element in the middle (call it $m$) that divides the two halves of the array. Since the array is sorted, we know that if $x>m$, then we only need to continue searching in the right half of the original array because the list is given to be sorted. If $x<m$, then we only need to continue searching in the left half of the original array. We can recursively continue this process until either the value is found, or if the interval is empty (meaning that $x$ was not in our original array. For example, let's say that we were searching for whether ```-1``` was in the array shown above. A visual diagram of how binary search would work is

![binary-search-2](/assets/images/binary-search-2.png){:height="100%" width="100%"}

From this binary search algorithm, we've determined that ```-1``` is not in our list, and have used the fact that the list is sorted in order to continuously restrict the the space that we have to search. Here is an example of how to implement this algorithm in Java:

```java
/* 
 * Searches list for element, and returns the index of 
 * the element if found. Otherwise, returns -1.
 */
public static int binarySearch(int[] list, int element) {
    return binSearch(list, element, 0, list.length - 1);
}

/*
 * Helper method to search the list for the element and returns
 * the index of the element if found. Otherwise, returns -1.
 * l is the index of the leftmost element of the (sub)array we're
 * searching, and r is the index of the rightmost element of 
 * the (sub)array we're searching.
 */
private static int binSearch(int[] list, int element, int l, int r) {
    // If the right index of the subarray is less than the 
    // left index, then we have an empty array, and so the element
    // is definitely not in our array. This is one of the base cases.
    if (r < l) { return -1; }

    // Find the index of the midpoint element that divides the
    // array in half.
    int mid = l + (r - l) / 2;

    // If the element that we're looking for is list[mid], then
    // we can simply return mid! (This is the other base case.)
    if (list[mid] == element) { return mid; }
    // Otherwise, handle the other two possible cases recursively
    else if (list[mid] > element) {
        return binSearch(list, element, l, mid - 1);
    }
    else {
        return binSearch(list, element, mid + 1, r);
    }
}
```

Notice that our ```public``` method, ```binarySearch()```, calls a ```private``` helper method called ```binSearch()``` in order to perform the actual algorithm. In a way, the ```private``` method is the one that is actually doing all of the calculations, while the ```public``` method isn't really doing anything except act as a "shell" around the ```private``` method, so that other Java programs can call and interact with this method. This function architecture is quite common in many Java functions (especially recursive functions), and is called a **public-private pair**.

> ## Recursive Public-Private Pairs

The main benefit of the public-private pair is that we are free to modify the parameters passed into the function to be different than the ones that the Java program actually wants to give. For example, the ```public``` method ```binarySearch()``` from above only requires the user to pass in the array and the element we're looking for. They don't also need to pass in the left and right indices that define the boundaries of the array. However, the left and right indices are crucial for us to perform the recursive steps. By separating out the function into a pair of methods, we can _abstract_ away the unnecessary variables from the user's perspective and just keep them in the private method. 

In a **public-private pair**, we have a **public**, non-recursive method that only includes the parameters that the client really wants, and a **private**, recursive method that includes the all the parameters that we need for recursion.
{: .notice--info}

> ## Comparing Linear Search and Binary Search

Let's write a program to give us an idea of how much faster binary search can be when compared to linear search. Run the following program to compare the behavior of binary search vs. linear search for different sizes arrays to search through. What do you notice? _Note: I would recommend running the program multiple times to try to get somewhat consistent results._

<iframe height="1000px" width="100%" src="https://repl.it/@myaomeow/SearchComparison?lite=true" scrolling="no" frameborder="no" allowtransparency="true" allowfullscreen="true" sandbox="allow-forms allow-pointer-lock allow-popups allow-same-origin allow-scripts allow-modals"></iframe>

> ## Sorting Non-Integers: Lexicographic Sorting

For integers, it is fairly easy to know what it means to "sort" elements. This is because there is a standard definition of what integers are greater than, less than, and equal to other integers. 

This introduces an important concept: in order to use the binary search algorithm, the elements of the array must be sorted. In order for the elements in the array to be sorted, we must have some sort of reasonable definition in order to compare two different objects in the list.

One example is for when we're sorting Strings. In order to sort different Strings, one way to sort them is through sorting them the way that dictionaries sort them in alphabetical order. We refer to this as **lexicographical sorting**. 

For things other than Strings and integers, the way to sort objects might not be intuitive. If you want to use binary search on a list of arbitrary objects, you often have to define a ```int compareTo()``` function in order to be able to realistically compare two objects. For example, the Java ```String``` object already has a pre-defined ```compareTo()``` function that sort items in lexicographical (alphabetical) order.

```java
public static void main(String[] args) {
    String a = "Alice";
    String b = "Bob";
    
    System.out.println(a.compareTo(b));
    // This prints out a negative number because "Alice" comes
    // before "Bob" in the dictionary

    System.out.println(b.compareTo(a));
    // This prints out a positive number because "Bob" comes
    // after "Alice" in the dictionary

    System.out.println(a.compareTo(a));
    // This prints out 0 because "Alice" equals
    // "Alice" in the dictionary
}
```

You can read more about the specifics of the ```compareTo()``` function specifically for Strings [here](https://www.w3schools.com/java/ref_string_compareto.asp). For other objects, you would have to define the appropriate ```int compareTo()``` function for the particular application. You can see some examples of implementing ```compareTo()``` functions [here](http://www.javapractices.com/topic/TopicAction.do?Id=10).

> ## Sorting Arrays

We've seen how binary search is a much more efficient method of sorting arrays, but getting an array to be sorted in the first place is not a trivial task. Only an _extremely_ small proportion of arrays are even sorted in the first place. [Down the road](/java/sorting-algorithms-part-1/index.html), we will be discussing different algorithms on how to actually sort the arrays in the first place in order to do binary search (or any type of searching algorithm), which is a fairly complicated task.