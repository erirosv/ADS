
import re

# Load the NLmaps dataset
with open('nlmaps.tsv') as f:
    data = f.readlines()

# Create a dictionary of natural language queries and their corresponding translations
nlmaps = {}
for line in data:
    match = re.match(r'(.*)\t(.*)', line)
    if match:
        nlmaps[match.group(1)] = match.group(2)

# Define a function to translate a natural language query to machine-readable language
def translate(query, nlmaps):
    for key in nlmaps:
        #print(f'key: {key}')
        matches = re.findall(key, query, re.IGNORECASE)
        #print(f'matches: {matches}')
        if matches:
            return nlmaps[key]
    return None

# Define a function to calculate the accuracy of the translations
def accuracy(test_queries, nlmaps):
    total = len(test_queries)
    correct = 0
    for query in test_queries:
        if translate(query, nlmaps) is not None:
            correct += 1
    return correct / total

# Define the test queries
pois = ['Japanese restaurants', 'Indian restaurants', 'Italian restaurants', 
'Starbucks', 'bakeries', 'banks', 'bus stops', 'butchers', 
'camp sites', 'cemeteries', 'charging stations', 'fire brigades', 
'fire hydrants', 'helipads', 'hiking maps', 'hospitals', 'kindergartens', 
'museums', 'peaks', 'playgrounds', 'post offices', 'schools', 'supermarkets']

# NOTE!!!
# this location dos not give any matches for the given querries, 
# however it does work if adding the locations to the locations-list.
locations = ['Edinburgh','Stockholm', 'Copenhagen', 'Helsinki', 'Oslo', 'Gothenburg', 'Malmö', 'Tampere', 'Aarhus', 'Turku', 'Bergen', 'Reykjavik']

test_queries = [f"Where are {poi} in {loc}?" for poi in pois for loc in locations]

# Translate the test queries and calculate the accuracy
for query in test_queries:
    print(f'{query}: {translate(query, nlmaps)}')
print(f'Accuracy: {accuracy(test_queries, nlmaps)}')


