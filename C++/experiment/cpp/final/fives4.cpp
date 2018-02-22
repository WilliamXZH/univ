#include <iostream>
#include <conio.h>
using namespace std;
#define WIDE_AND_LONG 20 //棋盘的长和宽
#define NAME_LEN      20 //输入姓名的长度
typedef class Gobang
{
 public:
  int InitPlayerName(char *, char *);
  int CheckInput(char,int);
  int CheckIndexInput(char, char, char);
  int GetPlayerName();
  int InitBoard();
  int WriteBoard(char, char, bool);
  int BeginOrNot();
  int CheckRow();
  int CheckColumn();
  int CheckTopLeft();
  int CheckTopRight();
  int CheckDownLeft();
  int CheckDownRight();
  int CheckDraw();
  int CheckFinish();
  int Chess();
  int ShowBoard();
 private:
  char acBoard[WIDE_AND_LONG][WIDE_AND_LONG];
  char acPlayerOneName[NAME_LEN];
  char acPlayerTwoName[NAME_LEN];
}GOBANG;
//初始化姓名的缺省值
int GOBANG::InitPlayerName(char *pPlayerOne,char *pPlayerTwo)
{
 strcpy(acPlayerOneName,pPlayerOne);
 strcpy(acPlayerTwoName,pPlayerTwo);
 return 0;
}
//检查输入姓名时是否含非法字符空格和Tab键
int GOBANG::CheckInput(char ch, int iNameLen)
{
 if(' ' == ch || '\t' == ch)
 {
  cout<<"含有非法字符!"<<endl;
  return -1;
 }
 if(iNameLen > NAME_LEN - 1)
 {
  cout<<"输入超出限定长度!"<<endl;
  return -1;
 }
 return 0;
}
//将棋子放到棋盘中
int GOBANG::WriteBoard(char cRow, char cColumn, bool bJudge)
{
 int iRow = 0;
 int iColumn = 0;
 if(cRow >= '0' && cRow <= '9')
 {
  iRow = static_cast<int>(cRow - '0');
 }
 else if(cRow >= 'A' && cRow <= static_cast<char>('A' + WIDE_AND_LONG - 10 - 1))
 {
  iRow = static_cast<int>((cRow - 'A') + 10);
 }
 else
 {
  iRow = static_cast<int>((cRow - 'a') + 10);
 }
 if(cColumn >= '0' && cColumn <= '9')
 {
  iColumn = static_cast<int>(cColumn - '0');
 }
 else if(cColumn >= 'A' && cColumn <= static_cast<char>('A' + WIDE_AND_LONG - 10 - 1))
 {
  iColumn = static_cast<int>((cColumn - 'A') + 10);
 }
 else
 {
  iColumn = static_cast<int>((cColumn - 'a') + 10);
 }
 if('+' != acBoard[iRow][iColumn])
 {
  cout<<"此处已有棋子!"<<endl;
  return -1;
 }
 if(!bJudge)
 {
  acBoard[iRow][iColumn] = static_cast<char>(1);
 }
 else
 {
  acBoard[iRow][iColumn] = static_cast<char>(2);
 }
 return 0;
}
//检查坐标输入是否合法
int GOBANG::CheckIndexInput(char cRow,char cSeparator,char cColumn)
{
 if(!cRow || !cSeparator || !cColumn)
 {
  return -1;
 }
 if(!((cRow >= '0' && cRow <= '9') || \
  (cRow >= 'A' && cRow <= static_cast<char>('A' + WIDE_AND_LONG - 10 - 1)) || \
  (cRow >= 'a' && cRow <= static_cast<char>('a' + WIDE_AND_LONG - 10 - 1)))
  )
 {
  return -1;
 }
 if(' ' != cSeparator && '\t' != cSeparator && ',' != cSeparator)
 {
  return -1;
 }
 if(!((cColumn >= '0' && cColumn <= '9') || \
  (cColumn >= 'A' && cColumn <= static_cast<char>('A' + WIDE_AND_LONG - 10 - 1)) || \
  (cColumn >= 'a' && cColumn <= static_cast<char>('a' + WIDE_AND_LONG - 10 - 1)))
  )
 {
  return -1;
 }
 return 0;
}
//获取玩家的昵称
int GOBANG::GetPlayerName()
{
 fflush(stdin);
 char cTemp = 0;
 int iNameLen = 0;
 cout<<"是否自己定义昵称？是(Y),否(任意键):";
 cTemp = getch();
 cout<<endl;
 if(('y' != cTemp) && ('Y' != cTemp))
 {
  return 0;
 }
 fflush(stdin);
 memset(acPlayerOneName,0,sizeof(acPlayerOneName));
 memset(acPlayerTwoName,0,sizeof(acPlayerTwoName));
 cout<<"请玩家一输入昵称:";
 while('\n' != (cTemp = getchar()))
 {
  if(-1 == CheckInput(cTemp,iNameLen))
  { 
   fflush(stdin);
   cout<<"请玩家一输入昵称:";
   continue;
  }
  acPlayerOneName[iNameLen] = cTemp;
  iNameLen++;
 }
 if(0 == iNameLen)
 {
  strcpy(acPlayerOneName,"玩家一");
 }
 iNameLen = 0;
 fflush(stdin);
 cout<<"请玩家二输入昵称:";
 while('\n' != (cTemp = getchar()))
 {
  if(-1 == CheckInput(cTemp,iNameLen))
  {
   fflush(stdin);
   cout<<"请玩家二输入昵称:";
   continue;
  }
  acPlayerTwoName[iNameLen] = cTemp;
  iNameLen++;
 }
 if(0 == iNameLen)
 {
  strcpy(acPlayerTwoName,"玩家一");
 }
 return 0;
}
//初始化棋盘
int GOBANG::InitBoard()
{
 int iRow = 0;
 int iColumn = 0;
 for(iRow = 0; iRow < WIDE_AND_LONG; iRow++)
 {
  for(iColumn = 0; iColumn < WIDE_AND_LONG; iColumn++)
  {
   acBoard[iRow][iColumn] = '+';
  }
 }
 return 0;
}
//检查棋盘横向是否存在五子连珠
int GOBANG::CheckRow()
{
 int iRow = 0;
 int iColumn = 0;
 int iPlayerOneLen = 0;
 int iPlayerTwoLen = 0;
 for(iRow = 0; iRow < WIDE_AND_LONG; iRow ++)
 {
  while(iColumn < WIDE_AND_LONG)
  {
   if(static_cast<char>(1) == acBoard[iRow][iColumn])
   {
    iPlayerOneLen ++;
    iPlayerTwoLen = 0;
   }
   else if(static_cast<char>(2) == acBoard[iRow][iColumn])
   {
    iPlayerTwoLen ++;
    iPlayerOneLen = 0;
   }
   else
   {
    iPlayerTwoLen = 0;
    iPlayerOneLen = 0;
   }
   iColumn ++;
  }
  if(iPlayerOneLen >= 5)
  {
   return 1;
  }
  if(iPlayerTwoLen >= 5)
  {
   return 2;
  }
  iPlayerOneLen = 0;
  iPlayerTwoLen = 0;
  iColumn = 0;
 }
 return 0;
}
//检查棋盘竖向是否存在五子连珠
int GOBANG::CheckColumn()
{
 int iRow = 0;
 int iColumn = 0;
 int iPlayerOneLen = 0;
 int iPlayerTwoLen = 0;
 for(iColumn = 0; iColumn < WIDE_AND_LONG; iColumn ++)
 {
  while(iRow < WIDE_AND_LONG)
  {
   if(static_cast<char>(1) == acBoard[iRow][iColumn])
   {
    iPlayerOneLen ++;
    iPlayerTwoLen = 0;
   }
   else if(static_cast<char>(2) == acBoard[iRow][iColumn])
   {
    iPlayerTwoLen ++;
    iPlayerOneLen = 0;
   }
   else
   {
    iPlayerTwoLen = 0;
    iPlayerOneLen = 0;
   }
   iRow ++;
  }
  if(iPlayerOneLen >= 5)
  {
   return 1;
  }
  if(iPlayerTwoLen >= 5)
  {
   return 2;
  }
  iPlayerOneLen = 0;
  iPlayerTwoLen = 0;
  iRow = 0;
 }
 return 0;
}
//检查棋盘左上方（包括对角线）是否存在五子连珠
int GOBANG::CheckTopLeft()
{
 int iRow = 0;
 int iTempRow = 0;
 int iColumn = 0;
 int iPlayerOneLen = 0;
 int iPlayerTwoLen = 0;
 for(iRow = 4; iRow < WIDE_AND_LONG; iRow ++)
 {
  iTempRow = iRow;
  while(iTempRow >= 0)
  {
   if(static_cast<char>(1) == acBoard[iTempRow][iColumn])
   {
    iPlayerOneLen ++;
    iPlayerTwoLen = 0;
    if(iPlayerOneLen >= 5)
    {
     return 1;
    }
   }
   else if(static_cast<char>(2) == acBoard[iTempRow][iColumn])
   {
    iPlayerTwoLen ++;
    iPlayerOneLen = 0;
    if(iPlayerTwoLen >= 5)
    {
     return 2;
    }
   }
   else
   {
    iPlayerTwoLen = 0;
    iPlayerOneLen = 0;
   }
   iTempRow --;
   iColumn ++;
  }
  
  iPlayerOneLen = 0;
  iPlayerTwoLen = 0;
  iColumn = 0;
 }
 return 0;
}
//检查棋盘右上方（包括对角线）是否存在五子连珠
int GOBANG::CheckTopRight()
{
 int iRow = 0;
 int iColumn = 0;
 int iTempColumn = 0;
 int iPlayerOneLen = 0;
 int iPlayerTwoLen = 0;
 for(iColumn = 0; iColumn < WIDE_AND_LONG - 4; iColumn ++)
 {
  iTempColumn = iColumn;
  while(iTempColumn < WIDE_AND_LONG)
  {
   if(static_cast<char>(1) == acBoard[iRow][iTempColumn])
   {
    iPlayerOneLen ++;
    iPlayerTwoLen = 0;
    if(iPlayerOneLen >= 5)
    {
     return 1;
    }
   }
   else if(static_cast<char>(2) == acBoard[iRow][iTempColumn])
   {
    iPlayerTwoLen ++;
    iPlayerOneLen = 0;
    if(iPlayerTwoLen >= 5)
    {
     return 2;
    }
   }
   else
   {
    iPlayerTwoLen = 0;
    iPlayerOneLen = 0;
   }
   iRow ++;
   iTempColumn ++;
  }
  
  
  iPlayerOneLen = 0;
  iPlayerTwoLen = 0;
  iRow = 0;
 }
 return 0;
}
//检查棋盘左下方（不包括对角线）是否存在五子连珠
int GOBANG::CheckDownLeft()
{
 int iRow = 0;
 int iTempRow = 0;
 int iColumn = 0;
 int iPlayerOneLen = 0;
 int iPlayerTwoLen = 0;
 for(iRow = 1; iRow < WIDE_AND_LONG - 4; iRow ++)
 {
  iTempRow = iRow;
  while(iTempRow < WIDE_AND_LONG)
  {
   if(static_cast<char>(1) == acBoard[iTempRow][iColumn])
   {
    iPlayerOneLen ++;
    iPlayerTwoLen = 0;
    if(iPlayerOneLen >= 5)
    {
     return 1;
    }
   }
   else if(static_cast<char>(2) == acBoard[iTempRow][iColumn])
   {
    iPlayerTwoLen ++;
    iPlayerOneLen = 0;
    if(iPlayerTwoLen >= 5)
    {
     return 2;
    }
   }
   else
   {
    iPlayerTwoLen = 0;
    iPlayerOneLen = 0;
   }
   iTempRow ++;
   iColumn ++;
  }
  
  
  iPlayerOneLen = 0;
  iPlayerTwoLen = 0;
  iColumn = 0;
 }
 return 0;
}
//检查棋盘右下方（不包括对角线）是否存在五子连珠
int GOBANG::CheckDownRight()
{
 int iRow = 0;
 int iTempRow = 0;
 int iColumn = WIDE_AND_LONG - 1;
 int iPlayerOneLen = 0;
 int iPlayerTwoLen = 0;
 for(iRow = 1; iRow < WIDE_AND_LONG - 4; iRow ++)
 {
  iTempRow = iRow;
  while(iTempRow < WIDE_AND_LONG)
  {
   if(static_cast<char>(1) == acBoard[iTempRow][iColumn])
   {
    iPlayerOneLen ++;
    iPlayerTwoLen = 0;
    if(iPlayerOneLen >= 5)
    {
     return 1;
    }
   }
   else if(static_cast<char>(2) == acBoard[iTempRow][iColumn])
   {
    iPlayerTwoLen ++;
    iPlayerOneLen = 0;
    if(iPlayerTwoLen >= 5)
    {
     return 2;
    }
   }
   else
   {
    iPlayerTwoLen = 0;
    iPlayerOneLen = 0;
   }
   iTempRow ++;
   iColumn --;
  }
  
  
  iPlayerOneLen = 0;
  iPlayerTwoLen = 0;
  iColumn = WIDE_AND_LONG - 1;
 }
 return 0;
}
//检查是否平局
int GOBANG::CheckDraw()
{
 int iRow = 0;
 int iColumn = 0;
 for(iRow = 0; iRow < WIDE_AND_LONG; iRow++)
 {
  for(iColumn = 0; iColumn < WIDE_AND_LONG; iColumn++)
  {
   if('+' == acBoard[iRow][iColumn])
   {
    return 1;
   }
  }
 }
 return 0;
}
//检查是否达到结束的条件（五子连珠或平局）
int GOBANG::CheckFinish()
{
 int iJudgeRow = 0;
 int iJudgeColumn = 0;
 int iJudgeTopLeft = 0;
 int iJudgeTopRight = 0;
 int iJudgeDownLeft = 0;
 int iJudgeDownRight = 0;
 int iJudgeDraw = 0;
 iJudgeRow = CheckRow();
 iJudgeColumn = CheckColumn();
 iJudgeTopLeft = CheckTopLeft();
 iJudgeTopRight = CheckTopRight();
 iJudgeDownLeft = CheckDownLeft();
 iJudgeDownRight = CheckDownRight();
 iJudgeDraw = CheckDraw();
 if(1 == iJudgeRow || 1 == iJudgeColumn || 1 == iJudgeTopLeft || \
  1 == iJudgeTopRight || 1 == iJudgeDownLeft || 1 == iJudgeDownRight)
 {
  cout<<"恭喜玩家<"<<acPlayerOneName<<">获胜!"<<endl;
  return 1;
 }
 if(2 == iJudgeRow || 2 == iJudgeColumn || 2 == iJudgeTopLeft || \
  2 == iJudgeTopRight || 2 == iJudgeDownLeft || 2 == iJudgeDownRight)
 {
  cout<<"恭喜玩家<"<<acPlayerTwoName<<">获胜!"<<endl;
  return 1;
 }
 if(0 == iJudgeDraw)
 {
  cout<<"平局!"<<endl;
  return 1;
 }
 return 0;
}
//显示棋盘到控制台
int GOBANG::ShowBoard()
{
 int iRow = 0;
 int iColumn = 0;
 system("cls");
 cout<<"  ";
 for(iRow = 0; iRow < WIDE_AND_LONG; iRow++)
 {
  if(9 < iRow)
  {
   cout<<static_cast<char>('A' + iRow - 10)<<" ";
  }
  else
  {
   cout<<iRow<<" ";
  }
 }
 cout<<endl;
 for(iRow = 0; iRow < WIDE_AND_LONG; iRow++)
 {
  if(9 < iRow)
  {
   cout<<static_cast<char>('A' + iRow - 10)<<" ";
  }
  else
  {
   cout<<iRow<<" ";
  }
  for(iColumn = 0; iColumn < WIDE_AND_LONG; iColumn++)
  {
   cout<<acBoard[iRow][iColumn]<<' ';
  }
  cout<<endl;
 }
 return 0;
}
//开始下棋
int GOBANG::Chess()
{
 bool bJudge = false;
 while(1)
 {
  char cRow = 0;
  char cSeparator = 0;
  char cColumn = 0;
  char cTemp = 0;
  int  iLen =1;
  fflush(stdin);
  if(!bJudge)
  {
   cout<<"请<"<<acPlayerOneName<<">输入对应的行和列(格式: a,3 或 a 3 或 a  3):";
  }
  else
  {
   cout<<"请<"<<acPlayerTwoName<<">输入对应的行和列(格式: a,3 或 a 3 或 a  3):";
  }
  while('\n' != (cTemp = getchar()))
  {
   if(iLen > 3)
   {
    cout<<"输入有误!"<<endl;
    fflush(stdin);
    if(!bJudge)
    {
     cout<<"请<"<<acPlayerOneName<<">输入对应的行和列(格式: a,3 或 a 3 或 a  3):";
    }
    else
    {
     cout<<"请<"<<acPlayerTwoName<<">输入对应的行和列(格式: a,3 或 a 3 或 a  3):";
    }
    iLen = 1;
    continue;
   }
   if(1 == iLen)
   {
    cRow = cTemp;
   }
   else if(2 == iLen)
   {
    cSeparator = cTemp;
   }
   else
   {
    cColumn = cTemp;
   }
   iLen++;
  }
  if(-1 == CheckIndexInput(cRow,cSeparator,cColumn))
  {
   cout<<"输入有误!"<<endl;
   continue;
  }
  if(-1 == WriteBoard(cRow,cColumn,bJudge))
  {
   continue;
  }
  ShowBoard();
  if(1 == CheckFinish())
  {
   BeginOrNot();
  }
  bJudge = !bJudge;
 }
 return 0;
}
//判断游戏结束后玩家是否选择继续还是退出
int GOBANG::BeginOrNot()
{
 char cTemp = 0;
 cout<<"是否继续?是(Y),退出(任意键):";
 fflush(stdin);
 cTemp = getch();
 if('y' == cTemp || 'Y' == cTemp)
 {
  InitBoard();
  ShowBoard();
  Chess();
 }
 else
 {
  exit(0); //程序的出口
 }
 return 0;
}
int main()
{
 GOBANG gobang;
 memset(&gobang,0,sizeof(GOBANG));
 gobang.InitPlayerName("玩家一","玩家二");
 gobang.GetPlayerName();
 gobang.InitBoard();
 gobang.ShowBoard();
 gobang.Chess();
 return 0;
}

