#include <iostream>
#include <string>
#include <windows.h>
using namespace std;
const int max_user=10;
const int max_file=10;
const int max_open_file=5;

class UFD
{
	public:
	string file_name;
	int read;     
	int write;     
	int execute;     
	int  longer;

};
class MFD
{
	public:
	string user_name;
	UFD * file_point;
};
class AFD
{
	public:
	string open_file_name;
	int read;     
	int write;     
	int execute;
	istream *in;
	ostream *ou;
};

AFD afd[max_open_file];
int Create(MFD &user)
{
	int i=0;
	cout<<"建立文件处理程序"<<endl;
	UFD create_file;
	cout<<"输入要建立的文件名"<<endl;
	cin>>create_file.file_name;
	UFD *find_file=user.file_point;

	for(i=0;i<max_file;i++)
	{
		if(find_file[i].longer==-1)
			break;
	}
	if(i==max_file)
	{
		cout<<"建立失败，该用户下文件数已满"<<endl;
	}
	for(i=0;i<max_file;i++)
	{
		if(find_file[i].file_name==create_file.file_name)
		{
			cout<<"建立失败，该文件名已存在"<<endl;
			return 0;
		}
	}

	if(i==max_file)
	{
		cout<<"输入文件大小"<<endl;
		cin>>create_file.longer;
		cout<<"输入文件可读性（1或0）"<<endl;
		cin>>create_file.read;
		cout<<"输入文件可写性（1或0）"<<endl;
		cin>>create_file.write;
		cout<<"输入文件可执行性（1或0）"<<endl;
		cin>>create_file.execute;
		for(i=0;i<max_file;i++)
		{
			if(find_file[i].longer==-1)
			{
				find_file[i]=create_file;
				cout<<"建立成功"<<endl;
				return 1;
			}
		}
	}
	return 0;
}

int delet(MFD &user)
{
	int i;
	UFD *find_file=user.file_point;
	string delete_file_name;
	cout<<"删除文件处理程序"<<endl;
	cout<<"输入要删除的文件名"<<endl;
	cin>>delete_file_name;
	for(i=0;i<max_file;i++)
	{
		if(find_file[i].file_name==delete_file_name)
		{
			
			find_file[i].file_name="";
			find_file[i].execute=0;
			find_file[i].longer=-1;
			find_file[i].read=0;
			find_file[i].write=0;
			cout<<"已成功删除该文件"<<endl;
			return 1;
		}
	}
	if(i==max_file)
	{
		cout<<"找不到该文件"<<endl;
	}
	return 0;
}
int open(MFD &user)
{
	int i,j;
	UFD *find_file=user.file_point;
	string open_file_name;
	cout<<"打开文件处理程序"<<endl;
	cout<<"输入要打开的文件名"<<endl;
	cin>>open_file_name;
	for(i=0;i<max_file;i++)
	{
		if(find_file[i].file_name==open_file_name)
		{
			cout<<"找到该文件"<<endl;
			Sleep(1000);
			for(j=0;j<max_open_file;j++)
			{
				if(afd[j].open_file_name=="")
				{
					afd[j].open_file_name=find_file[i].file_name;
					afd[j].execute=find_file[i].execute;
					afd[j].read=find_file[i].read;
					afd[j].write=find_file[i].write;
					cout<<"打开成功"<<endl;
					return 1;
				}
			}
			if(j==max_open_file)
			{
				cout<<"打开失败，超出可打开文件数限制"<<endl;
				return 0;
			}
			
		}
	}
	if(i==max_file)
	{
		cout<<"找不到该文件"<<endl;
	}
	return 0;
}
int close()
{
	int i;
	string close_file_name;
	cout<<"关闭文件处理程序"<<endl;
	cout<<"输入要关闭的文件名"<<endl;
	cin>>close_file_name;
	for(i=0;i<max_open_file;i++)
	{
		if(afd[i].open_file_name==close_file_name)
		{
			cout<<"找到该文件"<<endl;
			Sleep(1000);
			afd[i].open_file_name="";
			afd[i].execute=0;
			afd[i].read=0;
			afd[i].write=0;
			cout<<"关闭成功"<<endl;
			return 1;
		}
	}
	if(i==max_open_file)
	{
		cout<<"找不到该文件"<<endl;
	}
	return 0;
}


int main()
{
	int i=0,j=0;
	MFD mfd[max_user];
	UFD ufd[max_user*max_file];
	mfd[0].user_name="aaa";
	mfd[0].file_point=&ufd[0];
	string command;
	for( i=0;i<max_file;i++)
	{
		ufd[i].execute=0;
		ufd[i].file_name="";
		ufd[i].longer=-1;
		ufd[i].read=0;
		ufd[i].write=0;
	}

	ufd[0].file_name="aaa1.txt";
	ufd[0].longer=30;
	ufd[0].execute=1;
	ufd[0].read=1;
	ufd[0].write=1;
	ufd[1].file_name="aaa2.txt";
	ufd[1].longer=50;
	ufd[1].execute=1;
	ufd[1].read=1;
	ufd[1].write=1;
	/*for( i=0;i<10;i++)
	{
		if(u[i].longer==-1)
			break;
		cout<<u[i].file_name<<endl;
	}*/



	string username="";
	cout<<"输入用户名：";
	cin>>username;
	for(i=0;i<max_user;i++)
	{
		if(username==mfd[i].user_name)
			break;
	}
	if(i==max_user)
	{
		cout<<"无此用户"<<endl;
		return 0;
	}
	MFD user=mfd[i];
	UFD *file=user.file_point;
	cout<<"用户"<<user.user_name<<"目录表UFD中所有的文件："<<endl;
	for( i=0;i<10;i++)
	{
		if(file[i].longer!=-1)
			cout<<file[i].file_name<<endl;
	}
	/*for(i=0;i<max_user;i++)
	{
		if(mfd[i].user_name==user.user_name)
		{
			for(j=0;j<max_open_file;j++)
			{
				afd[j].open_file_name="";
				afd[j].read=0;
				afd[j].write=0;
				afd[j].execute=0;
			}
		}
	}*/
			for(j=0;j<max_open_file;j++)
			{
				afd[j].open_file_name="";
				afd[j].read=0;
				afd[j].write=0;
				afd[j].execute=0;
			}
	cout<<"已经初始化运行文件表"<<endl;
	while(true)
	{
		cout<<"输入操作命令"<<endl;
		cin>>command;
		if(command=="create")
		{
			Create(user);
		}
		if(command=="delete")
		{
			delet(user);
		}
		if(command=="open")
		{
			open(user);
		}
		if(command=="close")
		{
			close();
		}
		if(command=="byo")
		{
			break;
		}
	}
	for( i=0;i<10;i++)
	{
		if(file[i].longer!=-1)
			cout<<file[i].file_name<<endl;
	}
	cout<<"open 的文件"<<endl;
	/*for( i=0;i<max_open_file;i++)
	{
		if(afd[i].open_file_name!="")
			cout<<afd[i].open_file_name<<endl;
	}*/
	return 0;

}