#include"CThreePoint.h"
main(){
	CThreePoint A(1,2,3),B;
	CPoint *p;
	cout<<"A.ShowPoint():";A.ShowPoint();
	cout<<"B.ShowPoint():";B.ShowPoint();
	cout<<endl;
	p=&A;p->ShowPoint();
	p=&B;p->ShowPoint();
	cout<<endl;
}