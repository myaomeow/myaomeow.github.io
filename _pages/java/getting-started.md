---
permalink: /java/getting-started/
title: "Getting Started"
---

> ## Hello, World!

Welcome to Java! Java is one of the most popular programming languages for both beginners and experts, and can be used in everything from finance and modeling to making both mobile and web-based apps. Today, we'll be learning how to write a simple program to print out ```Hello, World!```.

Let's first start off by opening any text editor (i.e. TextEdit if you're using a Mac), and creating a new file called ```HelloWorld.java```. In the file, we write

```java
public class HelloWorld {
    public static void main(String[] args) {
        
    }
}
```

In Java, all ```.java``` files are composed of a ```class``` which can be thought of as some object that has certain properties (called _fields_) and things that it can do (called _methods_). We will talk about these things later. This class has the name ```HelloWorld```, and this is a ```public```ly accessible class that will be able to be used by other people and other programs in the future. All of the fields and functions that are related to this ```HelloWorld``` class will be encased in ```{}``` brackets. 

Currently, the class has just one function: ```main()```. All functions can have inputs and outputs. For this function, we have only one input called ```args```. Since all we want to do with this program is print out a message, we don't need to worry about what ```args``` is for now. This ```main()``` method is found in **all** Java classes, and is the entry point into the where our code will begin. ```public``` means that this method ```main()``` is always able to be called by other programs, and ```void``` means that the function doesn't return anything: it will just do something (in this case, print out a message) and then terminate. We'll talk about what ```static``` means later.

> All Java classes have a method ```public static void main(String[] args)```.

Now that we have the backbone setup, let's print out the message we're interested in:

```java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}
```
The one line of code we added is saying "print the message ```Hello, World!```". Note that lines of code are always terminated by a semicolon ```;``` in Java.

That's it! On MacOS, all that's left is to run the program. First, fire up the Terminal, and then compile the program (we'll talk about what compiling means later). Test it out by running the Java program.

```
$ javac HelloWorld.java    # Compiles the Java program
$ java HelloWorld          # Run the Java program
Hello, World!              # This is our output!
```
If you're currently working on a Windows computer, your terminal commands may be different. I recommend looking into getting a [Integrated Developer Environment (IDE)](https://en.wikipedia.org/wiki/Integrated_development_environment), such as [Eclipse](https://www.eclipse.org/downloads/packages/), which is free to download.
