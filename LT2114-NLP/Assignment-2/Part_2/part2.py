import nltk
nltk.download('treebank')
from nltk.grammar import ProbabilisticProduction
from nltk.parse import ViterbiParser
from nltk.tree import Tree
from nltk.corpus import treebank

start = nltk.Nonterminal('S')
frequencies = dict()
probabilities = dict()
prod_to_prob = dict() # added mapping

for tree in treebank.parsed_sents()[:100]:
    # convert to binary format
    tree.chomsky_normal_form()
    productions = tree.productions()
    # calculate frequencies
    for prod in productions:
        if prod in frequencies:
            frequencies[prod] += 1
        else:
            frequencies[prod] = 1

total_freq = sum(frequencies.values())
for prod, freq in frequencies.items():
    lhs = prod.lhs()
    rhs = prod.rhs()
    prob = freq/total_freq
    prob_prod = ProbabilisticProduction(lhs, rhs, prob=prob)
    probabilities[prod] = prob_prod
    prod_to_prob[prob_prod] = prod # added mapping

# sum probabilities of all productions with the nonterminal `S` as the left-hand side
sum_probabilities = sum(prod.prob() for prod in probabilities.values() if prod.lhs() == start)

def renormalize_pcfg_probabilities(start, probabilities):
    nonterminals = set(prod.lhs() for prod in probabilities.values())
    new_probs = {}
    for nonterm in nonterminals:
        sum_probabilities = sum(prod.prob() for prod in probabilities.values() if prod.lhs() == nonterm)
        if sum_probabilities != 1:
            factor = 1/sum_probabilities
            for prob_prod in probabilities.values():
                if prob_prod.lhs() == nonterm:
                    new_prob = prob_prod.prob() * factor
                    new_prod = ProbabilisticProduction(prob_prod.lhs(), prob_prod.rhs(), prob=new_prob)
                    new_probs[new_prod] = new_prod
    return new_probs

renormalized_probs = renormalize_pcfg_probabilities(start, probabilities)

# create PCFG
grammar = nltk.grammar.PCFG(start, renormalized_probs)

# create parser
viterbi_parser = ViterbiParser(grammar)

for sent in treebank.sents()[:5]:
    parse_trees = list(viterbi_parser.parse(sent))
    if parse_trees:
        for tree in parse_trees:
            print(tree)
    else:
        print("No parse found for sentence:", sent)
