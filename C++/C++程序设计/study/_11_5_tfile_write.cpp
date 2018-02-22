#include<iostream>
#include<fstream>
using namespace std;
struct Data
{
	int mo,da,yr;
};
int main()
{
	Data dt={6,10,92};
	ofstream tfile("date.dat",ios_base::binary);
	tfile.write((char *)&dt,sizeof dt);
	cout<<sizeof dt<<endl;
	tfile.close();
}