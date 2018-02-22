#include<iostream>
using namespace std;
class Clock
{
	public:
		void SetTime(int NewH,int NewM,int NewS);
		void ShowTime();
	private:
		int Hour,Minute,Second;
};
inline void Clock::SetTime(int NewH=0,int NewM=0,int NewS=0)
{
	Hour=NewH;
	Minute=NewH;
	Second=NewS;
}
inline void Clock::ShowTime()
{
	cout<<Hour<<":"<<Minute<<":"<<Second<<endl;
}
int main()
{
	Clock myClock;
	cout<<"First time set and output:"<<endl;
	myClock.SetTime();
	myClock.ShowTime();
	cout<<"Second time set and output:"<<endl;
	myClock.SetTime(8,30,30);
	myClock.ShowTime();
}