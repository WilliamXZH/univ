#include<iostream>
#include "employee.h"
using namespace std;
int main()
{
	manager m1;
	technician t1;
	salesmanager sm1;
	salesman s1;
	employee *emp[4]={&m1,&t1,&sm1,&s1};

	int i;
	for(int i=0;i<4;i++)
	{
		emp[i]->pay();
		cout<<"���"<<emp[i]->GetindividualEmpNo()<<"���¹���"<<emp[i]->GettaccumPay()<<endl;
	}
}