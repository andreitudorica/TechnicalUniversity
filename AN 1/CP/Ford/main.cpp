#include<iostream>
#include<fstream>
#include<vector>
#include<queue>
#include<cstring>
using namespace std;
ifstream in("input.txt");
char locations[100][100];//the list of all the location names
int n;//number of locations

vector< pair<int, int> > adjList[50001];//the adiacency lists for every location
int dist[50001];//the distance from Math-Comp Science to every location
int cantEdge[50001];
int used[50001];
queue<int> q;

void BellmanFord(int source)
{
	for (int i = 0; i <= n; i++)
	{
		dist[i] = 2147483647;
		cantEdge[i] = 0;
	}

	q.push(source);
	dist[source] = 0;
	while (!q.empty())
	{
		int curNode = q.front();
		q.pop();
		used[curNode] = false;
		vector<pair<int, int> >::iterator it;
		for (it = adjList[curNode].begin(); it != adjList[curNode].end(); it++)
		{
			pair<int, int> CurrentNode;
			CurrentNode = *it;
			cout<<CurrentNode.first<<' '<<CurrentNode.second<<'\n';
			if (CurrentNode.second + dist[curNode] < dist[CurrentNode.first])
			{
				dist[CurrentNode.first] = CurrentNode.second + dist[curNode];
				if (!used[CurrentNode.first])
				{
					q.push(CurrentNode.first);
					used[CurrentNode.first] = true;
					cantEdge[CurrentNode.first] ++;
				}
			}
		}
	}
}

int search(char str[])//searches for a given name in the location list. if there is no such location, it return -1
{
	for (int i = 0; i <= n; i++)
		if (!strcmp(str, locations[i]))
			return i;
	return -1;
}

int main()
{
	char start[100], end[100];
	int cost, start_pos, end_pos;
	while (in.getline(start, 100))//reads start location
	{
		in.getline(end, 100);//reads destionation
		in >> cost;//reads the cost of a certain edge
		start_pos = search(start);//searches for the start location
		end_pos = search(end);//searches for the destination location
		if (start_pos == -1)//if the start location does not exist
		{
			start_pos = n;
			strcpy(locations[n++], start);//it is added at the end of the list
		}
		if (end_pos == -1)//if the destination location does not exist
		{
			end_pos = n;
			strcpy(locations[n++], end);//it is added at the end of the list
		}
		adjList[end_pos].push_back(make_pair(start_pos, cost));//the edge is added in the adjacency list for start
		adjList[start_pos].push_back(make_pair(end_pos, cost));//the edge is added in the adjacency list for end
		in.getline(start, 100);//reads '\n' at the end of the cost line
	}
	n--;//gets rid of the last useless line
	BellmanFord(search("Math-Comp Science"));//calls the BellmanFord function starting from the position of Math-Comp Science
	for (int i = 0; i <= n; i++)
		if (strcmp("Math-Comp Science", locations[i]))//if the location if different from Math-Comp Science
			cout << "Distance from Math-Comp Science to " << locations[i] << " is " << dist[i] << "\n";
	return 0;
}
