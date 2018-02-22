#ifndef CPiece_H_H_H_
#define CPiece_H_H_H_
#include "CPoint.h"
#include <string>
using namespace std;
#define blank 0
#define black 1
#define white 2

class CPiece
{
public:
    void SetColor(int col);
 void SetPosition(const CPoint& p);
 int ReturnColor() const;
 CPoint ReturnPoint() const;
 string ReturnShape();
private:
 int color;
 string shape;
 CPoint point;
};
#endif