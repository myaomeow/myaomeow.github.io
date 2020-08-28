---
permalink: /computing-systems/x86-assembly/
author_profile: false
title: "Intel x86 64-Bit Assembly Language"
toc: true
toc_label: "Contents"
---

> ## What is Assembly Language?

**Assembly language** is perhaps one of the most low-level programming languages out there. It involves writing instructions for exactly how variables and data types are stored and manipulated by the computer's **central processing unit (CPU)**, which can be thought of as the "brain" of a computer that executes computer instructions.

Just as each person's brain is hardwired differently and understands things differently, each CPU processor understands a different assembly language. For example, the class of languages understood by smart phones, which are often referred to as RISCs (reduced instruction set computers) is very different than the class of languages understood by most modern computers, often referred to as CISCs (complex instruction set computers). The actual differences between RISCs and CISCs are not super important for our discussion, but in general, RISCs are more efficient but often have less "words" or commands in their language, while CISCs are more complex and have many more commands in their language.

x86 is one of the most common CPU's in the market today, and were all based on the first-generation 8086 and 8088 CPU's released in the late twentieth century. Of course, x86 has its own assembly languages that it uses to understand and run instructions. The reason why x86 assembly language is particular interesting for us to study is that **virtually all modern computers have x86 CPUs**. In my experiences, I have never come across a single computer that doesn't run x86. Because it is so omnipresent, we will focus our discussion in understanding x86.

> ## Why is Assembly Language Important?

