---
permalink: /computing-systems/x86-assembly-p3/
author_profile: false
title: "Reading and Writing x86 Assembly"
toc: true
toc_label: "Contents"
---

Now that we have an idea of the basics of what goes into assembly code, let's try actually reading and writing assembly ourselves! For our reference, here's a [link](/computing-systems/x86-assembly-p2/index.html#common-x86-assembly-commands) to the list of common instructions that we talked about last time.

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