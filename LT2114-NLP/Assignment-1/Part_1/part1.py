import sys
import os
import argparse
import math
from loader import load_dir

def load_data(rootdir):
    '''
    Loads all the data by searching the given directory for
    subdirectories, each of which represent a class.  Then returns a
    dictionary of class vs. text document instances.
    '''

    classdict = {}
    for classdir in os.listdir(rootdir):
        fullpath = os.path.join(rootdir, classdir)
        print("Loading from {}.".format(fullpath))
        if os.path.isdir(fullpath):
            classdict[classdir] = load_dir(fullpath)
    return classdict

### calc_prob IS THE ONLY FUNCTION TO MODIFY
def calc_prob(classdict, classname, word1, word2=None):
    '''
    Working code for the VG part... look comments for the method below for
    the G part...
    Calculates p(classname|word1, word2) given the corpus in classdict.
    '''
    num_of_documents = 0
    num_bigram_all = 0
    num_bigram_class = 0
    for class_name, docs_in_the_class in classdict.items():
        num_of_documents += len(docs_in_the_class)

        for doc in docs_in_the_class:
            if word2:
                num_bigram_all += len([i for i in range(len(doc) - 1) if doc[i] == word1 and doc[i + 1] == word2])
                if class_name == classname:
                    num_bigram_class += len([i for i in range(len(doc) - 1) if doc[i] == word1 and doc[i + 1] == word2])
            else:
                num_bigram_all += doc.count(word1)
                if class_name == classname:
                    num_bigram_class += doc.count(word1)
    prob = num_bigram_class / num_bigram_all
    return prob


# helper function
def get_probability(complete, partial):
    return (partial / complete)

def get_word_count(dict_word, search_word):
    number = 0
    for key, value in dict_word.items():
        if key == search_word:
            number = value
    return number


def frequency(lst):
    counts = {} # dict
    for sublist in lst:
        for x in sublist:
            if x in counts:
                counts[x] += 1
            else:
                counts[x] = 0
    return counts

if __name__ == "__main__":

    '''
    Entry point for the code. We load the command-line arguments.
    '''
    parser = argparse.ArgumentParser()
    parser.add_argument("filesdir", help="The root directory containing the class directories and text files.")
    parser.add_argument("classname", help="The class of interest.")
    parser.add_argument("feature", help="The word of interest for calculating -log2 p(class|feature).")

    args = parser.parse_args()

    corpus = load_data(args.filesdir)

    print("Number of classes in corpus: {}".format(len(corpus)))
    
    print("Looking up probability of class {} given word {}.".format(args.classname, args.feature))
    prob = calc_prob(corpus, args.classname, args.feature)
    if prob == 0:
        print("-log2 p({}|{}) is undefined.".format(args.classname, args.feature))
    else:
        print("-log2 p({}|{}) = {:.3f}".format(args.classname, args.feature, -math.log2(prob)))
    
