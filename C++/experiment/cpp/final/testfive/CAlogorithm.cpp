#include "CAlogorithm.h"
#include <vector>
#include<math.h>
using namespace std;
 
CPoint CAlgorithm::ComputePiecePosition(const CChessBoard& board,const CPlayer& player,CJudge& judge)
{
 CChessBoard boardtemp;
 boardtemp=board;      //重新存放一张棋盘表
 int myvalue[SIZE+1][SIZE+1];
 int opponentvalue[SIZE+1][SIZE+1];
   
 int col=0;
 int row=0;
 for (col=0;col<=SIZE;col++)
 {
  for (row=0;row<=SIZE;row++ )
  {
   myvalue[col][row]=-2;
   opponentvalue[col][row]=-2;
  }
 }
    int mycolor=player.ReturnColor();
    int opponentcolor=0;        //存放异子颜色
 if (black==mycolor)
 {
  opponentcolor=white;
 }
 else
  opponentcolor=black;
 

 
 
 
 
 int FValue[6][2]={{0,0},{1,4},{16,80},{400,2000},{10000,50000},{100000,100000}};
 int LValue[6][2]={{0,0},{1,4},{8,40},{200,1000},{5000,25000},{50000,50000}};
    CPoint temp;
 CPiece piece;
 for (col=1;col<=SIZE;col++)
 {
  for (row=1;row<=SIZE;row++)
  {  
   temp.SetPoint(col,row);
   if (blank==boardtemp.ReturnPieceAt(temp))    
   { piece.SetColor(mycolor);
    piece.SetPosition(temp);
    boardtemp.PlacePiece(piece);          //先假设在此空位放上自己的棋子
    if (!judge.IsForbidden(boardtemp,piece))    //棋盘该点为空位时
    {     
       int a[4][2];
       judge.ComputeChessModel(boardtemp,piece,a);  
       for (int k=0;k<4;k++)
       {
        
        myvalue[col][row]+=FValue[a[k][0]][a[k][1]];
       }
       piece.SetColor(opponentcolor);
       boardtemp.PlacePiece(piece);           //而后假设在此空位放上了对手的子    
       judge.ComputeChessModel(boardtemp,piece,a);
     
       for (k=0;k<4;k++)
       {
        
        opponentvalue[col][row]+=LValue[a[k][0]][a[k][1]]; 
       }   
    }
    boardtemp.RetractPieceAt(temp);
            }
  }
 }//两个数组跟新完毕！
 int mymax=-2;
 int opponentmax=-2;
 vector<CPoint> mymaxpoint;
 vector<CPoint> opponentmaxpoint;
 mymaxpoint.erase(mymaxpoint.begin(),mymaxpoint.end());
 opponentmaxpoint.erase(opponentmaxpoint.begin(),opponentmaxpoint.end());
  for (col=1;col<=SIZE;col++)
  {
   for (row=1;row<=SIZE;row++)
   {
        mymax=__max(mymax,myvalue[col][row]);  //找出数组中最大值
    
   
   }
  }
  for (col=1;col<=SIZE;col++)
  {
   for (row=1;row<=SIZE;row++)
   {
       if (mymax==myvalue[col][row])
       {
        mymaxpoint.push_back(CPoint(col,row));     //记录最大值的坐标
       }
     
   
   }
  }
  for (col=1;col<=SIZE;col++)
  {
   for (row=1;row<=SIZE;row++)
   {
        opponentmax=__max(opponentmax,opponentvalue[col][row]); //找出数组中最大值
    
   
   }
  }
  for (col=1;col<=SIZE;col++)
  {
   for (row=1;row<=SIZE;row++)
   {
       if (opponentmax==opponentvalue[col][row])
       {
        opponentmaxpoint.push_back(CPoint(col,row));     //记录最大值的坐标
       }
     
   
   }
  }
  
  int x0=(SIZE+1)/2;   //保存中心点位置
  int y0=(SIZE+1)/2;
  int d;              //离中心点最近的点的距离值
  CPoint dpoint;      //保存离中心店最近的点
       if (mymax>=opponentmax)
    {
     d=pow(mymaxpoint[0].x-x0,2)+pow(mymaxpoint[0].y-y0,2);       //选出离中心点最近的点
     dpoint=mymaxpoint[0];
     for(int k=1;k<mymaxpoint.size();k++)
     {
   
      int dtemp=pow(mymaxpoint[k].x-x0,2)+pow(mymaxpoint[k].y-y0,2);
      if (dtemp<=d)
      {
       d=dtemp;    //最小距离跟新
       dpoint=mymaxpoint[k];
      }
     }
     return dpoint;
    }
    else
    {
     d=pow(opponentmaxpoint[0].x-x0,2)+pow(opponentmaxpoint[0].y-y0,2);       //选出离中心点最近的点
     dpoint=opponentmaxpoint[0];
     for(int k=1;k<opponentmaxpoint.size();k++)
     {
   
      int dtemp=pow(opponentmaxpoint[k].x-x0,2)+pow(opponentmaxpoint[k].y-y0,2);
      if (dtemp<=d)
      {   
       d=dtemp;   ////最小距离跟新
       dpoint=opponentmaxpoint[k];
      }
     }
     return dpoint;
    }
  
 
}