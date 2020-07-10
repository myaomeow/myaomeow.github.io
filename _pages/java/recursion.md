---
permalink: /java/recursion/
title: "Recursion"
toc: true
toc_label: "Contents"
---

Today, we'll be learning about **recursion**, which is one of the most difficult yet useful techniques in introductory computer programming.

> ## An Example

Let's imagine that we want to compute the factorial of a number $n$, which is defined to be $n!=n\times(n-1)\times(n-2)\times\cdots\times2\times 1$. One way of doing this using some of the standard techniques that we've learned is through a ```for``` loop:

```java
public class Factorial {
    public int computeFactorial(int n) {
        int result = 1;

        for (int i = 1; i < n; i++) {
            result = result * i;
        }

        return result;
}
```

This is a completely valid way of writing this program. Note that in computing the factorial of $n$, we're essentially doing the same operation (multiplication) over and over again. Indeed, another way of thinking about computing $n!$ is that all we need to do  is multiply $n$ by $(n-1)!$. Now, our problem is reduced to determining what $(n-1)!$ is. But this is essentially the exact same problem: $(n-1)!$ can can be though of as multiplying $(n-1)$ by $(n-2)!$, and our problem is now determining what $(n-2)!$ is. 

This _circular reasoning_ may get you in some trouble in other classes, such as writing proofs in a math course, but in Java and in computer programming in general, this is a very powerful tool. This idea of circular reasoning is the basis of **recursion**.

Recursion describes a class of functions that _calls itself_ in order to complete a task. In our case, given our updated description of how to recursively compute $n!$, recursion might look something like this

```java
public class Factorial {
    public int recursiveComputeFactorial(int n) {
        return n * this.recursiveComputeFactorial(n - 1);
    }
}
```

Notice how the function ```recursiveComputeFactorial(int n)``` recursively calls itself within its own body in order to determine the value of $n!$. However, when we run this function, Java doesn't compute $n!$, but rather gives us a ```StackOverflowError``` error (feel free to check this yourself). 

The ```StackOverflowError``` is essentially a fancy way of telling us that our computer failed to compute the desired result because it essentially ran out of memory, meaning that the program ran on forever and wasn't able to ever finish.

The problem is that we never handled the case where $n=1$. When we get to $n=1$, the function ```recursiveComputeFactorial()``` shouldn't return ```1 * this.recursiveComputeFactorial(0)```; it should simply return ```1```. This is because the factorial computation should end at multiplying the last number of $1$, not continue multiplying $0, -1, -2, \ldots$ and so on and so forth. Therefore, we should update our code in the following way:

```java
public class Factorial {
    public int recursiveComputeFactorial(int n) {
        if (n == 1) { return 1; }
            
        return n * this.recursiveComputeFactorial(n - 1);
    }
}
```

Of course, there's also the edge case where we're trying to compute $0!=1$, so an input of $n=0$ should also return $1$. We'll account for this by modifying our ```if``` statement to account for this case:

```java
public class Factorial {
    public int recursiveComputeFactorial(int n) {
        if (n <= 1) { return 1; }
            
        return n * this.recursiveComputeFactorial(n - 1);
    }
}
```

And we're done! This code is an example of a recursive function that computes the factorial of an integer $n$. You're welcome to try it out yourself to confirm that this works.

> ## Thinking Through the Logic

The logic of how a recursive function can often be one of the most confusing things about recursion. When approaching any problem using recursion, my recommendation is to always tackle the problem _backwards_. That is start with the simplest case. For example going, back to the factorial calculation. Let's first start off with the simplest case of $n=1$. $1!=1$, and so in this case we should simply return $1$. This means that ```this.recursiveComputeFactorial(1) = 1```. For the next simplest case of $n=2$, $2!=2\times 1!$, and so in this case we should return ```2 * this.recursiveComputeFactorial(2 - 1)```. This means that ```this.recursiveComputeFactorial(2) = 2 * this.recursiveComputeFactorial(2 - 1)```. For the next case with $n=3$, $3!=3\times 2!$, and so in this case we should return ```3 * this.recursiveComputeFactorial(3 - 1)```, since we determined above that ```this.recursiveComputeFactorial(3 - 1) = 2!```. Once we've considered a couple of these simple cases, we can generalize and see that as long as $n>1$, our function should return ```n * this.recursiveComputeFactorial(n - 1)```. In this way, recursion is most easily tackled by considered the simplest cases and then building our way upwards.

