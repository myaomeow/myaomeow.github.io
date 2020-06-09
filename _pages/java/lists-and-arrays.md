---
permalink: /java/lists-and-arrays/
title: "Lists and Arrays"
---

Today we'll be learning about a fundamental variable type: lists. A list is simply and ordered set of items. For example, take a list of errands you might have for the day, which may include

  1. Thaw meat from the freezer.
  2. Go to the bank.
  3. Buy groceries.
  4. Visit friends.
  5. Cook dinner.

The order in which we do this tasks is important. For example, we have to thaw the meat at the beginning of the day in order for it to be cooked for dinner. And you can only visit your friends in the afternoon at the time they invited you to come over. As a Java list, one way to represent this list of errands might be

```java
String[] errands = { "Thaw meat from the freezer", "Go to the bank", 
                    "Buy groceries", "Visit friends", "Cook dinner" };
``` 

Notice that an array of ```String```s is denoted as ```String[]``` variable type, just as an array of ```int```s might be denoted as ```Int[]``` variable type. This array has the name ```errands```. Each errand is called a _list element_, and is separated by a comma in declaring all of the list elements. 

It's important to note that **all types of lists we will see are 0-indexed!**. This means that our list of errands doesn't start from the first thing to do. It starts with the _zeroth_ thing to do. Although our list of errands have 5 total things to do, the last item is item number four, not five.

Finally the entire list is encased within two ```{}``` brackets, which indicates that it's a list. This introduces us to our first way of representing a list:

> ## Arrays

An array is a way to represent lists that have _a fixed number of elements_. In other words, an array that starts off with five elements will always have five elements forever. When creating an array, we must know the size of the array beforehand, or we will not be able to create it. This limits which situations may best benefit from arrays. Creating an array looks something like this

```java
int[] data; // Declaring the existence of an array of int's
data = new int[10]; // Create a new double array of size 10
```

This new array ```data``` can hold a maximum of 10 doubles. You can also do the declaration and creation steps in a single line, like this:

```java
int[] data = new int[10];
```

This accomplishes the exact same thing. To access or retrieve the ```i```th element in our array (remember that arrays are 0-indexed), we use ```data[i]```. You can write to or read each of the elements using this notation:

