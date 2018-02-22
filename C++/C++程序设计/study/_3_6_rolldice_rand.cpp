#include<iostream>
#include<cstdlib>
using namespace std;
int rolldice(void);
int main()
{
	int gamestatus,sum,mypoint;
	unsigned seed;
	cout<<"Please enter an unsigned integer:";
	cin>>seed;
	srand(seed);
	sum=rolldice();
	switch(sum)
	{
		case 7:
		case 11:
			gamestatus=1;
			break;
		case 2:
		case 3:
		case 12:
			gamestatus=2;
			break;
		default:
			gamestatus=0;
			mypoint=sum;
			cout<<"point is "<<mypoint<<endl;
			break;
	}
	while(gamestatus==0)
	{
		sum=rolldice();
		if(sum==mypoint)
			gamestatus=1;
		else 
			if(sum==7)
				gamestatus=2;
	}
	if(gamestatus==1)
		cout<<"player wins\n";
	else cout<<"player loser\n";
}
int rolldice(void)
{
	int die1,die2,worksum;
	die1=1+rand()%6;
	die2=1+rand()%6;
	worksum=die1+die2;
	cout<<"palyer rolled "<<die1<<'+'<<die2<<'='<<worksum<<endl;
	return worksum;
}