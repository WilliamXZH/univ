#include "Node.h"

/* Just for static attributes.
bool Node::haveRestingArea=false;
bool Node::haveToillet=false;
int Node::popularity=0;
string Node::info=NULL;
string Node::name=NULL;
*/

/* Constructor and Destructor functions */
Node::Node():
haveToillet(false),haveRestingArea(false),popularity(0),name(""),info(""){
}
Node::Node(string Name):
haveToillet(false),haveRestingArea(false),popularity(0),name(Name),info(""){
}
/*Node::Node(Node& node){
	this->haveToillet=node.getIfHaveToillet();
	this->haveRestingArea=node.getIfHaveRestingArea();
	this->popularity=node.getPopularity();
	this->name=node.getName();
	this->info=node.getInfo();
}*/
Node::Node(Node *node):
haveToillet(node->getIfHaveToillet()),haveRestingArea(node->getIfHaveRestingArea()),popularity(node->getPopularity()),
name(node->getName()),info(node->getInfo()){
	/*
	Node(node->getIfHaveToillet(),node->getIfHaveRestingArea(),
		node->getPopularity(),node->getName(),node->getInfo());*/
}
Node::Node(bool HaveToillet,bool HaveRestingArea,int Popularity,string Name,string Info):
haveToillet(HaveToillet),haveRestingArea(HaveRestingArea),popularity(Popularity),name(Name),info(Info){/*
	this->haveToillet=haveToillet;
	this->haveRestingArea=haveRestingArea;
	this->popularity=popularity;
	this->name=name;
	this->info=info;
	
	this->setIfHaveToillet(haveToillet);
	this->setIfHaveRestingArea(haveRestingArea);
	this->setPopularity(popularity);
	this->setName(name);
	this->setInfo(info);

	cout<<"Build Node:"<<this->haveToillet<<"_"<<this->haveRestingArea<<"_"<<this->popularity<<"_"<<this->name<<"_"<<this->info<<endl;*/
}
Node::~Node(){
	//cout<<name<<" destructed!"<<endl;
}

/* Some functions to set Node's attributes. */
void Node::setIfHaveRestingArea(bool ifHaveRestingArea){
	this->haveRestingArea=ifHaveRestingArea;
}
void Node::setIfHaveToillet(bool ifHaveToillet){
	this->haveToillet=ifHaveToillet;
}
void Node::setPopularity(int popularity){
	this->popularity=popularity;
}
void Node::setName(string name){
	this->name=name;
}
void Node::setInfo(string info){
	this->info=info;
}

/* Some functions to get Node's attributes. */
bool Node::getIfHaveRestingArea(){
	return this->haveRestingArea;
}
bool Node::getIfHaveToillet(){
	return this->haveToillet;
}
int Node::getPopularity(){
	return this->popularity;
}
string Node::getName(){
	return this->name;
}
string Node::getInfo(){
	return this->info;
}

/* to judge if the param string is equals to the Node's name */
bool Node::equals(string name){
	//cout<<this->getName()<<":"<<name<<endl;
	return name==this->getName();
}
/* to judge if the Node param point referenced is equals to the Node */
bool Node::equals(Node *Spot){
	return equals(Spot->getName());
}
/* to judge if the param Node is equals to the Node */
bool Node::equals(Node Spot){
	return equals(Spot.getName());
}