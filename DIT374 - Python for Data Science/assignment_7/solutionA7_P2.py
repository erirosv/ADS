from collections import defaultdict
 
class Graph:
	def __init__(self,vertices):
		self.V = vertices;
		self.graph = defaultdict(list);
 
	def addEdge(self,a, b, c):
		self.graph[a].append((b,c));
 
	def tsMagic(self, v, visited, stack):
		visited[v] = True;
		if v in self.graph.keys():
			for node,weight in self.graph[v]:
				if visited[node] == False:
					self.tsMagic(node,visited,stack);
		stack.append(v);
 
 
	def DAG(self, s):
		visited = [False]*self.V;
		stack =[];
 
		for i in range(self.V):
			if visited[i] == False:
				self.tsMagic(s,visited,stack);
 
		dist = [float("inf")] * (self.V);
		dist[s] = 0;
 
		while stack:
			i = stack.pop();
 
			for node,weight in self.graph[i]:
				if dist[node] > dist[i] + weight:
					dist[node] = dist[i] + weight;
 
		return dist;

	def magicUtil(self, l, v):
		val = 10000;
		ix = -1;
		i = 0;
		while i < len(l):
			if not v[i] and l[i] < val:
				val = l[i];
				ix = i;
			i += 1;
		return ix;

	def dijkstra(self, s):
		visited = [False]*self.V;
		
		dist = [float("inf")] * (self.V);
		dist[s] = 0;

		cur = s;

		while True:
			for node,weight in self.graph[cur]:
				if dist[node] > dist[cur] + weight:
					dist[node] = dist[cur] + weight
			
			visited[cur] = True;

			cur = self.magicUtil(dist, visited);
			if cur == -1:
				return dist;

trams = [
	"tram1",
	"tram2",
	"tram3",
	"tram4",
	"tram5",
	"tram6",
	"tram7",
	"tram8",
	"tram9",
	"tram10",
	"tram11",
	"tram14",
];

stops = {}
connections = []
terms = [];

for tram in trams:
	with open(tram + ".txt", mode="r", encoding="utf-8") as file:
		lines = file.readlines()
		lines = [line.rstrip().split(',') for line in lines]
		ctr = 0;
		i = 0
		while i < len(lines) - 1:
			cur = lines[i][0]
			nxt = lines[i+1][0]
			cost = lines[i][1]

			if not cur in stops:
				stops[cur] = ctr;
				ctr += 1;
			connections.append((cur, nxt, cost));
			i += 1;

		cur = lines[i][0]
		terms.append(cur);
		if not cur in stops:
			stops[cur] = ctr;

g = Graph(len(stops));

hubdict = {}

for connection in connections:
	if not connection[0] in hubdict:
		hubdict[connection[0]] = 1;
	else:
		hubdict[connection[0]] += 1;

hubs = []
for key in hubdict:
	if hubdict[key] > 3:
		hubs.append(key)


for connection in connections:
	start = stops[connection[0]]
	end = stops[connection[1]]
	cost = int(connection[2]);
	if connection[0] in hubs or connection[0] in terms:
		g.addEdge(start, end, cost);

chalmers = stops["Chalmers"];
centralen = stops["Centralstationen"];
saltis = stops["Saltholmen"];
print(g.DAG(chalmers)[centralen])
print(g.DAG(saltis)[chalmers])

