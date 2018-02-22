#include<iostream>
using namespace std;
class CPoint;
istream& operator >>(istream& cin,CPoint& p);
ostream& operator  <<(ostream& cout,CPoint& p);
class CPoint
{
	private:
		int x,y;
		static int nCount;
	public:
		CPoint();
		CPoint(int px,int py);
		CPoint(CPoint& p);
		~CPoint();
		CPoint operator+(CPoint pt);
		int GetX();
		int GetY();
		void SetX(int px);
		void SetY(int py);
		virtual void ShowPoint();
		friend istream& operator >>(istream& cin,CPoint& p);
		friend ostream& operator  <<(ostream& cout,CPoint& p);
};
int CPoint::nCount=0;
CPoint::CPoint(){x=0,y=0;nCount++;cout<<nCount<<"("<<x<<","<<y<<")"<<" CPoint Contructed"<<endl;}
CPoint::CPoint(int px,int py){x=px;y=py;nCount++;cout<<nCount<<"("<<x<<","<<y<<")"<<" CPoint Contructed"<<endl;}
CPoint::CPoint(CPoint& p){x=p.x;y=p.y;nCount++;cout<<nCount<<"("<<x<<","<<y<<")"<<" CPoint Contructed"<<endl;}
CPoint::~CPoint(){cout<<nCount<<"("<<x<<","<<y<<")"<<" CPoint Destructed"<<endl;nCount--;}
int CPoint::GetX(){return x;}
int CPoint::GetY(){return y;}
void CPoint::SetX(int px){x=px;}
void CPoint::SetY(int py){y=py;}
void CPoint::ShowPoint(){cout<<"("<<x<<","<<y<<")"<<endl;}
CPoint CPoint::operator+(CPoint pt){return CPoint(x+pt.x,y+pt.y);}
CPoint operator - (CPoint &pt1,CPoint &pt2){return CPoint(pt1.GetX()-pt2.GetX(),pt1.GetY()-pt2.GetY());}
istream&  operator >>(istream& cin,CPoint& p){cin>>p.x>>p.y;return cin;}
ostream& operator <<(ostream& cout,CPoint& p){cout<<"<"<<p.x<<","<<p.y<<">"<<endl;return cout;}