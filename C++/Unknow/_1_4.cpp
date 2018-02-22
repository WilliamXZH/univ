#include<iostream>
#include<time.h>
using namespace std;
int main()
{
	clock_t start=clock(),end;
	float (*cp)[9][8];
	int i,j,k;
	cp=new float[8][9][8];
	for(i=0;i<8;i++)
		for(j=0;j<9;j++)
			for(k=0;k<8;k++)
				*(*(*(cp+i)+j)+k)=i*100+j*10+k;
	for(i=0;i<8;i++)
	{
		for(j=0;j<9;j++)
		{
			for(k=0;k<8;k++)
				cout<<cp[i][j][k]<<" ";
			cout<<endl;
		}
		cout<<endl;
	}
	delete[]cp;
	free(cp);
	end=clock();
	cout<<"runtime:"<<(float)(end-start)<<"ms"<<endl;
}