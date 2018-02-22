#include "Line.h"

Line::Line(){

}
//Line::Line(Node *from,Node *to,double distance):
Line::Line(string from,string to,double distance):
fromPlace(from),toPlace(to),distance(distance){/*
	this->setFromPlace(from);
	this->setToPlace(to);
	this->setDistance(distance);*/
}
/*Line::Line(Node from,Node to,double distance):
fromPlace(&from),toPlace(&to),distance(distance){
	this->setFromPlace(&from);
	this->setToPlace(&to);
	this->setDistance(distance);
}*/


double Line::getDistance(){
	return this->distance;
}
double Line::getNeedTime(){
	return this->needTime;
}
//Node* Line::getFromPlace(){
string Line::getFromPlace(){
	return this->fromPlace;
}
//Node* Line::getToPlace(){
string Line::getToPlace(){
	return this->toPlace;
}


void Line::setDistance(double distance){
	this->distance=distance;
}
void Line::setNeedTime(double neddTime){
	this->needTime=needTime;
}
//void Line::setFromPlace(Node* from){
void Line::setFromPlace(string from){
	this->fromPlace=from;
}
//void Line::setToPlace(Node* to){
void Line::setToPlace(string to){
	this->toPlace=to;
}
