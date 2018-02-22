#include<iostream>
using namespace std;

int main()
{
	int n;
	cin>>n;
	for (int i = 0; i<n; i++)
	{
		char p[100]={'\0'};
		cin>>p;
		for(int j = 0; p[j] != '\0'; j++)
		{
			if( p[j]=='+')
			{
				cout<<"/\\";
			}else if ( p[j] == '-')
			{
				cout<<"__";
			}else if ( p[j] == '_')
			{
				cout<<'-';
				j++;
			}else if ( p[j] == '/')
			{
				cout<<'+';
				j++;
			}
		}
		if ( i != n-1)
		{
			cout<<'\n';
		}
	}
}

//10%