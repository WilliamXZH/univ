#ifndef CPoint_H_H_H_
#define CPoint_H_H_H_
class CPoint
{
public:
 CPoint();
 CPoint(int a,int b);
 void SetPoint(int a,int b);
 void operator=(const CPoint& p);
 bool operator==(const CPoint& p);
 int x;
 int y;
};
#endif