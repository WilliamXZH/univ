#include<iostream>
using namespace std;

int main()
{
	int b;
	while(cin>>b)
	{
		for (int x=2;x<b;x++)
		{
			if((b - 1) % x==0)
			{
				break;
			}
		}

		for(int y = 2; y<b; y++)
		{
			if((b+1) % y ==0)
			{
				break;
			}
		}
		cout<<x<<" "<<y<<endl;
	}
}

//50%