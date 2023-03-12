# Libs
import nltk
from nltk.probability import FreqDist

# Load 
nltk.download('treebank')
treebank_sents = nltk.corpus.treebank.tagged_sents()

# Split the tagged sentences into training and test data
# this can be changed to an 80/20 for train/tes if needed
train_data = treebank_sents[:3000]
test_data = treebank_sents[3000:]

# frequency distribution (train)
tag_fd = FreqDist()
word_tag_fd = FreqDist()
for sentence in train_data:
    for word, tag in sentence:
        tag_fd[tag] += 1
        word_tag_fd[(word, tag)] += 1

# most likely tag for each word
most_likely_tags = {}
for word, tag_freq in word_tag_fd.items():
    word, tag = word
    if word not in most_likely_tags:
        most_likely_tags[word] = tag
    else:
        if tag_freq > word_tag_fd[(word, most_likely_tags[word])]:
            most_likely_tags[word] = tag

# unknown words - NN
most_likely_tags['UNK'] = 'NN'

# Evaluate
correct = 0
total = 0
for sentence in test_data:
    for word, gold_tag in sentence:
        total += 1
        if word in most_likely_tags:
            pred_tag = most_likely_tags[word]
        else:
            pred_tag = 'NN'
        if pred_tag == gold_tag:
            correct += 1

# Print the accuracy
print("Accuracy:", correct / total)
