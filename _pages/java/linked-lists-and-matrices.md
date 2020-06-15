---
permalink: /java/linked-lists-and-matrices/
title: "```LinkedList```s and Matrices"
---

> ## ```LinkedList```s

[Last time](/java/lists-and-arrays/index.html), we talked about the structure of a list, which we defined to be an ordered array of elements. Arrays had the limitation of having an immutable size and capacity. If we had an array that could hold a maximum of 10 elements and want to add an 11th element, we would have to create an entirely new array with a larger capacity. ```ArrayList```s were able to overcome this limitation by featuring a mutable size and a capacity that could be expanded "under the hood." 

Remember that both arrays and ```ArrayList```s featured _contiguous_ elements. This means that the ```(i)```th and ```(i+1)```th elements are right next to each other in the computer's memory. For example, let's say we had an ```ArrayList``` that looked something like

```java
import java.util.ArrayList;

public class Example {
    public static void main(String[] args) {
        ArrayList<Integer> data = new ArrayList<>();
        data.add(6);
        data.add(-2);
        data.add(7);
        data.add(0);
        data.add(4);
    }
}
```

If we were to represent ```data``` conceptually, it might look something like this:

![array-list](/assets/images/array-list.png){:height="50%" width="50%"}

Imagine if we wanted to remove the element ```data.get(2)```, which is equal to ```7``` according to our code. Because elements in arrays and ```ArrayList```s must be contiguous in the computer's memory, once we call ```data.remove(2)``` to remove the second element not only do we have to remove the element ```7```, but we also have to move the element ```0``` (the third element) one position to the left, and then the element ```4``` (currently the fourth element) also one position to the left. This essentially involves copying and moving two elements around. For this simple example, this isn't too big of an issue. However, what if our data set was much larger? What if ```data``` contained 10 million elements, and we wanted to remove the ```0```th element? Or if we wanted to add an element at the very beginning of the ```ArrayList```? All of a sudden, these processes will start to become very slow because they involve copying and moving so many different elements.

Fortunately for us, ```LinkedList```s provide a better, more time-efficient alternative. ```LinkedList```s are another implementation of the list structure that we talked about previously. The allow for us to store data elements of the same type in an ordered fashion, and from the outside, will look and act exactly like any other type of list. However, ```LinkedList```s have the one caveat where **list elements don't have to be contiguous**. Rather, list elements are now called ```nodes``` that store a _pointer_ to the next element in the list in addition to the data entry. For now, we can think of a pointer as an arrow that points to the next element. To create a ```LinkedList```, our Java code might look something like this:

```java
import java.util.LinkedList;

public class Example {
    public static void main(String[] args) {
        LinkedList<Integer> data = new LinkedList<>();
        data.add(6);
        data.add(-2);
        data.add(7);
        data.add(0);
        data.add(4);
    }
}
```

If we were to represent this version of ```data``` conceptually, it might look something like this:

![linked-list](/assets/images/linked-list.png){:height="50%" width="50%"}

Here, everything looks the same, but we now also have the pointers (denoted as arrows in the diagram) that point to the next element in the list. Imagine if we wanted to remove the element ```data.get(2)```, which is equal to ```7``` according to our code. Calling ```data.remove(2)``` to remove the second element only requires two operations: removing the pointer from the ```7``` to the ```0```, and "rerouting" the pointer from the ```2``` to the ```0```. Therefore, after calling ```data.remove(2)```, our ```LinkedList``` might look something like this:

![linked-list-2](/assets/images/linked-list-2.png){:height="50%" width="50%"}

The benefit of a ```LinkedList``` is that all of the data elements stay in place! This means that we don't have to move anything around. All we need to do is update which direction the pointer is pointing. As another example, say we want to add the element ```10``` to the beginning of this list. After calling ```data.add(0, 10)```, ```data``` would look like

![linked-list-3](/assets/images/linked-list-3.png){:height="50%" width="50%"}

Again, nothing had to move! However, note that one limitation that arises with ```LinkedList```s is that if we're trying to look for elements or access elements of the list, we always have to look through all of the elements before our desired element of interest in order to get the pointers to know how to traverse the list correctly. This is because the list ```nodes``` are not necessarily contiguous anymore. As a result, if your element is at the end of the list, you'll have to traverse through all of the elements in the list before you can access it.

