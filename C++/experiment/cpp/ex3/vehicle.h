#include<iostream>
using namespace std;
class vehicle
{
	public:
		double MaxSpeed;
		double Weight;
		virtual void Run(){cout<<"The vehicle start to run."<<endl;}
		void Stop(){cout<<"The vehicle is stop."<<endl;}
};
class bicycle:virtual public vehicle
{	
	public:
		double Height;
		void Run(){cout<<"The bicycle start to run."<<endl;}
		void Stop(){cout<<"The bicycle is stop."<<endl;}
};
class motorcar:virtual public vehicle
{
	public:
		int SeatNum;
		void Run(){cout<<"The motorcar start to run."<<endl;}
		void Stop(){cout<<"The motorcar is stop."<<endl;}
};
class motorcycle:public bicycle,public motorcar
{
	public:
		void Run(){cout<<"The motorcycle start to run."<<endl;}
		void Stop(){cout<<"The motorcycle is stop."<<endl;}
};