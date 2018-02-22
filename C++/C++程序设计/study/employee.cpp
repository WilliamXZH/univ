#include<iostream>
#include<cstring>
#include "employee.h"
using namespace std;

int employee::employeeNo=1000;

employee::employee()
{
	individualEmpNo=employeeNo++;
	grade=1;
	accumPay=0.0;
}
employee::~employee(){}
void employee::pay(){}

void employee::promote(int increment)
{
	accumPay=increment;
}
void employee::SetName(char *names)
{
	strcpy(name,names);
}
char *employee::GetName()
{
	return name;
}
void employee::SetaccumPay(float pa)
{
	accumPay=pa;
}
int employee::GetindividualEmpNo()
{
	return individualEmpNo;
}
int employee::Getgrade()
{
	return grade;
}
float employee::GetaccumPay()
{
	return accumPay;
}
technician::technician()
{
	hourlyRate=100;
}
void technician::SetworkHours(int wh)
{
	workHours=wh;
}
void technician::pay()
{
	accumPay=hourlyRate*workHours;
}
salesman::salesman()
{
	CommRate=0.04;
}
void salesman::Setsales(float sl)
{
	sales=sl;
}
void salesman::pay()
{
	accumPay=sales*CommRate;
}
manager::manager()
{
	monthlyPay=8000;
}
void manager::pay()
{
	accumPay=monthlyPay;
}
salesmanager::salesmanager()
{
	monthlyPay=5000;
	CommRate=0.005;
}
void salesmanager::pay()
{
	accumPay=monthlyPay+CommRate*sales;
}

