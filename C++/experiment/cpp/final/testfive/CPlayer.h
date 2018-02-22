#ifndef CPlayer_H_H_H_
#define CPlayer_H_H_H_
#include "CPiece.h"
#include "CChessBoard.h"
class CPlayer
{
public:
    void SetColor(int col);
 int ReturnColor() const;
 void GetPiece(CPiece& piece,const CPoint& position);
 void PlacePiece(CChessBoard& board,const CPiece& piece);
 void SetName(string s);
 string ReturnName() const;
private:
 int color;
 string name;
};
#endif