```java
/* Modify an element in the array. */
data[0] = -2;    // Sets the 0th element in the array to -2.
data[4] = 13;    // Sets the 4th element in the array to 13.
data[10] = 9;    // This returns an error! data has length 10, so
                 // the last index of the array is 9. There is no
                 // 10th element!
data[6] = "Hi!"; // This also returns an error! data was declared to
                 // be an array of integers, so we can't set an 
                 // element equal to a String.

/* Use or access an element in the array. */
System.out.println(data[0] + 2); // Adds 2 to the 0th integer in data
                                 // and prints out the result. This 
                                 // doesn't modify data[0].
for (int i = 0; i < data.length; i++) {
    data[i]++; // Add 1 to each element in the array.
}
```
To get the total number of elements in an array, use the ```.length``` field. For example, ```System.out.println(data.length)``` would print out ```10```. You cannot remove or add elements from arrays. If you want to remove the ```i```th element, you could set it to ```0``` or ```null```. There are also other things you can do with arrays: you can sort them in increasing order, check for equality, and search through the array to find a particular element among many other things. A full list of capabilities is found [here](https://courses.cs.washington.edu/courses/cse341/98au/java/jdk1.2beta4/docs/api/java/util/Arrays.html).

> ## ```ArrayList```s

The fact that the length of arrays cannot be modified is a pretty big limitation. What if we don't know how many elements will have at the beginning? What if we want the length of our list to change in response to something that dynamically happens in our program? For these reasons, we have ```ArrayList```s, which build on our arrays by being able to change their size.

At this point, it is useful to talk about the difference between the _size_ of a list versus the _capacity_ of a list. The size of a list is the number of elements that it currently holds, while the capacity of a list is the number of elements that it could potentially hold. Other than that, an ```ArrayList``` is functionally the same as an array that we discussed above. Here are some of the commonly used methods that you can use to manipulate ```ArrayList```s:

  1. ```add(E element)``` adds the element of type ```E``` to the end of the list. ```add(int index, E element)``` adds the element of type ```E``` at the specified position in the list.
  2. ```clear()``` removes all elements from the list and resets the size of the ```ArrayList``` to zero.
  3. ```contains(Object o)``` returns ```true``` (a ```boolean```) if the list contains the specified ```Object```.
  4. ```ensureCapacity(int minCapacity)``` increases the capacity of the ```ArrayList``` to ensure that it can hold at least ```minCapacity``` elements.
  5. ```get(int index)``` returns the element at the specified position in this list.
  6. ```isEmpty()``` returns ```true``` (a ```boolean```) if the list contains no elements (has size zero).
  7. ```remove(int index)``` removes the element at the specified position in the list. ```remove(Object o)``` removes the first occurrence of the specified element from this list, if it is present. If you happen to be working with an ```ArrayList``` of ```int```s, the first definition of the ```remove()``` method takes priority.
  8. ```size()``` returns the number of elements in this list.
  9. ```toArray()``` converts the ```ArrayList``` into an array.
  10. ```set(int index, E element)``` replaces the element at the specified position in this list with the specified input element.

Other methods can be found in the [official Java documentation](https://docs.oracle.com/javase/8/docs/api/java/util/ArrayList.html).

> ## Exercises

### Problem 1

Write a Java program that has two methods that act only on arrays of ```int```s:

  1. Determine if the arithmetic mean of all the elements in the array is itself an element of the array.
  2. Return an ```ArrayList``` of ```int```s with capacity equal to the size of the original array argument that contains all of the elements that appear more than once in the array.

Here is a ```class``` template for your convenience:

```java
public class Problem1 {
    /* No fields or constructor needed for this problem. */

    public boolean mean(int[] data) {
        // TODO: Complete task 1 from above.
        return false;
    }

    public ArrayList<Integer> duplicates(int[] data) {
        // TODO: Complete task 2 from above.
        return null;
    }

    public static void main(String[] args) {
        Problem1 p = new Problem1();

        /* Test your methods using two sample data sets. */
        int[] data1 = { 1, 2, 3, 4, 5 };
        int[] data2 = { 1, 1, 1, 6, 6 };

        // Test mean() method.
        System.out.println("Testing mean() method...");
        System.out.println(p.mean(data1) + " " + p.mean(data2));
        System.out.println();

        // Test duplicates() method.
        System.out.println("Testing duplicates() method...");
        System.out.println(p.duplicates(data1) + " " + p.duplicates(data2));
    }
}
```

This is the expected output so you can check your work:

```
$ javac Problem1.java
$ java Problem1
Testing mean() method...
true false

Testing duplicates() method...
[] [1, 6]
```

### Problem 2

DNA is composed of four different types of "building blocks," which we'll refer to as ```A```, ```G```, ```C```, and ```T```. A valid DNA sequence will be composed of these four types of characters, which can be either uppercase or lower case. For example ```AcTggCGa``` is a valid 8-character DNA sequence. Fill in the following methods for our ```class``` representation of DNA below:

```java
public class DNA {
    // TODO: Include any relevant private fields here.

    /* 
     * Constructor takes in a String sequence input and sets the appropriate
     * appropriate vales for any of your relevant fields. Make sure to
     * confirm that the input sequence is a valid input sequence: that is,
     * it only contains A, G, C, T, and/or their lower-case equivalents.
     */
    public DNA(String sequence) {
        // TODO: Do anything you need to do here. Make sure to store
        // the input DNA sequence as a field so we can use it in other
        // methods below.
    }

    /* 
     * This function should return the number of characters in the DNA
     * sequence.
     */
    public int length() {
        // TODO
        return -1;
    }

    /*
     * Sometimes, biologists are interested in a DNA sequence's "GC
     * content", which is defined to be the percentage of characters 
     * in the DNA sequence that are G, g, C, or c. Calculate and 
     * return the GC-content of the DNA sequence.
     */
    public double getGCcontent() {
        // TODO: returns the percentage of characters in the DNA sequence
        // that are G, g, C, or c.
        return -1;
    }

    /*
     * This function should compare the original DNA sequence from the
     * constructor with another DNA sequence class instance and return
     * if they are equal. Two DNA sequences are equal if they contain
     * the same sequence of characters (aside from upper and lower case
     * differences).
     */
    public boolean equals(DNA otherSeq) {
         // TODO
         return false;
    }

    /*
     * This one should be easier: all too have to do here is print out the
     * original DNA sequence. Make sure the String is either all upper
     * case or all lower case (your choice, but I chose to work with all
     * lower case).
     */
    public String toString() {
        // TODO
        return null;
    }

    /*
     * Return the complement DNA sequence of the original DNA sequence.
     */
    public DNA toComplement() {
        // TODO
        return null;
    }

    /*
     * This method should return whether a DNA sequence called otherSeq can
     * be found within the original DNA sequence represented by this class.
     * Of course, differences in upper vs. lower case should be ignored.
     * Return 1 if otherSeq is contained, otherwise return 0.
     */
    public int contains(DNA otherSeq) {
        // TODO
        return 0;
    }

    /* Don't touch this method! */
    public static void main(String[] args) {
        /* We will test the functionality of your different methods here. */
        DNA seq1 = new DNA("TTCTcTCGCCAGcACTGTaATAGGCACTAaaAGAGTGAtG");
        DNA seq2 = new DNA("ggcacta");
        DNA seq3 = new DNA("GtGctGAGCTaagACGGCgt");

        // Test length() method.
        System.out.println("Testing length() method...");
        System.out.print(seq1.length() + " ");
        System.out.print(seq2.length());
        System.out.println();

        // Test getGCcontent() method.
        System.out.println("Testing getGCcontent() method...");
        System.out.print(seq1.getGCcontent() + " ");
        System.out.print(seq3.getGCcontent());
        System.out.println();

        // Test equals() method.
        System.out.println("Testing equals() method...");
        System.out.print(seq1.equals(seq1) + " ");
        System.out.print(seq2.equals(seq3));
        System.out.println();
        
        // Test toString() method.
        System.out.println("Testing toString() method...");
        System.out.print(seq2.toString() + " ");
        System.out.print(seq3.toString());
        System.out.println();
        
        // Test toComplement() method.
        System.out.println("Testing toComplement() method...");
        System.out.print(seq2.toComplement().toString() + " ");
        System.out.print(seq3.toComplement().toString());
        System.out.println();
        
        // Test contains() method.
        System.out.println("Testing contains() method...");
        System.out.print(seq1.contains(seq2) + " ");
        System.out.print(seq2.contains(seq1));
        System.out.println();
    }
}
```

_Note: In order to write the_ ```toComplement()``` _method, please visit [this link](https://www.bx.psu.edu/old/courses/bx-fall08/definitions.html) to understand what a DNA complement sequence is._ The relevant snippet is included here:

> The reverse complement of a DNA sequence is formed by reversing the letters, interchanging A and T and interchanging C and G. For example, the reverse complement of ACCTGAG is CTCAGGT.

This is the expected output so you can check your work:

```
$ javac DNA.java
$ java DNA
Testing length() method...
40 7
Testing getGCcontent() method...
0.45 0.6
Testing equals() method...
true false
Testing toString() method...
ggcacta gtgctgagctaagacggcgt
Testing toComplement() method...
tagtgcc acgccgtcttagctcagcac
Testing contains() method...
1 0
```