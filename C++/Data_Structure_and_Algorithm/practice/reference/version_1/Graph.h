#ifndef GRAPH_H
#define GRAPH_H
#include <iostream>
using namespace std;
#include <stdio.h>
#include <string>
#include "node.h"
#define max 10
#define infinite 32767
////////////////////////////////////////////////
class Graph
{
private:
	int matrix[max][max];
	string node_name[max];
	int number_node;
	int number_edge;
	Node_Array list[max];

public:
	
	Graph(){}
	void CreatGraph();
	int location(string name);
	bool isEmpty();
	//判断要查的这两个顶点之间是否有直接相连的边
	bool IsEdge(string v1,string v2);
	bool IsEdge(int m,int n);
	void OutputGraph();
	void DFS(string name);
	void DFS(int v, bool *used); 
	void DFSTraverse();
	void DFS(int v);
	bool VisitedDone();
	void MiniDistanse(string start,string dest);

};
////////////////////////////////////////////////
#endif