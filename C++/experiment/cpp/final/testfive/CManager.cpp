#include "CManager.h"
#include <iostream>
using namespace std;
void CManager::GameRun()
{
   
 while (1)    //IsContinue为否时退出
 {
 CPlayer player1,player2;
 CJudge judge;
 CChessBoard board;
 CPiece piece;
 CShow show;
 COrganizer organizer;
 show.Welcome();
  show.DisplayBoard();
 organizer.DecideGameMode(show);
 
       
 if (1==organizer.ReturnMode())
 {
  organizer.DecideWhoGoFirst(player1,player2);
  show.Welcome();                //重新显示一遍棋盘
  show.DisplayBoard();
  while (1)
  {
   if (1==organizer.ReturnFlagTurn())        //轮到1号玩家
   {
  
   do {
   show.ShowInputPosition(player1);
   CPoint point=organizer.GetInputPosition();
   player1.GetPiece(piece,point);
   
   } while(!judge.IsValid(board,piece));
  
   board.PlacePiece(piece);
   show.Welcome();
   show.DisplayBoard(board,piece);
  
  
   }
      else                                     //轮到2号玩家
   {
  
   do {
   show.ShowInputPosition(player2);
   CPoint point=organizer.GetInputPosition();
   player2.GetPiece(piece,point);
   
   } while(!judge.IsValid(board,piece));
  
   board.PlacePiece(piece);
   show.Welcome();
   show.DisplayBoard(board,piece);
  
   }
 
   if (judge.IsForbidden(board,piece))
   {
    if (1==organizer.ReturnFlagTurn())
    {
     show.ShowForbidden(player1);
    }
    else
     show.ShowForbidden(player2);
    break;
   }
 

 
  if (judge.IsWin(board,piece))
  {
   if (1==organizer.ReturnFlagTurn())
   {
    show.ShowWin(player1);
   }
   else
    show.ShowWin(player2);
   break;
           
  }
  organizer.ExchangeFlag();
  }//while结束，退出游戏
 }
   
 else
 {
  CAlgorithm algorithm;       //算法类
  organizer.DecideWhoGoFirst(player1,player2);
  show.Welcome();                //重新显示一遍棋盘
  show.DisplayBoard();
  while (1)
  {
   if (1==organizer.ReturnFlagTurn())        //轮到1号玩家
   {
  
   do {
   show.ShowInputPosition(player1);
   CPoint point=organizer.GetInputPosition();
   player1.GetPiece(piece,point);
   
   } while(!judge.IsValid(board,piece));
  
   board.PlacePiece(piece);
   show.Welcome();
   show.DisplayBoard(board,piece);
  
  
   }
      else                                     //轮到2号玩家
   {
  
  
 
   CPoint point=algorithm.ComputePiecePosition(board,player2);
   player2.GetPiece(piece,point);
 
  
   board.PlacePiece(piece);
   show.Welcome();
   show.DisplayBoard(board,piece);
  
   }
 
   if (judge.IsForbidden(board,piece))
   {
    if (1==organizer.ReturnFlagTurn())
    {
     show.ShowForbidden(player1);
    }
    else
     show.ShowForbidden(player2);
    break;
   }
 

 
  if (judge.IsWin(board,piece))
  {
   if (1==organizer.ReturnFlagTurn())
   {
    show.ShowWin(player1);
   }
   else
    show.ShowWin(player2);
   break;
           
  }
  organizer.ExchangeFlag();
  }//while结束，退出游戏
 
 
 }

   
 
 int choice=0;
    do {
 show.ShowIsContinue();
 choice=organizer.GetIsContinueResult();    
    } while(choice!='Y' && choice!='N');
 if ('N'==choice)
  break;
 }
}