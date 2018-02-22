#include<iostream>
using namespace std;

int initialExpre();
int getWidth(char c);

char number[5][29]={
		"*********** ****************",
		"* **  *  ** **  *    ** ** *",
		"* *****************  *******",
		"* ***    *  *  ** *  ** *  *",
		"**********  *******  *******"
};
char alg[5][19]={
		"                  ",
		" *    * *  *****  ",
		"****** *  *       ",
		" *    * **  ******",
		"                **"
};


int main()
{
	int wid = 0;
	
	char s[100];
	cin>>s;
	for (int i=0; s[i]!='\0'; i++)
	{
		if(i!=0)
		{
			wid += 2;
		}
		wid += getWidth(s[i]);
	}
	char **str;
	str = (char**)malloc(sizeof(char*)*5);
	for(int j=0; j<5; j++)
	{
		str[j] = (char*)malloc(sizeof(char)*wid);
		//memset(str[j],'\0',wid*sizeof(char));
		for(int l=0;l<wid;l++){
			str[j][l]='\0';
		}
	}

	int widtotal = 0;
	for(int k=0;s[k]!='\0';k++)
	{
		int liv = 0;
		int widtmp = getWidth(s[k]);
		if(s[k]>='0'&&s[k]<='9')
		{
			if(s[k]=='0')
			{
				liv=0;
			}else if(s[k]=='1')
			{
				liv = 3;
			}else
			{
				liv = 4+(s[k]-'2')*3;
			}
			for(int l=0;l<5;l++)
			{
				for(int m=0;m<widtmp;m++)
				{
					str[l][widtotal+m] = number[l][liv+m];
				}
			}
		}else
		{
			if(s[k]=='+')
			{
				liv=0;	
			}else if(s[k]=='-')
			{
				liv=3;
			}else if(s[k]=='*')
			{
				liv=6;
			}else if(s[k]=='/')
			{
				liv=9;
			}else if(s[k]=='=')
			{
				liv=12;
			}else if(s[k]=='.')
			{
				liv=16;
			}
			for(int l=0;l<5;l++)
			{
				for(int m=0;m<widtmp;m++)
				{
					str[l][widtotal+m] = alg[l][liv+m];
				}
			}
		}
		
		widtotal+=widtmp;
		widtotal+=2;
	}

	for(int x=0;x<5;x++)
	{
		for(int y=0;y<wid;y++)
		{
			cout<<str[x][y];
		}
		cout<<endl;
	}
}

int getWidth(char c)
{
	if (c=='1')
	{
		return 1;
	}else if (c=='=')
	{
		return 4;
	}else if (c=='.')
	{
		return 2;
	}else
	{
		return 3;
	}
}