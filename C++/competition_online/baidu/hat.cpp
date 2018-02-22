#include<iostream>
#define MAX 1000
using namespace std;

int main()
{
	int n;//total num
	int p;//temporary number for input
	int a=MAX;//least number
	int b=MAX;//2-th least number
	int c=MAX;//3-th least number
	cin>>n;
	for(int i=0;i<n;i++)
	{
		cin>>p;
		if (p==a||p==b||p==c)
		{
			continue;
		}else if (p<a)
		{
			c=b;
			b=a;
			a=p;
		}else if (p<b)
		{
			c=b;
			b=p;
		}else if (p<c)
		{
			c=p;
		}
	}

	if(c==MAX)
	{
		cout<<-1;
	}else
	{
		cout<<c;
	}
}

/*e.g.
input:
10
10 10 10 10 20 20 30 30 40 40

output:
30
*/