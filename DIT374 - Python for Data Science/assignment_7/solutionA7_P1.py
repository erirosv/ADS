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


g = Graph(4)
g.addEdge(0, 1, 1)
g.addEdge(0, 2, 3)
g.addEdge(0, 3, 5)
g.addEdge(1, 2, 6)
g.addEdge(1, 3, 8)
g.addEdge(2, 3, 9)
 
s = 0
 
print(g.DAG(s))
print(g.dijkstra(s))



