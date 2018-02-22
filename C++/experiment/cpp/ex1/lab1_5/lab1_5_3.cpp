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
		printf("���ø�ʽ:SetLineNUm filename\n");
		exit(0);
	}
	else
	{
		strcpy(inFileName,argv[1]);
	}  

	cout<<"���������ļ�...\n";
	fin.open(inFileName);  
	if(fin.fail())
	{
		cout<<"�����ļ���ʧ��!\n";
		exit(1);
	}	

    cout<<"��������ļ�...\n";
	fout.open("output.txt");
	if(fout.fail())
	{
		cout<<"����ļ���ʧ��!\n";
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

	cout<<"�ɹ��ر���������ļ���\n";
	cout<<"���������\n";

	return 0;
} 

void  new_line(ifstream& fin,char& temp) 
{   
	do{                                            
		fin.get(temp);
	}while(isspace(temp)); 

}