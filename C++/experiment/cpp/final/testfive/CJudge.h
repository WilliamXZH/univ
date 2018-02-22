#ifndef CJudge_H_H_H_
#define CJudge_H_H_H_
#include "CChessBoard.h"
#include "CPiece.h"
class CJudge
{
public:
 bool IsValid(const CChessBoard& board,const CPiece& piece);
 bool IsForbidden(const CChessBoard& board,const CPiece& piece);
 bool IsWin(const CChessBoard& board,const CPiece& piece);
 bool IsChangLian(const CChessBoard& board,const CPiece& piece);
 void ComputeChessModel(const CChessBoard& board,const CPiece& piece,int (*p)[2]);
};

#endif