#include<iostream>
using namespace std;
class Clock
{
	public:
		Clock();
		void SetTime(int NewH,int NewM,int NewS);
		void ShowTime();
		~Clock(){}
	private:
		int Hour,Minute,Second;
};
Clock::Clock()
{
	Hour=0;
	Minute=0;
	Second=0;
}
void Clock::SetTime(int NewH,int NewM,int NewS)
{
	Hour=NewH;
	Minute=NewM;
	Second=NewS;
}
void Clock::ShowTime()
{
	cout<<Hour<<":"<<Minute<<":"<<Second<<endl;
}

Clock globClock;
int main()
{
	cout<<"First time output:"<<endl;
	globClock.ShowTime();
	globClock.SetTime(8,30,30);
	Clock myClock(globClock);
	cout<<"Second time output:"<<endl;
	myClock.ShowTime();

}