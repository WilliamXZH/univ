#include<iostream>
#include "employee.cpp"
using namespace std;
int main()
{
	employee m1;
	employee t1;
	employee sm1;
	employee s1;

	cout<<"��������һ����Ա����н:";
	float pa;
	cin>>pa;
	m1.promote(3);
	m1.SetaccumPay(pa);

	cout<<"��������һ����Ա����н:";
	cin>>pa;
	t1.promote(2);
	t1.SetaccumPay(pa);

	cout<<"��������һ����Ա����н:";
	cin>>pa;
	sm1.promote(2);
	sm1.SetaccumPay(pa);

	cout<<"��������һ����Ա����н:";
	cin>>pa;
	s1.SetaccumPay(pa);
	
	cout<<"���"<<m1.GetindividualEmpNo()<<"����Ϊ"<<m1.Getgrade()<<"�������¹���"<<m1.GetaccumPay()<<endl;
	cout<<"���"<<t1.GetindividualEmpNo()<<"����Ϊ"<<t1.Getgrade()<<"�������¹���"<<t1.GetaccumPay()<<endl;
	cout<<"���"<<sm1.GetindividualEmpNo()<<"����Ϊ"<<sm1.Getgrade()<<"�������¹���"<<sm1.GetaccumPay()<<endl;
	cout<<"���"<<s1.GetindividualEmpNo()<<"����Ϊ"<<s1.Getgrade()<<"�������¹���"<<s1.GetaccumPay()<<endl;
	return 0;
}