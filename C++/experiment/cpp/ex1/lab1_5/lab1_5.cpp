#include<iostream>
#include<fstream>
#include<string>
using namespace std;

void  new_line(ifstream& fin,char& temp)
{
	do{
		fin.get(temp);
	}while(isspace(temp));

}
int main(int argc,char *argv[])
{
	int num[20],num2[10],n,num_line=1;
	char temp;
	if(argc!=2)
	{
		argv[0]="a.bin";
		argv[1]="b.bin";
	}
	ifstream in;
	ofstream out;
	out.open(argv[0],ios::binary|ios::out);
	cout<<"写入文件a.bin:";
	for(int i=1,j=1,k=0;i<10000;cout<<i<<"_",num[k]=i,i+=j,j=i-j,k++);
	out.write((char *)num,sizeof(num));
	cout<<endl;
	out.close();
	in.open(argv[0],ios::binary|ios::in);
	in.read((char *)num2,sizeof(num2));
	cout<<"从a.bin读取:";
	for(i=0;i<10;cout<<num2[i]<<'\0',i++);
	in.close();
	string buffer,buffer2;
	out.open(argv[1],ios::binary|ios::out);
	cout<<"\n写入b.bin文件:"<<endl;
	while(getline(cin,buffer)){
		out<<num_line++<<":"<<buffer<<endl;
		//cout<<num_line++<<":"<<buffer;
	}
	out.close();
	in.open(argv[1],ios::binary|ios::in);
	cout<<"\n从b.bin读取:"<<endl;
	while(getline(in,buffer2)){
		cout<<buffer2<<endl;
	}
}
