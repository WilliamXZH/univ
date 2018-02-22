#include "iostream"
#include "string"
using namespace std;
class Person
{
private:
	char *name;
	int id;
public:
	Person(char *pname)
	{
		
		cout<<strlen(pname)<<endl;
	}
	
};
void main()
{
	Person *p;
	p=new Person("");
	delete p;
}