> ## A General Algorithm

Given that we now better understand the logic of how recursion works, we can now generalize to give a template of what almost all recursive functions will look like:

```java
public class RecursiveFunction {
    public int recurse(int arg) {
        /* Handle the base case. */
        if (baseCase) {
            // Do anything you need here, and then return the value 
            // for the base case. Recursive function calls shouldn't
            // be made here.
        }

        /* Handle all other cases. */
        // Do anything you need here, and then return the value
        // for the general case. Recursive function calls should be
        // made here.
    }
}
````

The **base case** is essentially the simplest case that tells us when to stop recursing. When we were evaluating the factorial of integers, the base case that would stop the recursive calls is when we reach $n=1$.

> ## Applications of Recursion

Now, you might be questioning what the actual uses of recursion are. After all, we gave an example for calculating $n!$ [above](/java/recursion/index.html#an-example) that didn't seem as complicated and worked perfectly find. In fact, in most practical applications, recursion is primarily useful when trying to solve a problem iteratively, which, by definition, can often (but not always) be approached with ```for``` and ```while``` loops. So, when would we actually use recursion in actual practical programming?

One situation that may come up is that the ```for``` and ```while``` loops may get incredibly complex, and can become extremely simplified using recursion. Another situation is if there are multiple "branches" of where the code can possibly run. We'll look at some of the most common situations and algorithms where recursion is an extremely powerful tool.

> ## Quicksort Algorithm

**Quicksort** is perhaps our first introduction to a computing algorithm that has real-world significance. If you're interested in looking for potential jobs in software engineering in the future, I don't think you'll be tested on, say, the basics such as ```for``` and ```while``` loops in your interview, but quicksorting is a very common interview topic that could make or break your job opportunities. Of course, quick sorting is also used within these recruiting companies as well in your actual jobs (that's why they test you on it in the interview).

Quicksorting is referred to as a **divide and conquer** algorithm. We haven't quite discussed what divide and conquer algorithms are yet, but think of it as taking a problem and continuously _dividing_ the problem into smaller and smaller sub-problems. When we eventually solve all of the smaller sub-problems, then we finish up by combining all of the solutions to the sub-problems together to give the final answer. If you're interested in learning more about divide and conquer algorithms, check out [this link](https://www.techiedelight.com/divide-and-conquer-interview-questions/).

We also need to introduce exactly what quicksorting is used for. The main application is when we have some arbitrary array of integer elements, and our goal is to sort this array in ascending order.

Now, we can actually talk about how this algorithm will work. There are essentially three steps involved:

  1. Pick a pivot.
  2. Partition the array around the pivot.
  3. Recurse.

Let's dive into each of these steps in further detail. 

> ### Pick a pivot.

I'll use the example given in [this link](https://www.techiedelight.com/quicksort/) to illustrate quicksorting. Imagine that we are given the following integer array of data:

```java
public class QuickSort {
    private int[] data;

    public QuickSort(int[] data) {
        this.data = data;
    }

    public static void main(String[] args) {
        int[] data = new int[] { 9, -3, 5, 2, 6, 8, -6, 1, 3 };

        QuickSort program = new QuickSort(data);
    }    
}
```

We need to select a **pivot** for this data set, which is simply some element of the data set. In almost all practical applications, the pivot is either the first or the last element of the array. We'll define the pivot to be the last element, so in this case, our pivot is ```3```.

> ### Partition the array around the pivot.

The next step of this algorithm is to iterate through the entirety of the array and organize all of the elements less than or equal to ```3```, our pivot, into one array and greater than ```3``` into another array. The pivot ```3``` is kept on its own, and is not a member of either array. In this case, we can do this in the following way:



> ### Recurse.

> ## Binary Search

Imagine that we have an array ```int[] data``` of integers where it's guaranteed that all of the elements in the array are unique and increasing. That is, ```data[i] < data[i+1]``` for all values of ```i```. Let's say that we wanted to determine if 