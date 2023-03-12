This version is preliminary and subject to change


Introduction


In this assignment, you will do some “fill-in-the-blank” and implement parser using `Regular Expressions` functions.
You will confirm your ability to obtain statistics from text data and write a simple parsing algorithm.
This assignment will be officially due on Tue 22 November, 23:59 CET. 


Preparation


For this assignment, you will need a machine with Python that you can access from the command line — be it your own laptop, or one of the department servers like eduserv and mltgpu.


Download Assighnment-1.zip. Unzip the file. You will find the directory (folder) Assignment-1 containing two subdirectories: part_1 and part_2.


Assighnment-1


├── Part_1
│  ├── genres
│  │  ├── Metal
│  │  |── Pop
│  ├── loader.py
│  └── part1.py
└── Part_2
└── nlmaps.tsv5


Part 1: counting (20 marks)


In part_1 folder, one of the subdirectories is called genres, which consists of two further subdirectories, Pop and Metal, which in turn contain songs with lyrics of pop and metal genres.


part1.py uses the genres directory to obtain instances documents that contain metal and pop lyrics. You can see how these are loaded into data structures via the load_data function in part1.py and the load_dir function in loader.py. They are tokenized and lowercased. You can investigate the code yourself to see how they are represented.


Your task in this part of the assignment is to modify the calc_prob function in part1.py so that it returns the empirical estimate, where (in this case) the classes are “Pop” or “Rock”, and the features are words as given by the data loading functions (We will test your code with a different set of classes and documents). That is, your code is to estimate from the data the probability that a document might belong to a class if it has at least one mention of a given word.


The script is to be run like this:


$ python3 part1.py genres/ Pop love


Loading from genres/Pop.
Loading from genres/Metal.
Number of classes in corpus: 2
Looking up probability of class Pop given word love.
-log2 p(Pop|love) is undefined.



You may not use any packages other than the standard ones that come with Python 3 (so no NLTK, no numpy/scipy, etc). You may not modify loader.py either. You can create whatever “helper” functions you feel you need.


Part 2: Use regular expressions to parse (20 marks)


NLmaps is a corpus of natural language queries and their machine-readable translations for OpenStreetMap (OSM). 
We have extracted a subset of these queries about locating places in nlmaps.tsv under part_2 folder.


Write a python program using regular expressions to parse natural language queries and then translate them to machine-readable language as in this dataset. Your code must report the accuracy of exact match translations. The program doesn't need to be perfect. (15 marks)


The following code generates queries about some points of interests in urban areas in Nordic countries. Use your program to translate them into machine-readable representations. Report what portion of these test queries got translated. (5 marks)


pois = ['Japanese restaurants', 'Indian restaurants', 'Italian restaurants', 
'Starbucks', 'bakeries', 'banks', 'bus stops', 'butchers', 
'camp sites', 'cemeteries', 'charging stations', 'fire brigades', 
'fire hydrants', 'helipads', 'hiking maps', 'hospitals', 'kindergartens', 
'museums', 'peaks', 'playgrounds', 'post offices', 'schools', 'supermarkets']


locations = ['Stockholm', 'Copenhagen', 'Helsinki', 'Oslo', 'Gothenburg', 'Malmö', 'Tampere', 'Aarhus', 'Turku', 'Bergen', 'Reykjavik']


test_queries = [f"Where are {poi} in {loc}?" for poi in pois for loc in locations]


VG Part


Update part1.py so that it can take an optional additional word feature, in which case it will compute that is, the probability of any document being of that class, given the presence of at least one instance of the bigram.


Submission


Zip up the Assignment-1 directory with the modified files, and name the file A1-/yourusername/.zip, with /yourusername/ replaced with your gus-account. Submit the file here.