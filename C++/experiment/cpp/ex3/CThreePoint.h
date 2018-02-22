#include"../ex2/CPoint.h"
class CThreePoint:public CPoint
{
	private:
		int z;
	public:
		CThreePoint();
		CThreePoint(int,int,int);
		CThreePoint(CThreePoint &);
		~CThreePoint();
		int GetZ();
		void SetZ(int pz);
		void ShowPoint();
};
CThreePoint::CThreePoint(){SetX(0);SetY(0);SetZ(0);cout<<"<"<<GetX()<<","<<GetY()<<","<<GetZ()<<">"<<"CThreePoint Construct!"<<endl;}
CThreePoint::CThreePoint(int px,int py,int pz){SetX(px);SetY(py);SetZ(pz);cout<<"<"<<GetX()<<","<<GetY()<<","<<GetZ()<<">"<<"CThreePoint Construct!"<<endl;}
CThreePoint::CThreePoint(CThreePoint &p){SetX(p.GetX());SetY(p.GetY());SetZ(p.GetZ());}
CThreePoint::~CThreePoint(){cout<<"<"<<GetX()<<","<<GetY()<<","<<GetZ()<<">"<<"CThreePoint Destruct."<<endl;}
int CThreePoint::GetZ(){return z;}
void CThreePoint::SetZ(int pz){z=pz;}
void CThreePoint::ShowPoint(){cout<<"<"<<GetX()<<","<<GetY()<<","<<GetZ()<<">"<<endl;}