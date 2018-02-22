#pragma once
#ifndef GRAPH_H
#define GRAPH_H
#include <iostream>
using namespace std;
#include <stdio.h>
#include <string>
#include "Node.h"
//#include "Slist.h"
#define max 100
#define infinite 32767
////////////////////////////////////////////////
class ALGraph
{
private:
	int matrix[max][max];
	int popularity[max];
	int number_node;
	int number_edge;
	ArcNode ArcNode[max];//存储点的信息
	AdjList * *po[max];//存储边的信息
	AdjList *pol;//为邻接矩阵赋值的指针
	string TourSortGraph;
	//Slist slist;	
public:	
	ALGraph(){}
	void CreatGraph();
	int  LocateVex(string name);
	bool isEmpty();
	bool IsEdge(string v1,string v2);
	bool IsEdge(int m,int n);
	void OutputGraph();
	void DFS(string name);
	void DFS(int v, bool *used); 
	void DFSTraverse();
	void DFS(int v);
	bool VisitedDone();
	void MiniDistanse(string start,string dest);
	int  CountLines(char *filename);
	void Popu_Sorting();
	void quickSort(int s[], int l, int r);
	void Find(string object);
	void CreatTourSortGraph();
	void Tour(int a_value,int b_value);
	void MiniSpanTree();
};
////////////////////////////////////////////////
#endif