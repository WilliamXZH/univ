#include<iostream>
#include "employee.cpp"
using namespace std;
int main()
{
	employee m1;
	employee t1;
	employee sm1;
	employee s1;

	cout<<"请输入下一个雇员的月薪:";
	float pa;
	cin>>pa;
	m1.promote(3);
	m1.SetaccumPay(pa);

	cout<<"请输入下一个雇员的月薪:";
	cin>>pa;
	t1.promote(2);
	t1.SetaccumPay(pa);

	cout<<"请输入下一个雇员的月薪:";
	cin>>pa;
	sm1.promote(2);
	sm1.SetaccumPay(pa);

	cout<<"请输入下一个雇员的月薪:";
	cin>>pa;
	s1.SetaccumPay(pa);
	
	cout<<"编号"<<m1.GetindividualEmpNo()<<"级别为"<<m1.Getgrade()<<"级，本月工资"<<m1.GetaccumPay()<<endl;
	cout<<"编号"<<t1.GetindividualEmpNo()<<"级别为"<<t1.Getgrade()<<"级，本月工资"<<t1.GetaccumPay()<<endl;
	cout<<"编号"<<sm1.GetindividualEmpNo()<<"级别为"<<sm1.Getgrade()<<"级，本月工资"<<sm1.GetaccumPay()<<endl;
	cout<<"编号"<<s1.GetindividualEmpNo()<<"级别为"<<s1.Getgrade()<<"级，本月工资"<<s1.GetaccumPay()<<endl;
	return 0;
}