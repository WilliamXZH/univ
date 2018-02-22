#ifndef NODE_H
#define NODE_H
#include <iostream>
using namespace std;
////////////////////////////////////////////////
class Node_Array;

class Node_List
{
public:
	int position;
	int weight;
	Node_List *next;
	string name;
	string intruduction;
	string popularity;
	bool reating_area;
	bool toillet;

	Node_List(int a,int b){position=a,weight=b;next=NULL;}
	Node_List(){next=NULL;}
	~Node_List(){};

private:

};


class Node_Array
{
public:
	string name;
	Node_List *next;
	bool visited;
	
	Node_Array(){next=NULL; visited=false;}
	~Node_Array(){}
private:

};
////////////////////////////////////////////////
#endif