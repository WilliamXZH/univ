#include"Shape.h"
int main(){
	Shape a,b(a),c(Blue);
	a.draw(),b.draw(),c.draw();
	cout<<endl;
	Cline d,e(10,c.GetColor());
	d.draw(),e.draw();
	cout<<endl;
	CRectangle f;
	f.draw();
	cout<<endl;
	CCircle g;
	g.draw();
	cout<<endl;
}