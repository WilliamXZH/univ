#ifndef CAlgorithm_H_H_H_
#define CAlgorithm_H_H_H_
#include "CChessBoard.h"
#include "CPlayer.h"
#include "CPoint.h"
class CAlgorithm
{
public:
 void CountChessModel(const CChessBoard& board,const CPoint& point,const int color,int (*p)[2]);
 CPoint ComputePiecePosition(const CChessBoard& board,const CPlayer& player);
 
};
#endif