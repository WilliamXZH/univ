
#include "CPlayer.h"
#include <string>
using namespace std;
void CPlayer::SetColor(int col)
{
 color=col;
}
int CPlayer::ReturnColor() const
{
 return color;
}
void CPlayer::GetPiece(CPiece& piece,const CPoint& pos)
{
 piece.SetColor(color);
 piece.SetPosition(pos);
}
void CPlayer::SetName(string s)
{
 name=s;
}
 
string CPlayer::ReturnName() const
{
 return name;
}