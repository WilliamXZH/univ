#include <iostream>
#include <fstream>
#include <cstdlib>
#include <iomanip>
#include <string>
using namespace std;

void  new_line(ifstream& fin,char& temp);

int main(int argc,char *argv[])
{
	ifstream fin;
	ofstream fout;

	int num_line=1;
	char temp,inFileName[128];
	string buffer;

	if(argc==1)
	{
		printf("请用格式:SetLineNUm filename\n");
		exit(0);
	}
	else
	{
		strcpy(inFileName,argv[1]);
	}  

	cout<<"正打开输入文件...\n";
	fin.open(inFileName);  
	if(fin.fail())
	{
		cout<<"输入文件打开失败!\n";
		exit(1);
	}	

    cout<<"正打开输出文件...\n";
	fout.open("output.txt");
	if(fout.fail())
	{
		cout<<"输出文件打开失败!\n";
		exit(1);
	}
	do{                               
		new_line(fin,temp);
		getline(fin,buffer);  
		if(buffer.length()>0)
		{
			fout<<setw(3)<<num_line++<<": ";  
			fout<<buffer;
			fout<<endl;
		}

	} while(!fin.eof());

	fin.close(); 
	fout.close();

	cout<<"成功关闭输入输出文件。\n";
	cout<<"程序结束。\n";

	return 0;
} 

void  new_line(ifstream& fin,char& temp) 
{   
	do{                                            
		fin.get(temp);
	}while(isspace(temp)); 

}