
#include "CJudge.h"
#include <stdlib.h>
#include <iostream>
#include <vector>
using namespace std;
bool CJudge::IsValid(const CChessBoard& board,const CPiece& piece)
{
 CPoint pos=piece.ReturnPoint();
 if (pos.x<=0 || pos.x>SIZE || pos.y<=0 ||pos.y>SIZE)
 {  
  cout<<"Error! Out of bounds.";
  cout<<endl;
  return false;
 }
 if (0!=board.ReturnPieceAt(pos))
 {
  cout<<"Error! The position has already placed piece";
  cout<<endl;
  return false;
 }
 return true;
}
bool CJudge::IsChangLian(const CChessBoard& board,const CPiece& piece)
{
  
  for (int i=1;i<=4;i++)
  {
        int sum=1; 
        for (int j=0;j<=1;j++)
     {
    CPoint pos=piece.ReturnPoint();
          int direction=i+j*4;
    while(1) //出界或搜索到界外时退出
    {
     switch(direction)
     {
      case 1 :
      pos.x++;
      break;
     case 2:
         pos.x++;
         pos.y--;
      break;
     case 3:
      pos.y--;
      break;
     case 4:
      pos.x--;
      pos.y--;
      break;
      case 5:
      pos.x--;
      break;
     case 6:
      pos.x--;
      pos.y++;
      break;
        case 7:
      pos.y++;
      break;
     case 8:
      pos.x++;
      pos.y++;
         break;
        default:
      break;
     }
      if (pos.x<1 || pos.y<1 || pos.x>SIZE || pos.y>SIZE)
       {
       break;             //出界退出循环
      } 
     if (piece.ReturnColor()==board.ReturnPieceAt(pos))
     {
         sum++;             //同色子数目相加
     }
        else
         break; 
    }//while结束
   }
   if (sum>5)
   {
    return true;
   }
  }
  return false;
}
void CJudge::ComputeChessModel(const CChessBoard& board,const CPiece& piece,int (*p)[2])
{
         int (*chessmodel)[2]=p;   //4个2维数组，第一个代表方向,每个二维数组存放棋子数，活棋死棋
   for (int i=0;i<4;i++)
   {
    p[i][0]=0;
    p[i][1]=0;
   }
  
   
  for(i=1;i<=4;i++)
  {  
   CPoint current=piece.ReturnPoint();
 
   CPoint left=current;
   CPoint right=current;   
   CPoint directiondelta(0,0);
   switch(i)
   {
   case 1:
    directiondelta.x=1;
    break;
   case 2:
    directiondelta.y=1;
    break;
   case 3:
    directiondelta.x=1;
    directiondelta.y=1;
    break;
   case 4:
    directiondelta.x=1;
    directiondelta.y=-1;
   default:
    break;
   }
   
   
   for (int j=1;j<=4;j++)
   {
    int a=left.x-directiondelta.x;
    int b=left.y-directiondelta.y;
    if (a<1 || b<1 || a>SIZE || b>SIZE || white==board.ReturnPieceAt(CPoint(a,b)))  //出界或碰到白子，则退出
     break;
    left.x=a;
    left.y=b;
   }
            for (j=1;j<=4;j++)
   {
    int a=right.x+directiondelta.x;
    int b=right.y+directiondelta.y;
    if (a<1 || b<1 || a>SIZE || b>SIZE || white==board.ReturnPieceAt(CPoint(a,b)))  //出界或碰到白子，则退出
     break;
    right.x=a;
    right.y=b;
   }
   
           
   int distance;
   distance=__max(abs(right.x-left.x),abs(right.y-left.y));
   if (distance<4)
    continue;
   
            vector<int> sumlist;       //存放黑子数
   for (j=0;j<=distance-4;j++)           //检测次数为distance-4
   {
    
    int sum=0;
    for (int k=0;k<=4;k++)
    {
     CPoint temp;
     
     temp.x=left.x+(k+j)*directiondelta.x;
     temp.y=left.y+(k+j)*directiondelta.y;
     if (black==board.ReturnPieceAt(temp))
     {
      sum++;                 //检测这一行的黑子数
     }
     
    }
    sumlist.push_back(sum);
   }//这个方向所有的五环包的棋子数
    
    int max=sumlist[0];               //记录sumlist中的最大值
    
    for (int k=0;k<sumlist.size();k++)
    {
     max=__max(max,sumlist[k]);
    }
                int number=0;                     //记录最大值的个数
    for (k=0;k<sumlist.size();k++)
    {
     if (sumlist[k]==max)
     {
      number++;
     }
     
    }

    chessmodel[i-1][0]=max;
    chessmodel[i-1][1]=number;    
  
  }//4个方向都扫描完  
}
bool CJudge::IsForbidden(const CChessBoard& board,const CPiece& piece)
{
   
 if (white==piece.ReturnColor())
 {
  return false;  
 }
 
 else
 {
     if (IsChangLian(board,piece))
   return true;                        //长连返回禁手
  int chessmodelarray[4][2];
  ComputeChessModel(board,piece,chessmodelarray);
  int three=0;     //活三的个数
  int four=0;      //冲四，活四的个数
  int five=0;      //五连的个数
  
  for (int i=0;i<4;i++)
  {
   if (chessmodelarray[i][0]==3)
   {
    if (chessmodelarray[i][1]>1)    
     three++;    
   }
   if (chessmodelarray[i][0]==4)
   {
    if (chessmodelarray[i][1]>=1)    
     four++;    
   }
   if (chessmodelarray[i][0]==5)
   {
    five++;    
   }

  }
  if (three==2 && five==0)
  return true;
  if (four==2 && five==0)
  return true;
 }
 return false;
}
bool CJudge::IsWin(const CChessBoard& board,const CPiece& piece)
{
 
for (int i=1;i<=4;i++)
{
 int sum=1; 
 for (int j=0;j<=1;j++)
 {
  CPoint pos=piece.ReturnPoint();
  int direction=i+j*4;
  while(1) //出界或搜索到界外时退出
  {
   switch(direction)
   {
       case 1 :
       pos.x++;
       break;
      case 2:
       pos.x++;
       pos.y--;
       break;
      case 3:
       pos.y--;
       break;
      case 4:
       pos.x--;
       pos.y--;
       break;
         case 5:
       pos.x--;
       break;
       case 6:
       pos.x--;
       pos.y++;
       break;
      case 7:
       pos.y++;
       break;
      case 8:
       pos.x++;
       pos.y++;
       break;
      default:
       break;
   }
        if (pos.x<1 || pos.y<1 || pos.x>SIZE || pos.y>SIZE)
     {
       break;             //出界退出循环
     }
      if (piece.ReturnColor()==board.ReturnPieceAt(pos))
   {
       sum++;             //同色子数目相加
   }
      else
       break; 
  }//while结束
  
 }
 if (sum>=5)
 {
  return true;
 }
}
return false;
}