As we've seen, ```LinkedList```s are another great way to represent lists in Java. In general, if you know that your program will be adding and removing and moving elements around a lot, it might be more advantageous to use ```LinkedList```s. If you know that you'll be reading and writing elements a lot, it might be more advantageous to use ```ArrayList```s. If you don't quite know what you'll need to be doing with your list, it might be worthwhile to try out both and see which one is faster!

> ## Matrices

In Java, there isn't really a pre-defined matrix class. Instead, we can represent matrices as arrays within arrays. For example, consider the following matrix: 

$$ m=\begin{bmatrix} 6 & -2 \\ 7 & 0 \end{bmatrix}$$

In Java, we can represent this matrix using the following code:

```java
public class Example {
    public static void main(String[] args) {
        /* Create a matrix m with two rows. */
        int[][] m = new int[2][];

        /* Create two rows, each with two columns. */
        int[] firstRow = new int[2];
        int[] secondRow = new int[2];

        /* Set all of the matrix elements. */
        firstRow[0] = 6;
        firstRow[1] = -2;
        secondRow[0] = 7;
        secondRow[1] = 0;

        /* Set the matrix rows of matrix m. */
        m[0] = firstRow;
        m[1] = secondRow;
        
        /* Print out the matrix. */
        for (int i = 0; i < m.length; i++) {
        	for (int j = 0; j < m[i].length; j++) {
        		System.out.print(m[i][j] + " ");
        	}
        	System.out.println();
        }
    }
}
```

This code will print out the following:

```
$ javac Example.java
$ java Example
6 -2
7 0
```

There are a couple things to notice:

  1. The matrix variable type is declared as ```VariableType[][]```, where ```VariableType``` is the variable type of the elements of the matrix.
  2. The element in the ```i```th row and ```j``` column is accessed as ```m[i][j]```. 
  3. The matrix is stored as a list of lists. In our case, the list might look something like ```{ {6, -2}, {7, 0} }```.

Other than that, matrices act exactly like lists! While you can represent matrices with ```ArrayList```s or ```LinkedList```s, it's usually not recommended because it makes the structure of the matrix unnecessarily complex.

> ## Exercises

> ### Problem 1

Write a Java program that can multiply to square $$n\times n$$ matrices together, where $$n$$ is some positive integer. Test your program by evaluating the following two matrix multiplication problems:

  1. $$\begin{bmatrix} 0 & 4\\ 5 & 2 \end{bmatrix}\begin{bmatrix}2 & 5 \\ 3 & 0\end{bmatrix}$$
  2. $$\begin{bmatrix} 0 & 5 & 6 & 1 \\ 3 & 5 & -7 & 2 \\ 4 & 10 & -6 & -1 \\ 1 & 1 & 3 & 1\end{bmatrix}\begin{bmatrix} 0 & 3 & 4 & 1 \\ 5 & 5 & 10 & 1 \\ 6 & -7 & -6 & 3 \\ 1 & 2 & -1 & 1\end{bmatrix}$$

The answers you should get are:

  1. $$\begin{bmatrix}12 & 0 \\ 16 & 25\end{bmatrix}$$
  2. $$\begin{bmatrix}64 & -15 & 13 & 24 \\ -15 & 87 & 102 & -11 \\ 13 & 102 & 153 & -5\\ 24 & -11 & -5 & 12\end{bmatrix}$$

> ### Problem 2

