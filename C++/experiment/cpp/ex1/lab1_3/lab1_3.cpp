#include<iostream>
#include<iomanip>
using namespace std;
void trans(int array[3][3])
{
	int temp;
	for(int i=0;i<3;i++)
	{
		for(int j=i;j<3;j++)
		{
			temp=array[i][j];
			array[i][j]=array[j][i];
			array[j][i]=temp;
		}
	}
}
void print(int array[3][3])
{
	for(int i=0;i<3;i++)
	{
		cout<<"|";
		for(int j=0;j<3;j++)
		{
			cout<<setiosflags(ios_base::left)<<setw(4)<<array[i][j];
		}
		cout<<"|"<<endl;
	}
}
void main()
{
	int array[3][3]={1,2,3,4,5,6,7,8,9};
	cout<<"原矩阵为"<<endl;
	print(array);
	trans(array);
	cout<<"转置之后矩阵为"<<endl;
	print(array);
}