---
permalink: /java/bfs-dfs/
author_profile: false
title: "Tree Search Algorithms (BFS and DFS)"
toc: true
toc_label: "Contents"
---

<div class="notice--info">
<p style="font-size:13pt"><strong>Learning Objectives:</strong> By the end of this learning module, you should understand...</p>
<ol>
  <li style="font-size:13pt">the basics of a graph and how to identify and represent trees in Java.</li>
  <li style="font-size:13pt">the idea and possible implementations behind breadth first search and depth first search tree-searching algorithms.</li>
  <li style="font-size:13pt">the advantages of having a <code class="language-plaintext highlighter-rouge">verbose</code> flag when writing programs.</li>
</ol>
</div>

> ## Graphs

> ## Trees

> ## Tree Search Algorithms

> ### Breadth First Search (BFS)

> ### Depth First Search (DFS)

> ### Summary and Comparison

> ## ```verbose``` Flags

> ### Example

> ## Your Turn

Now that you understand the idea behand our two tree search algorithms, it's your turn to implement them! Navigate to the ```repl``` linked [here](https://repl.it/@myaomeow/TreeSearchAlgorithms), which is also shown below, and follow the following steps.

<iframe height="1000px" width="100%" src="https://repl.it/@myaomeow/TreeSearchAlgorithms?lite=true" scrolling="no" frameborder="no" allowtransparency="true" allowfullscreen="true" sandbox="allow-forms allow-pointer-lock allow-popups allow-same-origin allow-scripts allow-modals"></iframe>

> ### Problem 1

Read through the ```Main.java``` source code and make sure that you understand how the code functions. In the beginning of the driver program, there are a set of nodes and edges created to represent the tree. Draw out the tree and what it looks like (it should be the same as the example tree we looked at above).

> ### Problem 2

Implement the DFS algorithm that we've described above. Once you have completed that, compare your implementation with the solution implementation shown in ```sol/DFSIterativeSol.java``` in the same ```repl```.

> ### Problem 3

Implement the BFS algorithm that we've described above. Once you have completed that, compare your implementation with the solution implementation shown in ```sol/BFSIterativeSol.java``` in the same ```repl```.

> ### Problem 4

Run your program to test both your BFS Implementation and DFS Implementation through appropriately modifying the last couple of lines of ```Main.java```'s driver program. Turn the ```verbose``` flag on to observe the behavior of the algorithms. Do they behave as expected? As you can hopefully see, having a ```verbose``` flag option makes debugging code and understanding algorithms a lot easier!

> ### Problem 5

The implementations of BFS and DFS that we learned about today are what we call *iterative algorithms*. This means that they use iteration through either ```for``` or ```while``` loops to traverse through all of the notes in the tree. How could you potentially modify your implementations so that they are *recursive algorithms*, which substitute any looping with recursive function calls? To see an example of BFS implemented recursively, visit [this link](https://www.techiedelight.com/breadth-first-search/). To see an example of DFS implemented recursively, visit [this link](https://www.techiedelight.com/depth-first-search/).

<hr>

<div class="two-container" style="width: 100%">
  <div style="text-align: center;"><a href="/java/evil-hangman/index.html" class="btn btn--info" style="font-size:13pt">Previous Lesson</a></div>
  <div style="text-align: center;"><a href="#" class="btn btn--info" style="font-size:13pt">Next Lesson</a></div>
</div>