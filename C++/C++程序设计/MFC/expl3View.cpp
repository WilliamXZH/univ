#include<fstream>
#include<string>
#include<vector>
//#include"../expdlg.h"
#include"../employee.h"
using namespace std;
void CExp13View::OnInputData()
{
	//TODO:Add your command handler code here
	manager m1;
	technician t1;
	salesmanager sm1;
	salesman s1;

	vector <employee *>vchar;
	vchar.push_back(&m1);
	vchar.push_back(&t1);
	vchar.push_back(&sm1);
	vchar.push_back(&s1);

	expdlg ed;
	ed.DoModal();

	vector<CString> vread;
	vread.push_back(ed.m_str1);
	vread.push_back(ed.m_str2);
	vread.push_back(ed.m_str3);
	vread.push_back(ed.m_str4);

	int i;
	for(i=0;i<4;i++)
	{
		vchar[i]->SetName((char*)(LPCTSTR)vread[i]);
		vchar[i]->promote(i);
	}

	t1.SetworkHours(ed.m_hours);
	
	sm1.Setsales(ed.m_ssl);

	s1.Setsales(ed.m_ss2);

	ofstream ofile("employee.txt",ios::out);
	for(i=0;i<4;i++)
	{
		vchar[i]->pay();
		ofile<<vchar[i]->GetName()<<"编号"<<vchar[i]->GetindividualEmpNo()
			<<"级别为"<<vchar[i]->Getgrade()<<"级，本月工资"
			<<vchar[i]->GetaccumPay()<<endl;
	}
	ofile.close();
}
class FileException
{
	public:
		FileException():message("File is not created!"){}
		const char *what() const{return message;}
	private:
		const char *message;
};

void CExp13View::OnOutputData()
{
	ifstream infile("employee.txt",ios::in);
	try{
		if(!infile)throw FileException():
	}catch(FileException fe){
		//exception handler
		MessageBox(fw.what());//<<fe.what()<<'\n';	
		exit(0);
	}
	//从文件读入人员信息
	CClientDC dc(this);
	char line[101];
	for(int i=0;i<4;i++)
	{
		infile.getline(line,100);
		CString c_str;
		c_str.Format("%s",line);
		dc.TextOut(100,80,"人员信息管理系统");
		dc.TextOut(100,100+30*i,c_str);
	}
	infile.close();
}
