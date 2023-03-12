import matplotlib.pyplot as plt
import numpy as np

np.random.seed(70);

def partA():
	sampleSmall = [np.random.rand() for x in  range(1000)];
	sampleMedium = [np.random.rand() for x in range(10000)];
	sampleLarge = [np.random.rand() for x in  range(100000)];

	# What is the shape of this histogram and why?
	# It's flat befause random.rand is uniformly distributed.
	plt.hist(sampleSmall, density=True, bins=30);
	plt.show();

	plt.hist(sampleMedium, density=True, bins=30);
	plt.show();

	plt.hist(sampleLarge, density=True, bins=30);
	plt.show();

	# Investigate how the shape of the histogram is affected 
	# by the number of random numbers you have generated.
	# Bigger sample => flatter (less noise; law of large numbers).

	sampleSmall = [np.random.normal() for x in  range(1000)];
	sampleMedium = [np.random.normal() for x in range(10000)];
	sampleLarge = [np.random.normal() for x in  range(100000)];

	plt.hist(sampleSmall, density=True, bins=30);
	plt.show();

	plt.hist(sampleMedium, density=True, bins=30);
	plt.show();

	plt.hist(sampleLarge, density=True, bins=30);
	plt.show();

def partB():
	sample = [examScore(0.8, 20) for x in range(10000)]
	plt.hist(sample, density=True, bins = 40);
	plt.show();

def partC():
	sample = [numberOfAttempts(0.4) for x in range(10000)]
	plt.hist(sample, density=True, bins = 8);
	plt.show();

def success(pSuccess):
	return np.random.rand() < pSuccess;

def examScore(pCorrect, instances):
	score = 0;
	for i in range(instances):
		if success(pCorrect):
			score += 1;

	return score;

def numberOfAttempts(pPass):
	attempts = 0;
	while not success(pPass):
		attempts += 1;

	return attempts;	


partA();
partB();
partC();
