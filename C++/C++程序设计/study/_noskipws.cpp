#include<iostream>
#include<fstream>
using namespace std;
int main()
{
	ifstream inf;
	inf.open("input.txt");
	ofstream outf;
	outf.open("output.txt");

	char c;
	inf>>noskipws;
	int i=1;
	outf<<i<<" ";
	cout<<i<<" ";
	while(inf>>c)
	{
		if(c=='\n')
		{
			i++;
			outf<<"\n";
			cout<<"\n";
			outf<<i<<' ';
			cout<<i<<' ';
		}
		else{
			outf<<c;
			cout<<c;

		}
		inf.close();
		outf.close();

	}
}