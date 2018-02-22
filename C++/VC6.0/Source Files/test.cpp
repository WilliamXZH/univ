#include <iostream>
#include <iomanip>
using namespace std;

class test;
ostream& operator<< (ostream& tout,const test& t);
istream& operator>> (istream& in,test& t);
test operator + (const test& t1,const test& t2);
class test
{
friend ostream& operator<< (ostream& out,const test& t);
friend istream& operator>> (istream& in,test& t);
friend test operator + (const test& t1,const test& t2);
public:
test(int i=0)	//这里最好给个缺省值，因为没另外定义缺省构造函数
{
m_data=i;
}
public:
int m_data;
};
ostream& operator<< (ostream& tout,const test& t)
{
tout<<t.m_data;
return tout;
}
istream& operator>> (istream& in,test& t)
{
in>>t.m_data;
return in;
}
test operator+(const test& t1,const test& t2)
{
test temp;
temp.m_data = t1.m_data + t2.m_data ;
return temp;
}

int main()
{
test t1(10),t2(20);
cout<<"t1="<<t1<<"   t2="<<t2<<endl;
cout<<"t1+t2="<<t1+t2<<endl;
cout<<"pls input a integer(t1=):";
cin>>t1;
cout<<"t1="<<t1<<endl;
return 0;
}