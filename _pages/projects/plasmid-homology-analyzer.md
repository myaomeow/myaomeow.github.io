---
permalink: /projects/plasmid-homology-analyzer/
title: "Plasmid Homology Analyzer"
toc: true
toc_label: "Contents"
---

The repository is found [here](https://github.com/myaomeow/plasmid-homology-analyzer).

> ## Program Use

Intraplasmid recombination is the phenomenon by which a bacterial cell can `cross-over' similar DNA sequences from a single plasmid to yield two separate daughter plasmids. This runs the risk of modifying the original parent plasmid in undesirable ways, such as interrupting coding regions, transcription initiators and terminators, and other key features that contribute to the plasmid activity. If sufficiently similar and long enough, two similar DNA sequences, such as those highlighted in red below, can lead to homologous recombination.

![pha-visual](/assets/images/pha-visual.png)

It has been well-characterized that intraplasmid recombination can affect plasmid stability in many commonly used bacterial cell lines. The mechanism of action often depends on the activity of the [RecA family of enzymes](https://www.nature.com/articles/nature06971), which are a set of ATPases conserved from bacteria to humans. RecA binds to ssDNA to form a helical nucleoprotein filament complex. When homology is encountered, the ensuing strand-exchange reaction results in a postsynaptic filament where the complementary strand of the donor duplex is parked with the original ssDNA. This results in a new heteroduplex and a displaced ssDNA from the donor duplex. [Other studies](https://www.pnas.org/content/104/1/216.full?sid=836bfaaf-dc19-4a1d-9bfc-3093c2253fa0) have also characterized RecA-independent recombination. In general, intraplasmid recombination can be difficult to detect when cloning different plasmids into bacterial cell lines. This Java program is designed to help warn for potential homology sites within a given plasmid.

> ## Dependencies

In order to run this program, you must have [Java](https://docs.oracle.com/javase/9/install/installation-jdk-and-jre-macos.htm#JSJIG-GUID-2FE451B0-9572-4E38-A1A5-568B77B146DE) installed.

> ## Running the Program

To run this program, first clone the [repository](https://github.com/myaomeow/plasmid-homology-analyzer) to your computer. In Unix OS (MacOS or Linux), navigate to the ```src``` directory in your Terminal and type the following:

```
$ javac *.java
$ java GUI
```

A Java application should then pop up that looks something like this:

![pha-screenshot-1](/assets/images/pha-screenshot.png){:height="85%" width="85%"}

Copy and paste your DNA sequence. The DNA sequence must only contain A, G, C, T, but they can be either upper or lowercase. The minimum homology length is the minimum number of aligned base pairs that must be analyzed in order to determine potential for intraplasmid recombination. For the minimum homology length, typical values are between 15 and 25 bp. The minimum percent match is the minimum percentage of the aligned base pairs that must be the same to warn for intraplasmid recombination. For this field, typical values are between 80 and 100 percent.

When the DNA sequence has been successfully analyzed, the output may look something like this:

![pha-screenshot-1](/assets/images/pha-screenshot-2.png){:height="85%" width="85%"}

Each group represents DNA sequences that are very similar in length and are at least $2\cdot(\text{minimum homology length})$ base pairs apart. The number represents the starting index within the initial DNA string that the DNA subsequence can be found.

> ## Documentation

The source code can be downloaded from the [repository](https://github.com/myaomeow/plasmid-homology-analyzer) linked above. Commented methods are shown for the ```Program.java``` source file only.

```java
import java.util.*;

public class Program {
    /* String field to keep track of the argument DNA sequence. */
    private String sequence;

    /* Stores the length of the argument DNA sequence. */
    private int seqLength;

    /* Stores the argument minimum homology length required. */
    private int homologyLength;

    /* Stores the minimum percent match in sequence required. */
    private double match;

    public Program(String sequence, int homoLength, double match);

    /**
     * Using the DNA sequence field, a subsequence starting at 
     * index @param start within the string and of length @param
     * length characters is generated. This function accounts for
     * the fact that the plasmid is circular.
     *
     * @param  start   starting index of the desired substring
     * @param  length  length of the desired substring
     * @return         the specified DNA sequence substring
     */
    private String subSequence(int start, int length);

    /**
     * This function compares every substring of length
     * homologyLength after the starting index @param start in the
     * field DNA sequence and returns an ArrayList of Integer[]
     * arrays. These Integer[] arrays are always of size 2. The
     * 0th element is the starting index of the sequence homology
     * found in the plasmid, and the 1st element is the length
     * of sequence homology, which is always at least homologyLength.
     *
     * @param  start   starting index of the desired substring
     * @return         an ArrayList of information on homology sites
     *                 when compared to the subsequence starting at 
     *                 index @param start
     */
    private ArrayList<Integer[]> checkRecomb(int start);

    /**
     * This function compares all possible DNA subsequences in the
     * argument DNA string sequence to look for potential homology
     * sites within the argument plasmid.
     *
     * @return         a dictionary mapping each integer start index
     *                 to the return value of this.checkRecomb()
     */
    private Hashtable<Integer, ArrayList<Integer[]>> compareAll();
    
    /**
     * This function organizes the information returned from 
     * this.compareAll() into an ArrayList of starting indices within
     * the argument DNA sequence that share the specified level of
     * homology. This ArrayList is then mapped to an integer
     * representing the maximum length of homology shared between any
     * two subsequences represented by the ArrayList<Integer> key.
     *
     * @return         a dictionary mapping an ArrayList of starting
     *                 indices with the argument DNA sequence that share
     *                 the specified level of homology to the maximum
     *                 length of homology shared between any two 
     *                 subsequences represented by the ArrayList
     */
    private Hashtable<ArrayList<Integer>, Integer> sort();

    /*
     * This function returns an HTML String representation of the 
     * homology regions that can be read easily by the user.
     *
     * @return         an HTML String representation of the homology 
     *                 regions that will be output to the user interface
     */
    public String testHomology();
}
```

The full source code can be found below.

> ### ```Program.java```

```java
/**************************************************************************
 * Copyright 2020 Michael S. Yao
 * 
 * Licensed under the Apache License, Version 2.0 (the "License"); you may
 * not use this file except in compliance with the License.  You may obtain
 * a copy of the License at
 * 
 *   http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
 * License for the specific language governing permissions and limitations
 * under the License.
 *************************************************************************/

import java.util.*;

public class Program {
    private String sequence;

    private int seqLength;

    private int homologyLength;

    private double match;

    public Program(String sequence, int homoLength, double match) {
        this.sequence = sequence;

        this.homologyLength = homoLength;

        this.match = match;

        this.seqLength = sequence.length();
    }

    private String subSequence(int start, int length) {
        StringBuilder subSeq = new StringBuilder();

        char[] array = this.sequence.toCharArray();

        for (int i = 0; i < length; i++) {
            subSeq.append(array[((start + i) % this.seqLength)]);
        }

        return subSeq.toString();
    }

    private ArrayList<Integer[]> checkRecomb(int start) {
        ArrayList<Integer[]> hom = new ArrayList<Integer[]>();

        int constraint = (int)(this.homologyLength * this.match);
        int counter = 0;

        if (start + (2 * this.homologyLength) >= this.seqLength) {
            return hom;
        }

        char[] argArray = this.subSequence(start, 
                                        this.homologyLength).toCharArray();
        for (int i = (start + (2 * this.homologyLength)) % this.seqLength; 
                i < this.seqLength; i++) {
            char[] compareArray = this.subSequence(i, 
                                        this.homologyLength).toCharArray();
            for (int j = 0; j < this.homologyLength; j++) {
                if (argArray[j] == compareArray[j]) {
                    counter++;
                }
            }

            if (counter >= constraint) {
                int index = 0;

                while (counter >= (int)((this.homologyLength + index) * 
                                            this.match)) {
                    if (this.subSequence(start + this.homologyLength + 
                            index + 1, 1).equalsIgnoreCase(this.subSequence( 
                            i + this.homologyLength + index + 1, 1))) {
                        counter++;
                    }

                    index++;
                }

                Integer[] entry = new Integer[2];
                entry[0] = i;
                entry[1] = this.homologyLength + index;
                hom.add(entry);
                
                i += (this.homologyLength + index - 1);
            }

            counter = 0;
        }

        return hom;
    }

    private Hashtable<Integer, ArrayList<Integer[]>> compareAll() {
        Hashtable<Integer, ArrayList<Integer[]>> comparison = new 
                                                        Hashtable<>();

        for (int i = 0; i < this.seqLength; i++) {
            ArrayList<Integer[]> res = this.checkRecomb(i);

            if (res.size() > 0) {
                comparison.put(i, res);

                int skip = 0;
                for (int j = 0; j < res.size(); j++) {
                    if (res.get(j)[1] > skip) { skip = res.get(j)[1]; }
                }
                i += skip;
            }

        }

        return comparison;
    }
    
    private Hashtable<ArrayList<Integer>, Integer> sort() {
        Hashtable<Integer, ArrayList<Integer[]>> comparisons = compareAll();
        
        Hashtable<ArrayList<Integer>, Integer> sorted = new Hashtable<>();
        
        for (int key : comparisons.keySet()) {
            int present = -1;

            for (ArrayList<Integer> set : sorted.keySet()) {
                if (set.contains(key)) {
                    for (Integer[] homoKey : comparisons.get(key)) {
                        if (!set.contains(homoKey[0])) { 
                            set.add(homoKey[0]);
                        }
                    }

                    present = 1;
                }

                else {
                    for (Integer[] homoKey: comparisons.get(key)) {
                        if (set.contains(homoKey[0])) {
                            if (!set.contains(key)) { set.add(key); }
                            for (Integer[] v : comparisons.get(key)) {
                                if (!set.contains(v[0])) { set.add(v[0]); }
                            }

                            present = 1;
                        }
                    }
                }
            }

            if (present == -1) {
                ArrayList<Integer> newSort = new ArrayList<>();
                newSort.add(key);
                
                int homoLength = -1;
                for (Integer[] val: comparisons.get(key)) {
                    newSort.add(val[0]);
                    
                    homoLength = val[1];
                }
                sorted.put(newSort, homoLength);
            }
        }

        return sorted;
    }

    public String testHomology() {
        StringBuilder retString = new StringBuilder();

        if (this.sort().keySet().isEmpty()) {
            retString.append("No sites of potential homology were found.");
            return retString.toString();
        }

        for (ArrayList<Integer> set : this.sort().keySet()) {
            retString.append("GROUP: <br><br>");

            for (Integer index : set) {
                retString.append(index + ": ..." + 
                    this.subSequence(index, this.sort().get(set)) + 
                                        "...<br>");
            }

            retString.append("<br><br>");
        }
        
        return retString.toString();
    }
}
```

> ### ```GUI.java```

```java
/**************************************************************************
 * Copyright 2020 Michael S. Yao
 * 
 * Licensed under the Apache License, Version 2.0 (the "License"); you may
 * not use this file except in compliance with the License.  You may obtain
 * a copy of the License at
 * 
 *   http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
 * License for the specific language governing permissions and limitations
 * under the License.
 *************************************************************************/

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JTextField;

public class GUI {
    static int width = 600;
    static int height = 800;
	
    static String htmlHead = "<html>";
    static String htmlTail = "</html>";

    public static void main(String[] args) {    
        JFrame frame = new JFrame("Plasmid Homology Analyzer"); 

        JButton b = new JButton("Analyze");    
        b.setBounds(230, 155, 140, 30);    

        JLabel label = new JLabel("Enter DNA Sequence: ");		
        label.setBounds(100, 50, 200, 30);

        JLabel label2 = new JLabel("Minimum Homology Length (bp): ");
        label2.setBounds(100, 85, 250, 30);

        JLabel label3 = new JLabel("Minimum Percent Match (0-100): ");
        label3.setBounds(100, 120, 250, 30);

        JLabel copyright = new JLabel("Copyright 2020 by Michael Yao");
        copyright.setBounds(200, height - 60, 250, 30);

        JLabel out = new JLabel();
        out.setBounds(100, 165, 450, 400);

        JTextField sequence = new JTextField();
        sequence.setBounds(235, 50, 250, 30);

        JTextField homology = new JTextField();
        homology.setBounds(310, 85, 175, 30);

        JTextField match = new JTextField();
        match.setBounds(310, 120, 175, 30);

        frame.add(out);
        frame.add(copyright);
        frame.add(sequence);
        frame.add(homology);
        frame.add(match);
        frame.add(label);
        frame.add(label2);
        frame.add(label3);
        frame.add(b); 
        frame.setSize(width, height);    
        frame.setLayout(null);    
        frame.setVisible(true); 
        frame.setResizable(false);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);   
		
	b.addActionListener(new ActionListener() {
	        
            @Override
            public void actionPerformed(ActionEvent arg0) {
                String dna = sequence.getText();
                int homologyValue = Integer.parseInt(homology.getText());
                int matchPercent = Integer.parseInt(match.getText());
                if (matchPercent > 100 || matchPercent < 0) {
                    out.setText("Invalid percent match entered.");
                    return;
                }

                Program program = new Program(dna, homologyValue, 
                        (double)matchPercent / 100);

                out.setText(htmlHead + program.testHomology() + htmlTail);
            }          
        });
    }         
}
```