_This problem is adapted from [Codeforces](http://codeforces.com/problemset/problem/894/A)._

"QAQ" is a word to denote an expression of crying. Imagine "Q" as eyes with tears and "A" as a mouth.

Now Adam has given Becky a string consisting of only uppercase English letters of length n. There is a great number of "QAQ" in the string. Becky wants to know how many subsequences "QAQ" are in the string Adam has given. Note that the letters "QAQ" don't have to be consecutive, but the order of letters should be exact.

**Input:**  The only line contains a string of length $n$ ($3\leq n \leq 20$). It is guaranteed that the string contains uppercase English letters.

**Output:** Print an integer representing the number of subsequences "QAQ" in the string.

**Examples:**

```
$ java Problem2 QAQAQYSYIOIWIN
4
$ java Problem2 QAQQQZZYNOIWIN
3
```

**Explanations:**

In the first example, there are four subsequences "QAQ":

  1. **QAQ**AQYSYIOIWIN
  2. **QA**QA**Q**YSYIOIWIN
  3. **Q**AQ**AQ**YSYIOIWIN
  4. QA**QAQ**YSYIOIWIN

In the second example, there are three subsequences "QAQ":

  1. **QAQ**QQZZYNOIWIN
  2. **QA**Q**Q**QZZYNOIWIN
  3. **QA**QQ**Q**ZZYNOIWIN

> ### Problem 3

In this problem, we will investigate the differences ```ArrayList```s and ```LinkedList```s we talked about earlier. More specifically, ```LinkedList```s are much faster at inserting and removing different list elements, while ```ArrayList```s are much faster at accessing and writing to different list elements. First, create a new Java ```class``` called ```Compare.java```, and copy-paste the following code.

```java
import java.util.Calendar;
import java.util.*;

public class Compare {
    private ArrayList<Integer> a;

    private LinkedList<Integer> l;

    public Compare(int numElements) {
        this.a = new ArrayList<>(numElements);
        this.l = new LinkedList<>();

        for (int i = 0; i < numElements; i++) {
            this.a.add(1);
            this.l.add(1);
        }
    }

    public long popArrayElement() {
        long start = System.nanoTime();

        this.a.remove(0);
	
        long stop = System.nanoTime();

        return (stop - start);
    }

    public long popLinkedElement() {
        long start = System.nanoTime();

        this.l.remove(0);

        long stop = System.nanoTime();

        return (stop - start);
    }

    public long accessArrayElement() {
        long start = System.nanoTime();

        int dummy = this.a.get(this.a.size() / 2);

        long stop = System.nanoTime();

        return (stop - start);
    }

    public long accessLinkedElement() {
        long start = System.nanoTime();

        int dummy = this.l.get(this.l.size() / 2);

        long stop = System.nanoTime();

        return (stop - start);
    }

    public void comparePop() {
        long array = this.popArrayElement();
        long linked = this.popLinkedElement();

        System.out.println("It takes ArrayList " + array + " nsec to " + 
                            "remove the first element in the list.");
        System.out.println("It takes LinkedList " + linked + " nsec to " + 
                            "remove the first element in the list.");
        System.out.println("It takes ArrayList " + (array / linked) +
                            " times longer to remove the first element " + 
                            "in the list.");
        System.out.println();
    }

    public void compareAccess() {
        long array = this.accessArrayElement();
        long linked = this.accessLinkedElement();

        System.out.println("It takes ArrayList " + array + " nsec to " + 
                            "access an element in the middle of the list.");
        System.out.println("It takes LinkedList " + linked + " nsec to " + 
                            "access an element in the middle of the list.");
        System.out.println("It takes LinkedList " + (linked / array) +
                            " times longer to access an element in the " + 
                            "middle of the list.");
        System.out.println();
    }

    public static void main(String[] args) {	
        Compare program = new Compare(Integer.parseInt(args[0]));
        
        program.comparePop();
        program.compareAccess();
    }
}
```

You do not need to modify the code in any way. After you have done this, answer the following questions.

  1. Read the code and make sure you understand what the code is trying to accomplish. To learn more about the ```System.nanoTime()``` method, check out [this link](https://stackoverflow.com/questions/3382954/measure-execution-time-for-a-java-method). (Comment the code if it's helpful!)
  2. Run this program with 100 passed in as the argument. What do you notice?
  3. Run this program with 1000000 (one million) passed in as the argument. What do you notice?
  4. Run this program with 10000000 (ten million) passed in as the argument. What do you notice?
  5. Does your experiment results agree with your understanding of how ```ArrayList```s and ```LinkedList```s work?

Make sure to repeat steps 2-4 a few times to make sure you get reproducible results.  Your outputs will very likely not be the same between runs, but they should be within the same order of magnitude.