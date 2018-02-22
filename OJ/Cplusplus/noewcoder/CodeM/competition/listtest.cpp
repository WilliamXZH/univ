#include "list.h"

int main()
{
	list<int> l;
	for(int i=0;i<10;i++){
		if(l.add(i)){
			cout<<"add "<<i<<" into list"<<endl;
		}
	}
	l.print();
	if(l.remove(5)){
		cout<<"remove "<<5<<" from list"<<endl;
	}
	l.print();
	cout<<endl<<endl;
	l.printptr();

}