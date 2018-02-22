#include<iostream>
#include<fstream>
using namespace std;
int main()
{
	int n=100;
	char c='y';
	float f=0.76;
	ifstream fin;
	fin.open("data.dat");
	fin>>n>>c>>f;
	cout<<"the input integer is:"<<n<<endl
		<<"the inpput char is:"<<c<<endl
		<<"the input float is:"<<f<<endl;
	fin.close();

	ofstream fout;
	fout.open("data.dat");
	fout<<"the input integer is:"<<n<<endl
		<<"the inpput char is:"<<c<<endl
		<<"the input float is:"<<f<<endl;
	fout.close;
}