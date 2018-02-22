#ifndef PIMS_H
#define PIMS_H

#include "Utils.h"
#include "Stack.h"
#include "Queue.h"
/*
#include<STACK>
#include <QUEUE>*/


class Zanlind{
//private:
public:
	//int position;

	int number;
	//string number;

	int hour,minute;
	//int ar_time;
	//string ar_time;

	Zanlind(){}
/*	Zanlind(int pos,int num,int at):
	//position(pos),number(num),ar_time(at){}
	number(num),ar_time(at){}*/
	Zanlind(int num,int ho,int min):
	number(num),hour(ho),minute(min){}

	
/*public:
	int getPosition(){return position;}
	int getNumber(){return number;}
	string getArTime(){return ar_time;}

	void setPosition(int pos){position=pos;}
	void setNumber(int num){number=num;}
	void setArTime(string at){ar_time=at;}*/	
};
typedef Zanlind zanlind;


class pims{
private:
	stack<zanlind> park;
	queue<zanlind> sideWalk;

	//stack park;
	//queue sideWalk;
public:
	pims();
	~pims();
	void enterInPark();
	void exitOfPark();

	void MenuOfParkManagement();
};

#endif






