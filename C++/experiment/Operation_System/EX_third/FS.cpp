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
	cout<<"�����ļ��������"<<endl;
	UFD create_file;
	cout<<"����Ҫ�������ļ���"<<endl;
	cin>>create_file.file_name;
	UFD *find_file=user.file_point;

	for(i=0;i<max_file;i++)
	{
		if(find_file[i].longer==-1)
			break;
	}
	if(i==max_file)
	{
		cout<<"����ʧ�ܣ����û����ļ�������"<<endl;
	}
	for(i=0;i<max_file;i++)
	{
		if(find_file[i].file_name==create_file.file_name)
		{
			cout<<"����ʧ�ܣ����ļ����Ѵ���"<<endl;
			return 0;
		}
	}

	if(i==max_file)
	{
		cout<<"�����ļ���С"<<endl;
		cin>>create_file.longer;
		cout<<"�����ļ��ɶ��ԣ�1��0��"<<endl;
		cin>>create_file.read;
		cout<<"�����ļ���д�ԣ�1��0��"<<endl;
		cin>>create_file.write;
		cout<<"�����ļ���ִ���ԣ�1��0��"<<endl;
		cin>>create_file.execute;
		for(i=0;i<max_file;i++)
		{
			if(find_file[i].longer==-1)
			{
				find_file[i]=create_file;
				cout<<"�����ɹ�"<<endl;
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
	cout<<"ɾ���ļ��������"<<endl;
	cout<<"����Ҫɾ�����ļ���"<<endl;
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
			cout<<"�ѳɹ�ɾ�����ļ�"<<endl;
			return 1;
		}
	}
	if(i==max_file)
	{
		cout<<"�Ҳ������ļ�"<<endl;
	}
	return 0;
}
int open(MFD &user)
{
	int i,j;
	UFD *find_file=user.file_point;
	string open_file_name;
	cout<<"���ļ��������"<<endl;
	cout<<"����Ҫ�򿪵��ļ���"<<endl;
	cin>>open_file_name;
	for(i=0;i<max_file;i++)
	{
		if(find_file[i].file_name==open_file_name)
		{
			cout<<"�ҵ����ļ�"<<endl;
			Sleep(1000);
			for(j=0;j<max_open_file;j++)
			{
				if(afd[j].open_file_name=="")
				{
					afd[j].open_file_name=find_file[i].file_name;
					afd[j].execute=find_file[i].execute;
					afd[j].read=find_file[i].read;
					afd[j].write=find_file[i].write;
					cout<<"�򿪳ɹ�"<<endl;
					return 1;
				}
			}
			if(j==max_open_file)
			{
				cout<<"��ʧ�ܣ������ɴ��ļ�������"<<endl;
				return 0;
			}
			
		}
	}
	if(i==max_file)
	{
		cout<<"�Ҳ������ļ�"<<endl;
	}
	return 0;
}
int close()
{
	int i;
	string close_file_name;
	cout<<"�ر��ļ��������"<<endl;
	cout<<"����Ҫ�رյ��ļ���"<<endl;
	cin>>close_file_name;
	for(i=0;i<max_open_file;i++)
	{
		if(afd[i].open_file_name==close_file_name)
		{
			cout<<"�ҵ����ļ�"<<endl;
			Sleep(1000);
			afd[i].open_file_name="";
			afd[i].execute=0;
			afd[i].read=0;
			afd[i].write=0;
			cout<<"�رճɹ�"<<endl;
			return 1;
		}
	}
	if(i==max_open_file)
	{
		cout<<"�Ҳ������ļ�"<<endl;
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
	cout<<"�����û�����";
	cin>>username;
	for(i=0;i<max_user;i++)
	{
		if(username==mfd[i].user_name)
			break;
	}
	if(i==max_user)
	{
		cout<<"�޴��û�"<<endl;
		return 0;
	}
	MFD user=mfd[i];
	UFD *file=user.file_point;
	cout<<"�û�"<<user.user_name<<"Ŀ¼��UFD�����е��ļ���"<<endl;
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
	cout<<"�Ѿ���ʼ�������ļ���"<<endl;
	while(true)
	{
		cout<<"�����������"<<endl;
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
	cout<<"open ���ļ�"<<endl;
	/*for( i=0;i<max_open_file;i++)
	{
		if(afd[i].open_file_name!="")
			cout<<afd[i].open_file_name<<endl;
	}*/
	return 0;

}