#include"CPoint.h"
#include<cmath>

class CLine{
	private:
		CPoint pt1,pt2;
	public:
		CLine();
		CLine(int x1,int y1,int x2,int y2);
		CLine(CPoint p1,CPoint p2);
		~CLine();
		double Distance();
		void ShowLine();
};
CLine::CLine():pt1(),pt2(){
	cout<<"CLine's Constructor is played"<<endl;
	ShowLine();
}
CLine::CLine(int x1,int y1,int x2,int y2):pt1(x1,y1),pt2(x2,y2){
	cout<<"CLine's Constructor is played"<<endl;
	ShowLine();
}
CLine::CLine(CPoint p1,CPoint p2):pt1(p1),pt2(p2){
	cout<<"CLine's Constructor is played"<<endl;
	ShowLine();
}
CLine::~CLine(){
	cout<<"pt1:<"<<pt1.GetX()<<","<<pt1.GetY()<<">,pt2:<"<<pt2.GetX()<<","<<pt2.GetY()<<">"<<"CLine's Destructor is played"<<endl;
}
double CLine::Distance(){
	return sqrt((double)(pt1.GetX()-pt2.GetX())*(pt1.GetX()-pt2.GetX())+(pt1.GetY()-pt2.GetY())*(pt1.GetY()-pt2.GetY()));
}
void CLine::ShowLine(){
	cout<<"pt1:<"<<pt1.GetX()<<","<<pt1.GetY()<<">,pt2:<"<<pt2.GetX()<<","<<pt2.GetY()<<">";
	cout<<"Distance:"<<Distance()<<endl;
}