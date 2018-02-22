
#include "CPoint.h"
CPoint::CPoint()
{
}
CPoint::CPoint(int a,int b)
{
 x=a;
 y=b;
}
void CPoint::SetPoint(int a,int b)
{
 x=a;
 y=b;
}
void CPoint::operator=(const CPoint& p)
{
 x=p.x;
 y=p.y;
}
bool CPoint::operator ==(const CPoint& p)
{
 if (x==p.x && y==p.y)
 return true;
 else
 return false;
}
 