Evaluate POS taggers and Build PCFG grammar

Part 1: Evaluate Multi-class Taggers with Precision, Recall, and F1-score
This part has 20 Marks.


Study the notebook file "Train and Evaluate POS taggers.ipynb" that located in Part_1 directory: run the code which trains different classifiers and evaluates average performances with precision, recall and f1score. The code also reports the scores for each individual label in each model. You will find all information regarding this assignment in notbook file.


Part 2: Build PCFG grammar (20 marks)

Write a program which reads the first 100 sentences in NLTK treebank and builds a dictionary of rules and their probabilities according to Equation C.17. (Appendix C, J&M 2019): [https://web.stanford.edu/~jurafsky/slp3/C.pdf](https://web.stanford.edu/~jurafsky/slp3/C.pdf)

Then build a PCFG grammar in NLTK and parse first 5 sentences with Viterbi parser in NLTK as in Example 6.4 here: [https://www.nltk.org/book/ch08.html.](https://www.nltk.org/book/ch08.html.) 

Here are some hints and code examples for this part:

Hint 1:

# To make your list of productions from your probability dictionary, try making use of this function:
nltk.grammar.ProbabilisticProduction()
# It requires 3 arguments: lhs, rhs, and prob.
# To get "lhs" and "rhs", you can use the .lhs() and .rhs() functions on each rule from your dictionary, and use the associated probability as "prob".
# For each rule and probability pair that you run the function on, add the result to your productions list.

Hint 2:

# When you create your grammar with nltk.PCFG() you need 2 arguments: start (the start symbol) and productions (your list of productions from the previous hint.)
# You can use this line to set the start symbol:
start = nltk.Nonterminal('S')
# You can then use this "start" variable as the start symbol in nltk.PCFG()
# Code example:

from nltk.corpus import treebank

frequencies = dict()
for tree in treebank.parsed_sents()[:100]:
    # binary format:
    tree.chomsky_normal_form()
    productions = tree.productions()
    # for each alpha_beta production:
    #   alpha = alpha_beta.lhs()
    # update

# build probabilities.
# build grammar.
# test on first 5 sentences of the treebank:
# treebank.sents()[:5]


VG Part: Implement Probabilistic CKY 
Create a dictionary of production rules and their probabilities in [Figure C.1.Chapter 14 J&M 2019](https://web.stanford.edu/~jurafsky/slp3/C.pdf)
Represent each production rule as a 2-tuple (LHS, RHS) in python where each RHS is also a tuple. Represent both terminal and non-terminals as strings. (i.e. {('S', ('NP', 'VP')) : .8, ...}) 

Implement the algorithm in Figure C.3 and its build_tree function (10 marks).

Run the algorithm on the example sentence in Figure C.4.