The _vast majority_ of computer programmers will learn about assembly language once and then never touch it ever again. After all, why would anyone want to learn an arguably complex and difficult to debug language like x86 assembly as opposed to using languages like Python and Java instead? In fact, there are a number of reasons of why _every programmer_ should have at least a basic understanding of assembly language:

  1. **Understand Computer Architecture:** Understanding and writing assembly language code requires you to have a rigorous understanding of the architecture and hardware inside a computer. Having a solid understanding of computer architecture can allow you to write more efficient code and faster algorithms, even in languages such as Java and Python.
  2. **Understanding Compiler Optimizations:** It turns out that the code that we write everyday in Java, Python, and other introductory languages can often be very slow if the computer executed it as is. Therefore, when your computer is translating the code that you write into machine instructions that can actually be executed, it often makes optimizations to make the translated machine instructions run faster. We saw a couple of examples of this when we discussed [bitwise operations](/computing-systems/bitwise-operations/index.html#exercises), where we explored how the ```XOR``` bitwise operator could be used to swap variables instead of using a temporary third variable. Compilers often make many of these optimizations, and it is sometimes important to understand how these optimizations affect the performance of your code on different machines.
  3. **Completely Controlling Computer Resources:** We mentioned it previously, but assembly language programs and C programs are faster and more efficient than programs written in “higher-level” languages such as Python or Java. Assembly language is the gateway to optimization in speed because it doesn’t involve any unnecessary infrastructure or background operations.

Given these important reasons to understand assembly, let’s look at some of the important features of the x86 assembly language.

> ### One Note Before We Get Started

For some reason, there are two "dialects" when it comes to x86 assembly language: the _Intel_ dialect and the _AT&T_ dialect. In general, the Intel syntax is typically used on Windows machines, while the AT&T syntax is typically used on Unix systems, which includes Mac and Linux OS. Because we're exclusively using Linux (or at least Unix) systems to learn about computer systems, all of our work in x86 will be in AT&T syntax. 

> ## The Basics of Computer Architecture

Computers have multiple components to them, including the CPU, primary storage (RAM), and secondary storage (SSD). Each of these serve different purposes:

  1. Computer programs and data are typically stored on **secondary storage**, which are things like hard drives and solid state drives (SSD). Secondary storages are meant for retaining data for a long period of time, even after the computer is turned off or the power plug is pulled.
  2. When a program needs to be executed, it is copied from the secondary storage into the **main memory**, also referred to as the **primary storage**. This is often referred to as the random access memory (RAM). Information stored on the RAM is for the CPU to directly interact and work with. Primary storages are meant to temporarily work with data, and information stored on these devices are lost when the computer is turned off or when the power plug is pulled.
  3. As we have discussed earlier, **central processing units** (CPUs) directly interact with the primary storage in order to carry out machine instructions and perform various computations. 

Of course, the picture gets a lot more complicated than this, but for now, this is the lowest level of abstraction that we need for our purposes.

> ### Primary Storage Memory: Stacks and Heaps

Pointers are a crucial aspect of the CPU being able to understand where things are stored in primary storage. The RAM of computers is often divided up into two sections: the stack and the heap. In terms of [ADTs](/java/abstract-data-types/index.html), the stack can be represented as a stack, while the heap can better be through of a list. However, in both cases, the elements of both the stack and the heap do not have to be restricted to a certain size value. There are a number of differences between the stack and the heap:

<table style="width:100%">
  <tr>
    <th style="font-size:14pt">Stack</th>
    <th style="font-size:14pt">Heap</th>
  </tr>
  <tr>
    <td style="font-size:13pt">stores local variables</td>
    <td style="font-size:13pt">high-speed access</td>
    <td style="font-size:13pt">fairly limited memory size</td>
    <td style="font-size:13pt">contiguous memory in LIFO order</td>
    <td style="font-size:13pt">variables cannot be resized</td>
  </tr>
  <tr>
    <td style="font-size:13pt">stores global variables</td>
    <td style="font-size:13pt">slow access speeds</td>
    <td style="font-size:13pt">large memory size</td>
    <td style="font-size:13pt">memory stored in random order</td>
    <td style="font-size:13pt">variables can be resized</td>
  </tr>
</table>

There are number of other differences, but these are the main differences. An image of what the primary storage memory can be found [here](https://medium.com/@shoheiyokoyama/understanding-memory-layout-4ef452c2e709), but basically, the main idea is that the stack and the heap do different things and serve different purposes. (I found the link particularly informative in explaining the purpose of the stack in RAM.)

> ### Pointers

Pointers are essentially **addresses** to locations in memory, and tell us the location of where things are stored in the primary storage. We briefly introduced the topic of pointers at the [very beginning](/computing-systems/introduction/index.html#computer-abstraction). Let's focus on how pointers are used to represent locations in the heap, which is typically what we are most interested in:

![x86-assembly-1](/assets/images/computer-systems/x86-assembly-1.png){:height="40%" width="40%"}

On 64-bit computers (that is, most modern computers), we say that the heap is **8-byte aligned**. This means that each "chunk" of memory a multiple of 8 bytes. (On older 32-bit computers, the heap is _4-byte aligned_). We can think of each of this little squares as houses with their own individual addresses, given by the ```0x8000xxxx```` addresses shown in the figure above.

In x86 assembly language, we have a very particular method of referring to the contents of each of these addresses:

  1. A plain string refers to the actual contents at that particular address. For example, if the integer ```3``` was stored at ```0x80000008```, then writing code ```0x80000008``` refers to _the contents_ stored at the address ```0x80000008```, which in this case is ``3```. As we will see later on, there is a bit of nuances when referring to addresses in registers, but we'll talk about it below.
  2. A string with a ```$``` dollar sign symbol in front refers to the actual string literal. For example, writing the code ```$0x80000008``` refers to the actual hexadecimal number ```80000008```.
  3. A string encased in ```[]``` brackets means refers to the contents stored at the address at the address stored in our particular address. Let's break this down, as this is an incredibly confusing statement. Imagine that we have the value ```0x8000000``` stored at the address ```0x80000010```. In this case, ```[0x80000010]``` would ask us to take the value stored at ```0x80000010```, which is ```0x80000000``` in this case, and treat this value itself as another memory address. We would then go to the memory address ```0x80000000```, and ```[0x80000010]``` would then refer to whatever is stored there.

This might seem extremely confusing at first, but it will get simpler as we go over a couple of example exercises below.

> ## The Basics

> ### Variable Size Suffixes

Because x86 assembly works directly with the individual bits and bytes stored in memory, we are typically not interested in what the actual bits represent or what the variable type is at such a low level of programming. However, we do care about the _size_ (number of bits) of the quantities that we are working with.

Let's consider an example problem. Consider the case where we have an instruction that says "move ```$2``` to ```0x80000008```." Is this instruction moving the value ```2``` into the least significant byte at address ```0x80000008```? Or is it moving the 32-bit integer representation of ```2``` into the least significant 4 bytes at address ```0x80000008```? Since either of these is a valid possible interpretation, we usually have to explicitly declare which one we are intending. Therefore, we have the following size suffixes:

  1. ```b```: least significant 1 byte (stands for ```byte```)
  2. ```w```: least significant 2 bytes (stands for ```word```)
  3. ```l```: least significant 4 bytes (stands for ```long```)
  4. ```q```: all 8 bytes (stands for ```quad```)

There are a couple of more advanced _operation suffixes_, such as ```s``` (stands for ```single```) and ```t``` (stands for ```ten bytes```), but they are typically rarely used (at least in basic x86 assembly code) and so we won't really talk about them here. However, you're free to look up what they mean online if you're interested.

While it isn't always explicitly necessary to declare the size suffix in every operation, it's often good practice to make clear actually what the intent of your operation is and how many bytes you're intending to work with in a given instruction.

> ### Registers

There is one last (and extremely important) topic that we need to discuss before we can start reading and writing x86 assembly code: **registers**. Registers are essentially temporary memory storages that can be accessed extremely quickly by the computer, and are used by the CPU to directly make computations and what not.

On modern Intel 64-bit computers, there are _sixteen_ different general-purpose registers, and each of them have their own purposes and "memory address" names. We'll list the different names here:

**64-bit register** | **lowest 32 bits** | **lowest 16 bits** | **lowest 8 bytes**
```rax``` | ```eax``` | ```ax``` | ```al```
```rbx``` | ```ebx``` | ```bx``` | ```bl```
```rcx``` | ```ecx``` | ```cx``` | ```cl```
```rdx``` | ```edx``` | ```dx``` | ```dl```
```rsi``` | ```esi``` | ```si``` | ```sil```
```rdi``` | ```edi``` | ```di``` | ```dil```
```rbp``` | ```ebp``` | ```bp``` | ```bpl```
```rsp``` | ```esp``` | ```sp``` | ```spl```
```r8``` | ```r8d``` | ```r8w``` | ```r8b```
```r9``` | ```r9d``` | ```r9w``` | ```r9b```
```r10``` | ```r10d``` | ```r10w``` | ```r10b```
```r11``` | ```r11d``` | ```r11w``` | ```r11b```
```r12``` | ```r12d``` | ```r12w``` | ```r12b```
```r13``` | ```r13d``` | ```r13w``` | ```r13b```
```r14``` | ```r14d``` | ```r14w``` | ```r14b```
```r15``` | ```r15d``` | ```r15w``` | ```r15b```

Here is a picture of what a typical register looks like and is subdivided into. The most significant bit is located on the left, and the least significant bit is located on the right.

![x86-assembly-2](/assets/images/computer-systems/x86-assembly-2.png){:height="90%" width="90%" .align-center}

As you can see from this diagram, **all registers in x86 are prefaced in assembly code by a ```%``` sign**. This is what indicates to the computer that we're dealing with the contents within the register.

Some of the sixteen registers have important functions that we should talk about:

  1. When an assembly function returns, it always returns the value stored in the register ```%rax``` (or a smaller sub-register, depending on what is specified).
  2. When arguments are passed into the function, the first argument is passed into ```%rdi```, the second argument to ```%rsi```, the third argument to ```%rdx```, the fourth argument to ```%rcx```, the fifth argument to ```%r8```, and the sixth argument to ```%r9```.
  3. The ```%rdx``` register is often used to handle overflow problems from multiplication operations, or to overflow before we perform a division operation. (This will almost certainly make no sense right now, but we'll go over what this means below.)
  4. The ```%rsp``` register is typically reserved to store a pointer to the "top" of the stack, and ```%rbp``` register is typically reserved to store a pointer to the "bottom of the stack."
  5. While things are pushed to the top of the stack, in reality in computer memory, the stack grows downwards, and so the value stored in ```%rsp``` is always less than or equal to the value stored in ```%rbp```.

> ### Register Arithmetic

To _dereference_ registers, we use parentheses ```()``` instead of the square brackets ```[]```. For example, if the heap memory location ```0x80000010``` was stored in the register ```%rax```, then ```(%rax)``` would refer to whatever is stored in the primary memory at location ```0x80000010```.

Often times, we are interested in storing a pointer to the beginning of an array at a heap memory location, or pointer to somewhere on the stack in reference to the bottom of the stack. In both cases, we often don't know the "absolute" memory location in these cases of certain objects stored in the memory, but rather their location relative to a reference, such as the pointer to the start of an array or the pointer to the base of a stack stored in ```%rbp```. In order to denote _relative_ memory location, we can use common addressing conventions in AT&T syntax for dealing with point locations stored in registers. The idea is that we can refer to addresses in the heap in the following notation convention:

```
offset(base, index, scale)
```

The ```base``` is the base reference memory location, often stored in some register. ```index``` can be thought of the array index in an array, and ```scale``` is the size of each array element. ```offset``` is the offset from the ```base``` reference location. In this case, this notation references the primary storage location

```
[base + (index * scale) + offset]
```

For example, let's say that the integer ```0x3``` was stored at the memory location ```0x80000010```, and the location ```0x80000000``` to the start of the heap location was stored in the register ```%rcx```. This means that the instruction

```
movq    (%rcx, 2, 8), %rax
```

moves the integer ```0x3``` to the register ```%rax```. This is because ```0x80000000 + (2 * 8) = 0x80000010```. Here are some examples of using parentheses to dereference pointers stored in registers:

  1. ```(%rax)```. This accesses the contents of the memory at the address stored in ```%rax```.
  2. ```(%rbx, %rcx)```. This accesses the contents of the memory at the address stored in ```%rbx + %rcx``` (ie adding the two values stored in these two registers and then treating the sum as a pointer to the primary storage).
  3. ```(%rbx, %rcx, 8)```. This accesses the contents of the memory at the address stored in ```%rbx + (8 * %rcx)```.
  4. ```4(%rbx, %rcx, 8)```. This accesses the contents of the memory at the address stored in ```%rbx + (8 * %rcx) + 4```.

This _offset notation_ can also be used to do basic arithmetic! This can be done using the ```lea``` command, which we'll introduce and talk about in the section below. Basically, the instruction looks like the following:

```
leaq    some calculation, destination
```

For example, suppose that we wanted to calculate ```2 + (5 * 8) - 4```, and then store the result into the register ```%rax```. A succinct way of doing this is to use the instruction

```
leaq    -4(2, 5, 8), %rax
```

The benefit of doing calculations in this way is that (1) it is often more concise, and (2) it performs the calculation without modifying any of the flags in the ALU. _Flags_ are something that we'll discuss in the sections [below](/computing-systems/x86-assembly/index.html#flags).

> ## Common x86 Assembly Commands

Here are a list of common x86 assembly commands and their uses.

> ### Data Movement Instructions

<table style="width:100%" class="align-center">
  <tr>
    <th style="font-size:13pt;text-align:center">Instruction</th>
    <th style="font-size:13pt;text-align:center">Arguments</th>
    <th style="font-size:13pt;text-align:center">Description</th>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">mov</code></td>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">src, dst</code></td>
    <td style="font-size:13pt;text-align:left">move <code class="language-plaintext highlighter-rouge">src</code> to <code class="language-plaintext highlighter-rouge">dst</code></td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">push</code></td>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">src</code></td>
    <td style="font-size:13pt;text-align:left">push <code class="language-plaintext highlighter-rouge">src</code> onto the top of the stack</td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">pop</code></td>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">dst</code></td>
    <td style="font-size:13pt;text-align:left">pop the top of the stack to <code class="language-plaintext highlighter-rouge">dst</code></td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">cwtl</code></td>
    <td style="font-size:13pt;text-align:center"></td>
    <td style="font-size:13pt;text-align:left">sign-extend word in <code class="language-plaintext highlighter-rouge">%ax</code> to long in <code class="language-plaintext highlighter-rouge">%eax</code></td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">cltq</code></td>
    <td style="font-size:13pt;text-align:center"></td>
    <td style="font-size:13pt;text-align:left">sign-extend long in <code class="language-plaintext highlighter-rouge">%eax</code> to quad in <code class="language-plaintext highlighter-rouge">%rax</code></td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">cqto</code></td>
    <td style="font-size:13pt;text-align:center"></td>
    <td style="font-size:13pt;text-align:left">sign-extend quad in <code class="language-plaintext highlighter-rouge">%rax</code> to 16-byte octoword in <code class="language-plaintext highlighter-rouge">%rdx:%rax</code> (<code class="language-plaintext highlighter-rouge">%rdx</code> holds the most significant bit)</td>
  </tr>
</table>

> ### Unary Operations

<table style="width:100%" class="align-center">
  <tr>
    <th style="font-size:13pt;text-align:center">Instruction</th>
    <th style="font-size:13pt;text-align:center">Arguments</th>
    <th style="font-size:13pt;text-align:center">Description</th>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">inc</code></td>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">dst</code></td>
    <td style="font-size:13pt;text-align:left">increment <code class="language-plaintext highlighter-rouge">dst</code> by one</td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">dec</code></td>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">dst</code></td>
    <td style="font-size:13pt;text-align:left">decrement <code class="language-plaintext highlighter-rouge">dst</code> by one</td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">neg</code></td>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">dst</code></td>
    <td style="font-size:13pt;text-align:left">replace <code class="language-plaintext highlighter-rouge">dst</code> with its additive inverse</td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">not</code></td>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">dst</code></td>
    <td style="font-size:13pt;text-align:left">replace <code class="language-plaintext highlighter-rouge">dst</code> with its bitwise complement</td>
  </tr>
</table>

> ### Binary Operations

<table style="width:100%" class="align-center">
  <tr>
    <th style="font-size:13pt;text-align:center">Instruction</th>
    <th style="font-size:13pt;text-align:center">Arguments</th>
    <th style="font-size:13pt;text-align:center">Description</th>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">leaq</code></td>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">src, dst</code></td>
    <td style="font-size:13pt;text-align:left">load <em>address</em> <code class="language-plaintext highlighter-rouge">src</code> to <code class="language-plaintext highlighter-rouge">dst</code> (<em><strong>not</strong></em> the value stored at <code class="language-plaintext highlighter-rouge">src</code> to <code class="language-plaintext highlighter-rouge">dst</code>)</td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">add</code></td>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">src, dst</code></td>
    <td style="font-size:13pt;text-align:left">add <code class="language-plaintext highlighter-rouge">src</code> to <code class="language-plaintext highlighter-rouge">dst</code></td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">sub</code></td>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">src, dst</code></td>
    <td style="font-size:13pt;text-align:left">subtract <code class="language-plaintext highlighter-rouge">src</code> <em>from</em> <code class="language-plaintext highlighter-rouge">dst</code></td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">imul</code></td>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">src, dst</code></td>
    <td style="font-size:13pt;text-align:left">multiply <code class="language-plaintext highlighter-rouge">dst</code> by <code class="language-plaintext highlighter-rouge">src</code></td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">and</code></td>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">src, dst</code></td>
    <td style="font-size:13pt;text-align:left">bitwise <code class="language-plaintext highlighter-rouge">AND</code> on <code class="language-plaintext highlighter-rouge">dst</code> by <code class="language-plaintext highlighter-rouge">src</code></td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">or</code></td>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">src, dst</code></td>
    <td style="font-size:13pt;text-align:left">bitwise <code class="language-plaintext highlighter-rouge">OR</code> on <code class="language-plaintext highlighter-rouge">dst</code> by <code class="language-plaintext highlighter-rouge">src</code></td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">xor</code></td>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">src, dst</code></td>
    <td style="font-size:13pt;text-align:left">bitwise <code class="language-plaintext highlighter-rouge">XOR</code> on <code class="language-plaintext highlighter-rouge">dst</code> by <code class="language-plaintext highlighter-rouge">src</code></td>
  </tr>
</table>

> ### Special Arithmetic Operations

Sometimes for multiplication and division operations, we need to worry about _bit extension_. This is because, for example, multiplication of two 64-bit integers can yield a 128-bit integer, and division of two 64-bit integers can yield an incorrect result if the thing being divided is not converted into a 128-bit integer first. This is perhaps easiest to understand in terms of division by a power of two using left shift and right shift operations. We discussed some of the issues with these operations if not considered carefully [previously](/computing-systems/bitwise-operations/index.html#why-should-i-care).

<table style="width:100%" class="align-center">
  <tr>
    <th style="font-size:13pt;text-align:center">Instruction</th>
    <th style="font-size:13pt;text-align:center">Arguments</th>
    <th style="font-size:13pt;text-align:center">Description</th>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">imulq</code></td>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">src</code></td>
    <td style="font-size:13pt;text-align:left">signed multiply <code class="language-plaintext highlighter-rouge">%rax</code> by <code class="language-plaintext highlighter-rouge">src</code>, and store result in <code class="language-plaintext highlighter-rouge">%rdx:%rax%</code></td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">mulq</code></td>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">src</code></td>
    <td style="font-size:13pt;text-align:left">unsigned multiply <code class="language-plaintext highlighter-rouge">%rax</code> by <code class="language-plaintext highlighter-rouge">src</code>, and store result in <code class="language-plaintext highlighter-rouge">%rdx:%rax%</code></td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">idivq</code></td>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">src</code></td>
    <td style="font-size:13pt;text-align:left">signed divide <code class="language-plaintext highlighter-rouge">%rdx:%rax</code> by <code class="language-plaintext highlighter-rouge">src</code>, and store quotient in <code class="language-plaintext highlighter-rouge">%rax%</code> and remainder in <code class="language-plaintext highlighter-rouge">%rdx%</code></td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">divq</code></td>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">src</code></td>
    <td style="font-size:13pt;text-align:left">unsigned divide <code class="language-plaintext highlighter-rouge">%rdx:%rax</code> by <code class="language-plaintext highlighter-rouge">src</code>, and store quotient in <code class="language-plaintext highlighter-rouge">%rax%</code> and remainder in <code class="language-plaintext highlighter-rouge">%rdx%</code></td>
  </tr>
</table>

> ### Shifting Operations

<table style="width:100%" class="align-center">
  <tr>
    <th style="font-size:13pt;text-align:center">Instruction</th>
    <th style="font-size:13pt;text-align:center">Arguments</th>
    <th style="font-size:13pt;text-align:center">Description</th>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">sal</code> or <code class="language-plaintext highlighter-rouge">shl</code></td>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">k, D</code></td>
    <td style="font-size:13pt;text-align:left">left shift <code class="language-plaintext highlighter-rouge">dst</code> by <code class="language-plaintext highlighter-rouge">k</code> bits</td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">sar</code></td>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">k, D</code></td>
    <td style="font-size:13pt;text-align:left">arithmetic right shift <code class="language-plaintext highlighter-rouge">dst</code> by <code class="language-plaintext highlighter-rouge">k</code> bits</td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">shr</code></td>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">k, D</code></td>
    <td style="font-size:13pt;text-align:left">logical right shift <code class="language-plaintext highlighter-rouge">dst</code> by <code class="language-plaintext highlighter-rouge">k</code> bits</td>
  </tr>
</table>

> ### Compare Instructions

<table style="width:100%" class="align-center">
  <tr>
    <th style="font-size:13pt;text-align:center">Instruction</th>
    <th style="font-size:13pt;text-align:center">Arguments</th>
    <th style="font-size:13pt;text-align:center">Description</th>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">cmp</code></td>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">src1, src2</code></td>
    <td style="font-size:13pt;text-align:left">sets flags according to <code class="language-plaintext highlighter-rouge">src2 - src1</code></td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">test</code></td>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">src1, src2</code></td>
    <td style="font-size:13pt;text-align:left">sets flags according to <code class="language-plaintext highlighter-rouge">src2 & src1</code></td>
  </tr>
</table>

At this point, it is also worth noting what the flags are that are stored in the special dedicated ```FLAGS``` register. There are a number of them, but we'll highlight the most important ones here:

<table style="width:100%" class="align-center">
  <tr>
    <th style="font-size:13pt;text-align:center">Flag</th>
    <th style="font-size:13pt;text-align:left">Set to <code class="language-plaintext highlighter-rouge">1</code> when...</th>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center">carry flag <code class="language-plaintext highlighter-rouge">CF</code></td>
    <td style="font-size:13pt;text-align:left">sum exceeds capacity of register, or negative number was obtained in subtracting two unsigned integers</td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center">parity flag <code class="language-plaintext highlighter-rouge">PF</code></td>
    <td style="font-size:13pt;text-align:left">parity of result of last operation was even</td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center">zero flag <code class="language-plaintext highlighter-rouge">ZF</code></td>
    <td style="font-size:13pt;text-align:left">result of last operation was <code class="language-plaintext highlighter-rouge">0</code></td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center">sign flag <code class="language-plaintext highlighter-rouge">SF</code></td>
    <td style="font-size:13pt;text-align:left">result of last operation was negative</td>
  </tr>
</table>

> ### Logical Control Flow Instructions

Typically, based on a ```cmp``` result, we may want to jump to another set of instructions. This is common in implementing iterations and conditional statements.

<table style="width:100%" class="align-center">
  <tr>
    <th style="font-size:13pt;text-align:center">Instruction</th>
    <th style="font-size:13pt;text-align:center">Description</th>
    <th style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">FLAGS</code> Condition</th>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">jmp</code></td>
    <td style="font-size:13pt;text-align:left">jump to specified <code class="language-plaintext highlighter-rouge">label</code></td>
    <td style="font-size:13pt;text-align:center"></td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">je</code> / <code class="language-plaintext highlighter-rouge">jz</code></td>
    <td style="font-size:13pt;text-align:left">jump to specified <code class="language-plaintext highlighter-rouge">label</code> only if equal or zero</td>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">ZF</code></td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">jne</code> / <code class="language-plaintext highlighter-rouge">jnz</code></td>
    <td style="font-size:13pt;text-align:left">jump to specified <code class="language-plaintext highlighter-rouge">label</code> only if <em>not</em> equal or not zero</td>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">~ZF</code></td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">js</code></td>
    <td style="font-size:13pt;text-align:left">jump to specified <code class="language-plaintext highlighter-rouge">label</code> only if negative</td>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">SF</code></td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">jns</code></td>
    <td style="font-size:13pt;text-align:left">jump to specified <code class="language-plaintext highlighter-rouge">label</code> only if <em>not</em> negative</td>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">~SF</code></td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">jg</code> / <code class="language-plaintext highlighter-rouge">jnle</code></td>
    <td style="font-size:13pt;text-align:left">jump to specified <code class="language-plaintext highlighter-rouge">label</code> only if greater (signed)</td>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">~(SF^OF)&(~ZF)</code></td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">jge</code> / <code class="language-plaintext highlighter-rouge">jnl</code></td>
    <td style="font-size:13pt;text-align:left">jump to specified <code class="language-plaintext highlighter-rouge">label</code> only if greater than or equal (signed)</td>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">~(SF^OF)</code></td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">jl</code> / <code class="language-plaintext highlighter-rouge">jnge</code></td>
    <td style="font-size:13pt;text-align:left">jump to specified <code class="language-plaintext highlighter-rouge">label</code> only if less (signed)</td>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">SF^OF</code></td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">jle</code> / <code class="language-plaintext highlighter-rouge">jng</code></td>
    <td style="font-size:13pt;text-align:left">jump to specified <code class="language-plaintext highlighter-rouge">label</code> only if less than or equal (signed)</td>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">(SF^OF)|ZF</code></td>
  </tr>
</table>

> ### Procedure Call Instructions

<table style="width:100%" class="align-center">
  <tr>
    <th style="font-size:13pt;text-align:center">Instruction</th>
    <th style="font-size:13pt;text-align:center">Arguments</th>
    <th style="font-size:13pt;text-align:center">Description</th>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">call</code></td>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">label</code></td>
    <td style="font-size:13pt;text-align:left">push return address and jump to <code class="language-plaintext highlighter-rouge">label</code></td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">leave</code></td>
    <td style="font-size:13pt;text-align:center"></td>
    <td style="font-size:13pt;text-align:left">set <code class="language-plaintext highlighter-rouge">%rsp</code> to <code class="language-plaintext highlighter-rouge">%rbp</code>, and then pop the top of the stack into <code class="language-plaintext highlighter-rouge">%rbp</code> register</td>
  </tr>
  <tr>
    <td style="font-size:13pt;text-align:center"><code class="language-plaintext highlighter-rouge">ret</code></td>
    <td style="font-size:13pt;text-align:center"></td>
    <td style="font-size:13pt;text-align:left">pop return address from stack and jump there</td>

  </tr>
</table>

> ### Additional Instructions

Once again, we have only grazed the surface of the set of x86 instructions available to us in assembly. While the above represent the most common instructions, you can find the full set in the x86 assembly documentation [here](https://docs.oracle.com/cd/E19253-01/817-5477/817-5477.pdf).

> ## Stack Manipulation

This section is currently under construction.

> ## Practice Reading Assembly

As with all programming languages, the best way to familiarize ourselves with assembly code is to read a _bunch_ of assembly code! In this way, we'll be able to more easily identify common assembly function structures and decode what the assembly code is doing.

To go over some practice examples, let's go over the following set of functions, which are currently written in C. We'll discuss each of them one by one. Feel free to follow along using the following code sample.

<iframe height="1200px" width="100%" src="https://repl.it/@myaomeow/AssemblyTest?lite=true" scrolling="no" frameborder="no" allowtransparency="true" allowfullscreen="true" sandbox="allow-forms allow-pointer-lock allow-popups allow-same-origin allow-scripts allow-modals"></iframe>

> ### Converting from C Code to Assembly

On Linux systems, assembly code is written in ```.s``` files. This will be important when we eventually begin writing our own assembly code from scratch. If we're starting from a ```.c``` C program file, there are two common ways to convert the C code in assembly code:

  1. After compiling the ```.c``` program using ```gcc``` compiler, run the terminal command ```objdump -d xxxxx```, where ```xxxxx``` is what the name of the original ```.c``` is. In our case, we will run the command ```objdump -d main```. We haven't formally talked about compile C code just yet, so don't worry if you don't know what ```gcc``` is just yet. Effectively, we'll be running the two lines ```gcc main.c``` and then ```objdump -d main``` in terminal. (If you are using the ```repl.it``` plugin from above, pressing the green "Run" button does the same thing as running the ```gcc main.c``` command.)
  2. After compiling the ```.c``` program (using the same method as described above), we can instead use the standard C debugger ```gdb``` to print out the relevant assembly code. The benefit of using this method is that we avoid printing out the C program initialization functions like ```__libc_csu_init```, ```_start```, and ```deregister_tm_clones```, among others, that we have no interest in actually parsing through. To do this, instead of running ```objdump -d main```, we'll run the command ```gdb main``` first to boot up the ```gdb``` debugger, and then run the command ```disassemble xxxxx```, where ```x``` is the name of the function we want to disassemble. For example, if we want to disassemble the function ```simpleInt()``` using this method, we'd run the following set of commands.

```
$ gcc main.c
$ gdb main
$ (gdb) disassemble simpleInt
```

There are other ways of converting from C code to assembly (and also vice versa), but for our discussion right now, this will prove sufficient.

> ### Starting Easy: Returning an Integer

Let's first start by taking a look at the ```simpleInt``` function, which simply returns the integer ```6```. Let's run ```simpleInt``` in the ```main()``` function:

```c
int simpleInt(void) {
    return 6;
}

int main(void) {
    return simpleInt();
}
```

After compiling and disassembling, the relevant segments of assembly code that correspond to this C code are here:

```
00000000004004f0 <simpleInt>:
  4004f0:   55                      push   %rbp
  4004f1:   48 89 e5                mov    %rsp,%rbp
  4004f4:   b8 06 00 00 00          mov    $0x6,%eax
  4004f9:   5d                      pop    %rbp
  4004fa:   c3                      retq   
  4004fb:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)

0000000000400640 <main>:
  400640:   55                      push   %rbp
  400641:   48 89 e5                mov    %rsp,%rbp
  400644:   48 83 ec 10             sub    $0x10,%rsp
  400648:   c7 45 fc 00 00 00 00    movl   $0x0,-0x4(%rbp)
  40064f:   e8 9c fe ff ff          callq  4004f0 <simpleInt>
  400654:   48 83 c4 10             add    $0x10,%rsp
  400658:   5d                      pop    %rbp
  400659:   c3                      retq   
  40065a:   66 0f 1f 44 00 00       nopw   0x0(%rax,%rax,1)
```

The six-digit numbers before every instruction can be thought of as the "numbering" for each of the instructions and functions to be able to easily reference them. The pairwise hexadecimal numbers are the _machine code_ associated with each instruction, which are the actual bytes that the computer will use to execute the corresponding instruction. Of course, to us as programmers, machine code is just a bunch of illegible bytes. The things that we are most interested in are the commands at the end of each of line.

As we can see in the ```<simpleInt>``` function, the first two pair of instructions involve setting up the stack pointers in the primary memory. The first interesting instruction is ```mov $0x6, %eax```, which moves the hexadecimal number ```$0x6``` into the return 32-bit register ```%eax```. After this single step of our function, we can see that the function restores the state of the stack, and then ```retq``` returns the 64-bit result stored in the register ```%rax```. The command ```nopl``` essentially is just filler machine code and literally tells the computer to "do nothing" at that instruction.

In the the ```<main>``` function, the first four instructions again involve something to do with setting up the stack that we don't particularly care about. After that, the command ```callq <simpleInt>``` calls the function ```<simpleInt>```, whose result we know is stored in ```%rax```. After this instruction, the next two instructions at ```400654``` and ```400658``` restore something about the stack, and then we return from the ```<main>``` function using the ```retq``` command. Pretty straightforward!

<div class="notice--warning">
<p style="font-size:13pt"><strong>Problem 1:</strong> Try doing a similar analysis with the <code class="language-plaintext highlighter-rouge">simpleChar()</code> and <code class="language-plaintext highlighter-rouge">arithmetic()</code> operations functions to understand what they look like in assembly code.</p>
</div>

> ### Local Variables and Function Arguments

By studying the function ```variable()``` in C, which creates a local variable $x$, we can try to understand how local variables are handled in x86 assembly and by our computers.

```c
int variable(void) {
    int x = 6;
    return x;
}

int main(void) {
    return variable();
}
```

Disassembling the above code gives the following x86 assembly code output:

```
0000000000400520 <variable>:
  400520:   55                      push   %rbp
  400521:   48 89 e5                mov    %rsp,%rbp
  400524:   c7 45 fc 06 00 00 00    movl   $0x6,-0x4(%rbp)
  40052b:   8b 45 fc                mov    -0x4(%rbp),%eax
  40052e:   5d                      pop    %rbp
  40052f:   c3                      retq   

0000000000400640 <main>:
  400640:   55                      push   %rbp
  400641:   48 89 e5                mov    %rsp,%rbp
  400644:   48 83 ec 10             sub    $0x10,%rsp
  400648:   c7 45 fc 00 00 00 00    movl   $0x0,-0x4(%rbp)
  40064f:   e8 cc fe ff ff          callq  400520 <variable>
  400654:   48 83 c4 10             add    $0x10,%rsp
  400658:   5d                      pop    %rbp
  400659:   c3                      retq   
  40065a:   66 0f 1f 44 00 00       nopw   0x0(%rax,%rax,1)
```

The ```<main>``` code looks more or less the same as the previous example, so let's focus our attention on the ```<variable>``` function. As we can see in the ```movl   $0x6,-0x4(%rbp)``` command, the number ```0x6``` is pushed onto the stack 4 bytes lower than the base stack address stored in the register ```-0x4(%rbp)```. This result agrees with our understanding that local variables are stored on the stack. In this case, the variable ```x``` will now correspond to the integer stored in the stack location ```-0x4(%rbp)```. In the next line, this value of ```x``` is moved from the stack to the return register ```%eax```, and after restoring the stack state, we return the value of ```x``` in the ```retq``` command.

<div class="notice--warning">
<p style="font-size:13pt"><strong>Problem 2:</strong> The function <code class="language-plaintext highlighter-rouge">argument()</code> also involves the use of two local variables: <code class="language-plaintext highlighter-rouge">x</code> and <code class="language-plaintext highlighter-rouge">y</code>. We know that the first argument of a function (which in this case is <code class="language-plaintext highlighter-rouge">x</code>) is stored in the register <code class="language-plaintext highlighter-rouge">%rdi</code>, and the second argument of a function (which in this case is <code class="language-plaintext highlighter-rouge">y</code>) is stored in the register <code class="language-plaintext highlighter-rouge">%rsi</code>. After analyzing the assembly code for <code class="language-plaintext highlighter-rouge">argument()</code>, is this the case?</p>
</div>

> ### Recursion and Iteration

To take a look at how assembly code implements iterative algorithms like ```for``` loops or recursion, we can disassemble the ```recursion()``` and ```forLoop()``` functions, which both sum the positive integers up to the positive integer ```x```. Let's take a look at the ```recursion()``` disassembly first.

```
0000000000400550 <recursion>:
  400550:   55                      push   %rbp
  400551:   48 89 e5                mov    %rsp,%rbp
  400554:   48 83 ec 10             sub    $0x10,%rsp
  400558:   89 7d f8                mov    %edi,-0x8(%rbp)
  40055b:   83 7d f8 01             cmpl   $0x1,-0x8(%rbp)
  40055f:   0f 8f 0c 00 00 00       jg     400571 <recursion+0x21>
  400565:   c7 45 fc 01 00 00 00    movl   $0x1,-0x4(%rbp)
  40056c:   e9 1b 00 00 00          jmpq   40058c <recursion+0x3c>
  400571:   8b 45 f8                mov    -0x8(%rbp),%eax
  400574:   8b 4d f8                mov    -0x8(%rbp),%ecx
  400577:   83 e9 01                sub    $0x1,%ecx
  40057a:   89 cf                   mov    %ecx,%edi
  40057c:   89 45 f4                mov    %eax,-0xc(%rbp)
  40057f:   e8 cc ff ff ff          callq  400550 <recursion>
  400584:   8b 4d f4                mov    -0xc(%rbp),%ecx
  400587:   01 c1                   add    %eax,%ecx
  400589:   89 4d fc                mov    %ecx,-0x4(%rbp)
  40058c:   8b 45 fc                mov    -0x4(%rbp),%eax
  40058f:   48 83 c4 10             add    $0x10,%rsp
  400593:   5d                      pop    %rbp
  400594:   c3                      retq   
  400595:   66 2e 0f 1f 84 00 00    nopw   %cs:0x0(%rax,%rax,1)
  40059c:   00 00 00 
  40059f:   90                      nop
```

At first glance, this assembly code looks much more complicated! It might be a bit more difficult to understand this code especially if we didn't know the purpose of this code or the C source code beforehand, but nonetheless, we can still try to decode it piece by piece. Once again, the first three instructions have something to do with the stack, followed by moving the integer argument ```x``` (stored in ```%edi```) onto the stack, as expected. Now, we have something interesting going on between the next four lines! We can break them down one by one:

```
cmpl $0x1, -0x8(%rbp)
```

Based on the instruction immediately above, ```-0x8(%rbp)``` refers to the value of ```x``` passed into the function. This instruction compares the number ```1``` to ```x```, and if they are equal, the ```ZF``` flag is set. In the next instruction, which is a jump instruction,

```
jg 400571 <recursion+0x21>
```

The function will jump to instruction ```400571``` (the ```mov``` instruction) only if ```1<x```. We can see that this is the base case. The commands at ```400571``` and ```400574``` seem to restore ```x``` into the registers ```%eax``` and ```%ecx```, along with some addition register manipulations. Critically, we see that at instruction ```400577```, the instruction subtracts ```1``` from ```x``` and moves it into the argument register ```%edi```, preparing for the recursive function call at ```40057f```. This is the essence of the recursive call. The value of ```x``` is also stored in the return register ```%eax``` from line ```400571``` to be added to with each recursive call, executed at instruction ```40587```.

Eventually, we'll reach the base case where instruction ```40055b``` will show that ```1 == 1```, such that the jump command at ```40055f``` is _not_ executed and we continue with ```400565``` and ```40056c```:

```
movl $0x1,-0x4(%rbp)
jmpq 40058c <recursion+0x3c>
```

This moves the number ```1``` onto the stack, which then jumps to instruction ```40058f``` that moves the same number ```1``` at ```-0x4(%rbp)``` to the return register ```%eax``` at instruction ```40058c``` that we jump to. After that, we return. As we can see, the critical instructions at ```40055b``` through ```40056c```, and also at ```40057f```, are indications that we have a recursive function on our hands. Through walking through the function step by step, we're able to see what the function does and how it works.

What about ```for``` loop iterations? Let's disassemble the ```forLoop()``` function:

```
00000000004005a0 <forLoop>:
  4005a0:   55                      push   %rbp
  4005a1:   48 89 e5                mov    %rsp,%rbp
  4005a4:   89 7d fc                mov    %edi,-0x4(%rbp)
  4005a7:   c7 45 f8 00 00 00 00    movl   $0x0,-0x8(%rbp)
  4005ae:   c7 45 f4 00 00 00 00    movl   $0x0,-0xc(%rbp)
  4005b5:   8b 45 f4                mov    -0xc(%rbp),%eax
  4005b8:   3b 45 fc                cmp    -0x4(%rbp),%eax
  4005bb:   0f 8d 17 00 00 00       jge    4005d8 <forLoop+0x38>
  4005c1:   8b 45 f4                mov    -0xc(%rbp),%eax
  4005c4:   03 45 f8                add    -0x8(%rbp),%eax
  4005c7:   89 45 f8                mov    %eax,-0x8(%rbp)
  4005ca:   8b 45 f4                mov    -0xc(%rbp),%eax
  4005cd:   83 c0 01                add    $0x1,%eax
  4005d0:   89 45 f4                mov    %eax,-0xc(%rbp)
  4005d3:   e9 dd ff ff ff          jmpq   4005b5 <forLoop+0x15>
  4005d8:   8b 45 f8                mov    -0x8(%rbp),%eax
  4005db:   5d                      pop    %rbp
  4005dc:   c3                      retq   
  4005dd:   0f 1f 00                nopl   (%rax)
```

According to ```4005a4```, we moved the argument ```x``` onto the stack at the location ```-0x4(%rbp)```, so that at the ```cap``` compare instruction at ```4005b8```, we compare ```x``` to the value stored at ```%eax```, which is ```0``` according to ```4005ae``` at first pass. The incrementing variable stored at ```-0xc(%rbp)``` is incremented in the register ```%eax``` at ```4005cd``` before being moved back to ```-0xc(%rbp)```, and continuing with the loop at the jump instruction at ```4005d3```. From instruction ```4005c4```, we can hypothesize that the result is being stored at ```-0x8(%rbp)```. This function to continues to iterate until the ```cmp``` command at ```4005b8``` returns equality, such that we jump to ```4005d8``` at the instruction ```4005bb```. At this point, we move the result being stored at ```-0x8(%rbp)``` to the return register ```%eax``` and return.

> ### More Complex Examples

Eventually, we will also learn about how to read assembly code dealing with manipulating arrays and objects in C, but this requires us to understand how to manipulate pointers in C and use dynamic memory management functions like ```malloc()``` and ```free()``` in ```stdlib.h```. Since we haven't talked about _any_ of these features yet, we'll hold up on reading more complex assembly code later.

As you can tell especially from the last two examples, reading and dissecting assembly code takes a lot of practice. When we learn more about the ```gdb``` debugging tool, we'll learn about how to "step through" each individual assembly instruction line by line. If you also have 7 bucks to spare and some free time, there's also a cool game based on decoding assembly language called TIS-100 that you can download from [Steam](https://store.steampowered.com/app/370360/TIS100/). 

> ## Writing Assembly Code

This section is currently under construction.

> ## Additional Reading

This section is currently under construction.

