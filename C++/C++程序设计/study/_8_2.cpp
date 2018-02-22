#include<iostream>
using namespace std;
class Clock
{
	public:
		Clock(int Newh=0,int NewM=0,int NewS=0);
		void ShowTime();
		Clock& operator ++();
		Clock operator ++(int);
	private:
		int Hour,Minute,Second;
};
Clock::Clock(int NewH,int NewM,int NewS)
{
	if(0<=NewH&&NewH<24&&0<=NewM&&NewM<60&&0<=NewS&&NewS<60)
	{
		Hour=NewH;
		Minute=NewM;
		Second=NewS;
	}
	else
		cout<<"Time error!"<<endl;
}
void Clock::ShowTime()
{
	cout<<Hour<<":"<<Minute<<":"<<Second<<endl;
}
Clock& Clock::operator ++()
{
	Second++;
	if(Second>=60)
	{
		Second=Second-60;
		Minute++;
		if(Minute>=60)
		{
			Minute=Minute-60;
			Hour++;
			Hour=Hour%24;
		}
	}
	return *this;
}
Clock Clock::operator ++(int)
{
	Clock old=*this;
	++(*this);
	return old;
}
int main()
{
	Clock myClock(23,59,59);
	cout<<"First time output";
	myClock.ShowTime();
	cout<<"SHow myClock++:";
	(myClock++).ShowTime();
	cout<<"show++myClock:";
	(++myClock).ShowTime();
}