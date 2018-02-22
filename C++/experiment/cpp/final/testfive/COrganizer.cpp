
#include "CManager.cpp"
#include<iostream>
#include <string>
#include <cctype>
using namespace std;
void COrganizer::DecideGameMode(CShow &show)
{
 do {
  show.ShowChoseGameMode();
     cin>>mode; 
 } while(mode!=1 && mode!=2);
}
int COrganizer::ReturnMode()
{
 return mode;
}
string COrganizer::ReturnPlayer1Name()
{
 return player1name;
}
string COrganizer::ReturnPlayer2Name()
{
 return player2name;
}
void COrganizer::DecideWhoGoFirst(CPlayer& p1,CPlayer& p2)
{   
 if (1==mode)
 {
  p1.SetName("Player1");
  p2.SetName("Player2");
 }
 else
 {
  p1.SetName("Human");
  p2.SetName("Computer");
 }
 do {
 cout<<endl;
 cout<<"Player List :";
 cout<<p1.ReturnName()<<" , "<<p2.ReturnName();
 cout<<endl;
 cout<<p1.ReturnName()<<" go first( 1)";
 cout<<endl;
 cout<<p2.ReturnName()<<" go first( 2)";
 cout<<endl;
 cout<<"Please decide who go first ( 1 or 2) : ";
 cin>>flagturn; 
 } while(flagturn!=1 && flagturn!=2);
 if (1==flagturn)
 {
  p1.SetColor(black);
  p2.SetColor(white);
 }
 else
 {
  p1.SetColor(white);
  p2.SetColor(black);
 }
}
int COrganizer::ReturnFlagTurn()
{
 return flagturn;
}

CPoint COrganizer::GetInputPosition()
{
 string str;
 cin>>str;         //从屏幕中读取字符串
 int x=0,y=0;
    if (str.at(0)>=48 && str.at(0)<=57)         //输入棋子坐标时数字在前面，字母在后面的情况
 {
  if (2==str.length())
  {   
   x=int(toupper(str.at(1)))-64;
   y=int(str.at(0))-48;
      return CPoint(x,y);
  }
     else
  {
   x=int(toupper(str.at(2)))-64;
      y=int(str.at(0))-48;
   y=y*10+int(str.at(1))-48;
      return CPoint(x,y);
  }

 }
 else                                       //输入棋子坐标时字母在前面，数字在后面的情况
 {
   if (2==str.length())
  {   
   x=int(toupper(str.at(0)))-64;
   y=int(str.at(1))-48;    
      return CPoint(x,y);
  }
     else
  {
   x=int(toupper(str.at(0)))-64;
      y=int(str.at(1))-48;
   y=y*10+int(str.at(2))-48;
      return CPoint(x,y);
  }

 }
}
void COrganizer::ExchangeFlag()
{
 if (1==flagturn)
 {
  flagturn=2;
 }
 else
 {
  flagturn=1;
 }
}
char COrganizer::GetIsContinueResult()
{
 char choice;
 cin>>choice;
 choice=toupper(choice);
 return choice;
}
 

//CPiece.cpp文件
#include "CPiece.h"
void CPiece::SetColor(int col)
{
 color=col;
 if (1==color)
 {
  shape="●";
 }
 else if (2==color)
 {
  shape="◎";
 };
}
void CPiece::SetPosition(const CPoint& p)
{
 point=p;
}
int CPiece::ReturnColor() const
{
 return color;
}
CPoint CPiece::ReturnPoint() const
{
 return point;
 
}
string CPiece::ReturnShape()
{
 return shape;
}