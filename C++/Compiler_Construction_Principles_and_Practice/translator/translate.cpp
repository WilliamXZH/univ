#include <iostream>
#include <malloc.h>
using namespace std;

#define STACKSIZE  50
#define STACKINCREMENT   10
#define OK 1
#define error 0 
#define    overflow    -1
typedef char SElemType;
typedef int  Status;

typedef struct                      
{
	SElemType  *base;
	SElemType  *top;
	int stacksize;
}SqStack;

Status InitStack(SqStack &S)
{
	S.base = (SElemType * )malloc(STACKSIZE * sizeof(SElemType));
	if (!S.base)
	exit(overflow);
	S.top=S.base;
	S.stacksize=STACKSIZE;
	return OK;
}
Status Push(SqStack &S, SElemType e)
{
	if (S.top - S.base >= S.stacksize) 
	{
		S.base = (SElemType * )realloc(S.base, (S.stacksize + STACKINCREMENT) * sizeof(SElemType));
		if (!S.base)
		exit(overflow);
		S.top = S.base + S.stacksize;
		S.stacksize += STACKINCREMENT;
	}
	(S.top)++;
	*(S.top) = e;
	return OK;
}
Status Pop(SqStack &S, SElemType &e)
{
	if (S.top == S.base) 
	return error;
	e = *(S.top);
	S.top--;
	return OK;
}
Status GrammerAnalysis(SqStack &S, char *ch, char c){
	SElemType e;
	Push(S, '#');                                            
	Push(S, 'E');                                            
	while (!((*(S.top) == '#') && (c == '#'))){
		Pop(S, e);	
		if ((e == 'E') && (((c >= '0') && (c <= '9')) ||(c>='a'&&c<='z')|| (c == '(')))      
		{
			Push(S , 'A');
			Push(S , 'T');
		}else if ((e == 'A') && (c == '+')){
			Push(S , 'A');
			Push(S , 'T');
			ch++;
			c = *ch;
		}else if ((e == 'A') && ((c == ')')||(c == '#')));
		else if ((e == 'T') && (((c >= '0') && (c <= '9')) ||(c>='a'&&c<='z')|| (c == '('))){
			Push(S , 'B');
			Push(S , 'F');
		}else if ((e == 'B') && (c == '*')){   
			Push(S , 'B');
			Push(S , 'F');
			ch++;
			c = *ch;
		}else if ((e == 'B') && ((c == '+')||(c == ')')||(c == '#')));
		else if ((e == 'F') && ((c>='0'&&c<='9')||(c>='a'&&c<='z'))){
			ch++;
			while (((c = *ch) >= '0') && (c <= '9')||(c>='a'&&c<='z'))
				ch++;
		}else if ((e == 'F') && (c == '(')){   
			Push(S, ')');
			Push(S, 'E');
			ch++;
			c = *ch;
		} else if ((e == ')') && (c == ')')){
			ch++;
			c = *ch;
		}else  return  error;
	}
	return OK;
}
int main(){
	char str[50];                      
	char c;
	system("color 0B");
	SqStack S;
	InitStack(S);
	printf("|-------------------------------------------------|\n");
	printf("|     请输入表达式，以#键结束:                    |\n");
	printf("|-------------------------------------------------|\n");
	scanf("%s", str);
	c = *str;                         
	if (GrammerAnalysis(S,str,c))
	{
		printf("语法分析通过\n");
		printf("表达式正确 \n");
	}
	else{
	printf("语法分析未通过\n");
	printf("表达式错误 \n");}
	main();
	return 0;
}
