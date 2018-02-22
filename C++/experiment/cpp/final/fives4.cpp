#include <iostream>
#include <conio.h>
using namespace std;
#define WIDE_AND_LONG 20 //���̵ĳ��Ϳ�
#define NAME_LEN      20 //���������ĳ���
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
//��ʼ��������ȱʡֵ
int GOBANG::InitPlayerName(char *pPlayerOne,char *pPlayerTwo)
{
 strcpy(acPlayerOneName,pPlayerOne);
 strcpy(acPlayerTwoName,pPlayerTwo);
 return 0;
}
//�����������ʱ�Ƿ񺬷Ƿ��ַ��ո��Tab��
int GOBANG::CheckInput(char ch, int iNameLen)
{
 if(' ' == ch || '\t' == ch)
 {
  cout<<"���зǷ��ַ�!"<<endl;
  return -1;
 }
 if(iNameLen > NAME_LEN - 1)
 {
  cout<<"���볬���޶�����!"<<endl;
  return -1;
 }
 return 0;
}
//�����ӷŵ�������
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
  cout<<"�˴���������!"<<endl;
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
//������������Ƿ�Ϸ�
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
//��ȡ��ҵ��ǳ�
int GOBANG::GetPlayerName()
{
 fflush(stdin);
 char cTemp = 0;
 int iNameLen = 0;
 cout<<"�Ƿ��Լ������ǳƣ���(Y),��(�����):";
 cTemp = getch();
 cout<<endl;
 if(('y' != cTemp) && ('Y' != cTemp))
 {
  return 0;
 }
 fflush(stdin);
 memset(acPlayerOneName,0,sizeof(acPlayerOneName));
 memset(acPlayerTwoName,0,sizeof(acPlayerTwoName));
 cout<<"�����һ�����ǳ�:";
 while('\n' != (cTemp = getchar()))
 {
  if(-1 == CheckInput(cTemp,iNameLen))
  { 
   fflush(stdin);
   cout<<"�����һ�����ǳ�:";
   continue;
  }
  acPlayerOneName[iNameLen] = cTemp;
  iNameLen++;
 }
 if(0 == iNameLen)
 {
  strcpy(acPlayerOneName,"���һ");
 }
 iNameLen = 0;
 fflush(stdin);
 cout<<"����Ҷ������ǳ�:";
 while('\n' != (cTemp = getchar()))
 {
  if(-1 == CheckInput(cTemp,iNameLen))
  {
   fflush(stdin);
   cout<<"����Ҷ������ǳ�:";
   continue;
  }
  acPlayerTwoName[iNameLen] = cTemp;
  iNameLen++;
 }
 if(0 == iNameLen)
 {
  strcpy(acPlayerTwoName,"���һ");
 }
 return 0;
}
//��ʼ������
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
//������̺����Ƿ������������
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
//������������Ƿ������������
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
//����������Ϸ��������Խ��ߣ��Ƿ������������
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
//����������Ϸ��������Խ��ߣ��Ƿ������������
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
//����������·����������Խ��ߣ��Ƿ������������
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
//����������·����������Խ��ߣ��Ƿ������������
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
//����Ƿ�ƽ��
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
//����Ƿ�ﵽ���������������������ƽ�֣�
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
  cout<<"��ϲ���<"<<acPlayerOneName<<">��ʤ!"<<endl;
  return 1;
 }
 if(2 == iJudgeRow || 2 == iJudgeColumn || 2 == iJudgeTopLeft || \
  2 == iJudgeTopRight || 2 == iJudgeDownLeft || 2 == iJudgeDownRight)
 {
  cout<<"��ϲ���<"<<acPlayerTwoName<<">��ʤ!"<<endl;
  return 1;
 }
 if(0 == iJudgeDraw)
 {
  cout<<"ƽ��!"<<endl;
  return 1;
 }
 return 0;
}
//��ʾ���̵�����̨
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
//��ʼ����
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
   cout<<"��<"<<acPlayerOneName<<">�����Ӧ���к���(��ʽ: a,3 �� a 3 �� a  3):";
  }
  else
  {
   cout<<"��<"<<acPlayerTwoName<<">�����Ӧ���к���(��ʽ: a,3 �� a 3 �� a  3):";
  }
  while('\n' != (cTemp = getchar()))
  {
   if(iLen > 3)
   {
    cout<<"��������!"<<endl;
    fflush(stdin);
    if(!bJudge)
    {
     cout<<"��<"<<acPlayerOneName<<">�����Ӧ���к���(��ʽ: a,3 �� a 3 �� a  3):";
    }
    else
    {
     cout<<"��<"<<acPlayerTwoName<<">�����Ӧ���к���(��ʽ: a,3 �� a 3 �� a  3):";
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
   cout<<"��������!"<<endl;
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
//�ж���Ϸ����������Ƿ�ѡ����������˳�
int GOBANG::BeginOrNot()
{
 char cTemp = 0;
 cout<<"�Ƿ����?��(Y),�˳�(�����):";
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
  exit(0); //����ĳ���
 }
 return 0;
}
int main()
{
 GOBANG gobang;
 memset(&gobang,0,sizeof(GOBANG));
 gobang.InitPlayerName("���һ","��Ҷ�");
 gobang.GetPlayerName();
 gobang.InitBoard();
 gobang.ShowBoard();
 gobang.Chess();
 return 0;
}

