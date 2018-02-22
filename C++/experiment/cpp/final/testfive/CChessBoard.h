#ifndef CChessBoard_H_H_H_
#define CChessBoard_H_H_H_
#include "CPoint.h"
#include "CPiece.h"
#define SIZE 15

class CChessBoard
{
public:
 CChessBoard();
    ~CChessBoard();
 void PlacePiece(const CPiece& piece);
 int ReturnPieceAt(CPoint& pos) const;
 
private:
 int (*pt)[SIZE+1];
};
#endif