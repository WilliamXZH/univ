#include<iostream>
using namespace std;
semaphore Scuthair,Snumchair;//
Scuthair=0;Snumchair=0;
class 
{
	barber:
		do{
			wait(Scuthair);//
			signal(Snumchair);
		}while(1);
	Cumtomer i:
		wait(Snumchair);
		if(number==n-1){signal(Mutexchair);exit;}
		number++;
		signal(Scuthair);
		signal(Mutexchair);
		wait(Mutexchair);
		number--;
		signal(Mutexchair);
};
