#ifndef Line_H
#define Line_H


#include "Node.h"

class Line {
private:
	double distance;
	double needTime;
	string fromPlace;
	string toPlace;

	//Node* fromPlace;
	//Node* toPlace;
public:
	Line();
	Line(string from,string to,double distance);
	//Line(Node *from,Node *to,double distance);
	//Line(Node from,Node to,double distance);

	void setDistance(double distance);
	void setNeedTime(double neddTime);
	void setFromPlace(string from);
	void setToPlace(string to);
	//void setFromPlace(Node* from);
	//void setToPlace(Node* to);

	double getDistance();
	double getNeedTime();

	string getFromPlace();
	string getToPlace();
	//Node* getFromPlace();
	//Node* getToPlace();

};
#endif