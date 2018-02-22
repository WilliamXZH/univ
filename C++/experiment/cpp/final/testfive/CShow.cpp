
#include "CShow.h"

#include <iostream>
using namespace std;


void CShow::Welcome()
{  
 system("cls");   //清屏
 cout<<endl;
 cout<<"  ==Welcome to FiveInRow Game==";
 cout<<endl;
 cout<<endl;
}


void CShow::ShowChoseGameMode()
{
 //cout<<"Game Mode"<<endl;
 cout<<"People VS People  ( 1)"<<endl;
 cout<<"People VS Computer( 2)"<<endl;
 cout<<"Please Choose Game Mode ( 1 or 2 ): ";
}


void CShow::DisplayBoard()
{  
 int row=0,col=0;
 
 if (SIZE<10)
 {
  cout<<" ";
 }
 cout<<SIZE;
 cout<<"┏";
 
 for (col=2;col<=SIZE-1;col++)
 {
  cout<<"┯";
 }
 cout<<"┓";
 cout<<endl;
   

   
 
 for (row=SIZE-1;row>=2;row--)
 {
  if (row>=10)                  //显示行数
  {
   cout<<row;
  }
  else
   cout<<' '<<row;
  cout<<"┠";
  for (col=2;col<=SIZE-1;col++)
  {
   cout<<"┼";
  }
  cout<<"┨";
  cout<<endl;
 }
   
 
 
 cout<<" 1";
 cout<<"┗";
 for (col=2;col<=SIZE-1;col++)
 {
  cout<<"┷";
 }
 cout<<"┛";
 cout<<endl;
 //以下显示A B C D ...
    cout<<"  ";           
 char alpha=65;
 for (col=1;col<=SIZE;col++)
 {
  cout<<alpha;
  cout<<' ';
  alpha=alpha+1;
 }
 cout<<endl;
 cout<<endl;
}
 


void CShow::DisplayBoard(const CChessBoard& board,const CPiece& pie)
{
 int row=0,col=0;

 
 CPiece piece;
 piece.SetColor(black);
 string blackshape=piece.ReturnShape();
 piece.SetColor(white);
 string whiteshape=piece.ReturnShape();
 string currentshape;
 if (black==pie.ReturnColor())
 {
  currentshape="▲";
 }
 else
 {
  currentshape="△";
 }
    
   
 CPoint pos=pie.ReturnPoint();    //得到当前落子点
 
 
 
 if (SIZE<10)
 {
  cout<<" ";
 }
 cout<<SIZE;
 
 if (pos==CPoint(1,15))
 {
  cout<<currentshape;
 }
 else
 {
  switch (board.ReturnPieceAt(CPoint(1,SIZE)))
  {
  case blank:
   cout<<"┏";
   break;
  case black:
   cout<<blackshape;
   break;
  case white:
   cout<<whiteshape;
  }
 } 
 for (col=2;col<=SIZE-1;col++)
 {
  if (pos==CPoint(col,SIZE))
  {
   cout<<currentshape;
  }
  else
  {
   switch (board.ReturnPieceAt(CPoint(col,SIZE)))
   {
   case blank:
    cout<<"┯";
    break;
   case black:
    cout<<blackshape;
    break;
   case white:
    cout<<whiteshape;
   } 
  }
 
 }
    if (pos==CPoint(SIZE,SIZE))
    {
  cout<<currentshape;
    }
    else
    {
  switch (board.ReturnPieceAt(CPoint(SIZE,SIZE)))
  {
  case blank:
   cout<<"┓";
   break;
  case black:
   cout<<blackshape;
   break;
  case white:
   cout<<whiteshape;
  }
    }
    
 cout<<endl;
   
 
 
   
 
 for (row=SIZE-1;row>=2;row--)
 {
  if (row>=10)                  //显示行数
  {
   cout<<row;
  }
  else
   cout<<' '<<row;
  if (pos==CPoint(1,row))
  {
   cout<<currentshape;
  }
  else
  {
   switch (board.ReturnPieceAt(CPoint(1,row)))
   {
   case blank:
    cout<<"┠";
    break;
   case black:
    cout<<blackshape;
    break;
   case white:
    cout<<whiteshape;
   }
  }
   
  for (col=2;col<=SIZE-1;col++)
  {
   if (pos==CPoint(col,row))
   {
    cout<<currentshape;
   }
   else
   {
    switch (board.ReturnPieceAt(CPoint(col,row)))
    {
    case blank:
     cout<<"┼";
     break;
    case black:
     cout<<blackshape;
     break;
    case white:
     cout<<whiteshape;
    } 
   }
   
  }
  if (pos==CPoint(SIZE,row))
  {
   cout<<currentshape;
  }
  else
  {
   switch (board.ReturnPieceAt(CPoint(SIZE,row)))
   {
   case blank:
    cout<<"┨";
    break;
   case black:
    cout<<blackshape;
    break;
   case white:
    cout<<whiteshape;
   } 
  }
 
  cout<<endl;
 }
   
 
 
 
 
 cout<<" 1";
 if (pos==CPoint(1,1))
 {
  cout<<currentshape;
 }
 else
 {
  switch (board.ReturnPieceAt(CPoint(1,1)))
  {
  case blank:
   cout<<"┗";
   break;
  case black:
   cout<<blackshape;
   break;
  case white:
   cout<<whiteshape;
  } 
 }  
 
 for (col=2;col<=SIZE-1;col++)
 {
  if (pos==CPoint(col,1))
  {
   cout<<currentshape;
  }
  else
  {
   switch (board.ReturnPieceAt(CPoint(col,1)))
   {
   case blank:
    cout<<"┷";
    break;
   case black:
    cout<<blackshape;
    break;
   case white:
    cout<<whiteshape;
   }
  }
  
 }
 if (pos==CPoint(SIZE,1))
 {
  cout<<currentshape;
 }
 else
 {
  switch (board.ReturnPieceAt(CPoint(SIZE,1)))
  {
  case blank:
   cout<<"┛";
   break;
  case black:
   cout<<blackshape;
   break;
  case white:
   cout<<whiteshape;
  }
 }
   
 cout<<endl;
 //以下显示A B C D ...
    cout<<"  ";           
 char alpha=65;
 for (col=1;col<=SIZE;col++)
 {
  cout<<alpha;
  cout<<' ';
  alpha=alpha+1;
 
 }
 cout<<endl;
 cout<<endl;
 
 

}
void CShow::ShowInputPosition(const CPlayer& player)
{
 CPiece pie;
 pie.SetColor(player.ReturnColor());
 cout<<player.ReturnName()<<"("<<pie.ReturnShape()<<")"<<" ,please input piece position ^_^ : ";
 
}
void CShow::ShowWin(const CPlayer& player)
{
 cout<<"Congratuations!"<<player.ReturnName()<<" win!";
 cout<<endl;
 
}
void CShow::ShowForbidden(const CPlayer& player)
{
 cout<<"Sorry!"<<player.ReturnName()<<" forbidden!";
 cout<<endl;
}
void CShow::ShowIsContinue()
{
 cout<<"One more game?( Y/N ) :";
}
