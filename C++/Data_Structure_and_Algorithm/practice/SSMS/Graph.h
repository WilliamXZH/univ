#ifndef GRAPH_H
#define GRAPH_H
#define MAXVEX 100

#include <ctime>
#include <FSTREAM>
#include <SSTREAM>
#include <CSTDLIB>

#include "Line.h"
#include <VECTOR>

class Graph{
private:
	int nodesCount;
	int linesCount;
	int dis[MAXVEX][MAXVEX];
	/* container available:
	1.deque
	2.list
	3.iterator
	...*/
	vector<Node> nodes;
	vector<Line> lines;
	
	void initialized();
	void addNode(string name);
	void addLine(string from,string to,int distance);

	bool isExist(Node node);
	bool isExist(string name);
	bool isEdge(string v1,string v2);

	int getIndexOfNodes(string name);

	Node* getNode();
	Line* getLine();

public:
	Graph();
	Graph(int nodesCount,int linesCount);
	~Graph();
	
	int getNodesCount();
	int getLinesCount();
	vector<Node> getNodes();
	vector<Line> getLines();
	
	void setNodesCount(int nodesCount);
	void setLinesCount(int linesCount);	
	
	/* 1.create a new graph or update. */
	void CreateGraph();
	/* 9.create a new graph automatically. */
	void autoCreateGraph();
	
	/* 2.output the road map of travel. */
	void OutputGraph();

	
	/* 3.0 called by function CreateTourSortGraph(). */
	void depthFirstSearch(int cur,int flag[MAXVEX]);
	/* 3.Create a travel tour. */
	void CreateTourSortGraph();

	/* 4.1 Print a loop in the graph. */
	void printLoop(int from,int cur,int father[MAXVEX]);
	/* 4.2 Depth-first-search travel is the kernel of the algorithm. */
	void dfsTravel(int cur,int father[MAXVEX],int loop[MAXVEX]);
	/* 4. Do some preparation before search loop. */
	void loopSearch();
	/* 4.Abandoned, because the graph I find is non-directive. 
	However, it also proper to a directive graph. */
	void TopoSort();

	/* 5.1 Mark all node's father node and the minimum distance 
	between the current node and from node. */
	void Dijkstra(int from,int cur,int to,int last[MAXVEX],int dis2[MAXVEX]);
	/* 5.2 Output the shortest road. */
	void outputRoad(int ucr,int last[MAXVEX]);
	/* 5.Just some preparation or initialization. */
	void MiniDistance();

	/* 6.1 This is a preparation according to the quickly sorting. */
	void sort(int i,int j,int x[MAXVEX],int y[MAXVEX],int z[MAXVEX]);
	/* 6.2 Get the x-th node's dad node. */
	int getfather(int x,int dad[MAXVEX]);	
	/* 6.3 Because of the sparse graph, I don't use prim's algorithm. */
	void kruskal(int n,int e,int x[MAXVEX],int y[MAXVEX],int z[MAXVEX],int dad[MAXVEX]);
	/* 6.Create a minimum span tree to find the best way of the roads' building */
	void MiniSpanTree();

	/* 7.1 According to you keyword, you can get a series of relative information. */
	void SearchByInput();
	/* 7.2.0 After the operation of sorting, some information you want will be print on the screen. */
	void PrintSortResult(int needs[MAXVEX],int cities[MAXVEX]);
	/* 7.2.1 Bubble sort is the most basically sorting algorithm. */
	void BubbleSortByNeed(int seq,int needs[MAXVEX],int cities[MAXVEX]);
	/* 7.2.2 Rapid sort is a the most quickly sorting algorithm. */
	void QuickSortByNeed(int i,int j,int seq,int needs[MAXVEX],int cities[MAXVEX]);
	/* 7.2.3 Insertion sort is quickly, but spend more space. */
	void InsertionByNeed(int seq,int needs[MAXVEX],int cities[MAXVEX]);
	/* 7.2 There are two needs, three algorithms and two sequence you can choose to composite. */
	void SortByNeed();
	/* 7.3 I want to accomplish a function that is for the modifying the node's information. */
	/* 7.This is a menu about nodes' operation. */
	void ScenicManage();


};

#endif
