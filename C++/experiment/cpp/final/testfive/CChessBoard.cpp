#include "CChessBoard.h"
CChessBoard::CChessBoard()
{  
 pt=new int[16][16];
    for (int i=0;i<=15;i++)
 {
  for (int j=0;j<=15;j++)
  {
   pt[i][j]=0;
  }
 }   
}
void CChessBoard::PlacePiece(const CPiece& piece)
{
 CPoint pos=piece.ReturnPoint();
 pt[pos.x][pos.y]=piece.ReturnColor();
}
int CChessBoard::ReturnPieceAt(CPoint& pos) const
{
 return pt[pos.x][pos.y];
}
CChessBoard::~CChessBoard()
{
 delete []pt;
}