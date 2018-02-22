#ifndef Node_H
#define Node_H

#include<string>
#include<iostream>
using namespace std;

class Node {
private:
	int popularity;
	bool haveToillet;
	bool haveRestingArea;
	string name;
	string info;
public:

	Node();
	Node(string name);
	Node(Node *node);
	//Node(Node &node);
	Node(bool haveToillet,bool haveRestingArea,int popularity,string name,string info);
	~Node();

	void setIfHaveToillet(bool ifHaveToillet);
	void setIfHaveRestingArea(bool ifHaveRestingArea);
	void setPopularity(int popularity);
	void setName(string name);
	void setInfo(string info);

	bool getIfHaveToillet();
	bool getIfHaveRestingArea();
	int getPopularity();
	string getName();
	string getInfo();
	
	bool equals(Node Spot);
	bool equals(Node *Spot);
	bool equals(string name);
};
#endif