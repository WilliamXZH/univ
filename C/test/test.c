/*//#include<stdio.h>
main(){
	float a=5,b=6,c=7.5,d;
	d=(a+b+c)*5;
	printf("5d",d);
}*/


#include<stdio.h>

int parseInt(char *number);
double operate(char *expression , int location);

char *strftcpy(char *destin , char *source,int from , int to)
{
	int i=0;
	while(from+i<=to&&(destin[i]=source[from+i])!='\0')
	{
		i++;
	}

	if(destin[i]!='\0')
	{
		destin[i]='\0';
	}

	return destin;
}

void main()
{
	char *expression="12/3+2*(15-7)+00123";
	printf("\n\n%lf\n",operate(expression,0));
}



double operate(char *expression , int location)
{
	char tmp[11];
	char tmpExpre[100];
	int tmpLoc;
	double result=0;

	printf("%s\n",expression);

	if(expression[location]>='0'&&expression[location]<='9')
	{
		tmpLoc=location;
		while(expression[++location]<'9'&&expression[location]>'0');
		strftcpy(tmp,expression,tmpLoc,location-1);
		result=parseInt(tmp);
	}else if(expression[location]=='(')
	{	
		tmpLoc=location+1;
		while(expression[++location]!=')');
		strftcpy(tmpExpre,expression,tmpLoc,location-1);
		result=operate(tmpExpre , 0);
		location++;
	}
	
	printf("%lf\n",result);

	if(expression[location]=='*')
	{
		tmpLoc=location+1;
		while(expression[++location]!='+'&&expression[location]!='-'
			&&expression[location]!='\0');
		strftcpy(tmpExpre,expression,tmpLoc,location-1);
		result*=operate(tmpExpre,0);
	}else if(expression[location]=='/')
	{
		tmpLoc=location+1;
		while(expression[++location]!='+'&&expression[location]!='-'
			&&expression[location]!='\0');
		strftcpy(tmpExpre,expression,tmpLoc,location-1);
		result/=operate(tmpExpre,0);
	}

	printf("%lf\n",result);
	if(expression[location]=='+')
	{
		result+=operate(expression,location+1);
	}else if(expression[location]=='-')
	{
		result-=operate(expression,location+1);
	}
	
	printf("%lf\n",result);
	return result;
}

int parseInt(char *number)
{
	int tmp=0;

	int i;
	for(i=0;number[i]!='\0';i++)
	{
		tmp=tmp*10+number[i]-'0';
	}

	return tmp;
}


