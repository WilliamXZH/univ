#include<stdio.h>

int parseInt(char *number);
double operate(char *expression , int location);
char *strftcpy(char *destin , char *source,int from , int to);

void main()
{
	char *expression="12/3+02*(015-7)+15";
	//char *expression="21+4-13";
	printf("\n%s=%lf",expression,operate(expression,0));
}

double operate(char *expression , int location)
{
	int count=0;
	int type=0;
	int tmpLoc;
	double nums[10];
	char opeCh[10];
	char tmpExper[100];

	while(expression[location]!='\0')
	{
		//printf("type:%d\n",type);
		if(expression[location]=='(')
		{
			tmpLoc=location+1;
			while(expression[++location]!=')');
			strftcpy(tmpExper,expression,tmpLoc,location-1);
			nums[count]=operate(tmpExper,0);

			if(type==2)
			{
				nums[count-1]*=nums[count];
				count--;
				type=0;
			}else if(type==3)
			{
				nums[count-1]/=nums[count];
				count--;
				type=0;
			}
			
			//printf("(1)%lf\n",nums[count]);
			count++;
		}else if(expression[location]>='0'&&expression[location]<='9')
		{
			tmpLoc=location;
			while(expression[++location]<'9'&&expression[location]>'0');
			strftcpy(tmpExper,expression,tmpLoc,location-1);
			nums[count]=parseInt(tmpExper);
			//printf("(2)%lf\n",nums[count]);

			if(type==2)
			{
				nums[count-1]*=nums[count];
				count--;
				type=0;
			}else if(type==3)
			{
				nums[count-1]/=nums[count];
				count--;
				type=0;
			}

			//printf("(2)%lf\n",nums[count]);
			count++;
			location--;
		}else if(expression[location]=='+'||expression[location]=='-')
		{
			opeCh[count-1]=expression[location];
			//printf("sub_add:%c\n",opeCh[count-1]);
		}else if(expression[location]=='*')
		{
			//printf("multi:\n");
			type=2;
		}else if(expression[location]=='/')
		{
			//printf("divis:\n");
			type=3;
		}else
		{
			printf("error:%c",expression[location]);
		}

		location++;
	}
	
	while(--count!=0)
	{
		//printf("%d %lf %lf\n",count,nums[count-1],nums[count]);
		if(opeCh[count-1]=='+')
		{
			nums[count-1]+=nums[count];
		}else if(opeCh[count-1]=='-')
		{
			nums[count-1]-=nums[count];
		}
	}

	return nums[0];
}

int parseInt(char *number)
{
	int tmp=0;

	int i;

	//printf("parseInt():%s\n",number);
	for(i=0;number[i]!='\0';i++)
	{
		tmp=tmp*10+number[i]-'0';
	}

	//printf("parseResult:%d\n",tmp);
	return tmp;
}

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
