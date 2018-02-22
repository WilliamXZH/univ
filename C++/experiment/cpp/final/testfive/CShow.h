#ifndef CShow_H_H_H_
#define CShow_H_H_H_
#include "CChessBoard.h"
#include "CPiece.h"
#include "CPoint.h"
#include "CPlayer.h"
 
class CShow
{
public:
 void Welcome();
 void DisplayBoard();
 void DisplayBoard(const CChessBoard& board,const CPiece& pie);
 void ShowChoseGameMode();
 void ShowInputPosition(const CPlayer& player);
 void ShowWin(const CPlayer& player);
 void ShowIsContinue();
 void ShowForbidden(const CPlayer& player);

};
#endif
 