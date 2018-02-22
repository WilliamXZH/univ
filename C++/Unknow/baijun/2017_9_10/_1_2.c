#include<stdio.h>             
#include<string.h>
#include<math.h>
int main()
{
	int i,n;
	int m=0;
	int p;
	char ch[9],sh[2];
	char q[3]={0};
	printf("请输入：（必须加“=”）\n");
	scanf("%s",ch);    
	n=strlen(ch)-1;

	for(i=0;i<=n-1;i++)                                       //分离符号
	{
		if(ch[i]<48)
		{
			sh[m]=i;
			m=m+1; 
		}
	}

		if(m==1)                                               //两位运算
	{
        for(i=0;i<sh[0];i++)                                   //转化字符
		{
		    q[0]=q[0]+(ch[i]-48)*pow(10,(sh[0]-i-1));
		} 
		for(i=sh[0]+1;i<n;i++)
		{
		    q[1]=q[1]+(ch[i]-48)*pow(10,(n-i-1));
		}

		if(ch[sh[0]]==42)                                       //运算
			p=q[0]*q[1];
		if(ch[sh[0]]==43)
			p=q[0]+q[1];
		if(ch[sh[0]]==45)
			p=q[0]-q[1];
		if(ch[sh[0]]==47)
			p=q[0]/q[1];
	}

	if(m==2)                                                    //三位运算
	{
		for(i=0;i<sh[0];i++)
		{
	       	q[0]=q[0]+(ch[i]-48)*pow(10,(sh[0]-i-1));
		}

     	for(i=sh[0]+1;i<sh[1];i++)
		{
		   q[1]=q[1]+(ch[i]-48)*pow(10,(sh[1]-i-1));
		}
	
	    for(i=sh[1]+1;i<n;i++)
		{
		   q[2]=q[2]+(ch[i]-48)*pow(10,(n-i-1));
		}

		if(ch[sh[0]]==42&&ch[sh[1]]==42)
		    p=q[0]*q[1]*q[2];
	    else if(ch[sh[0]]==42&&ch[sh[1]]==43)
		    p=q[0]*q[1]+q[2];
	    else if(ch[sh[0]]==42&&ch[sh[1]]==45)
		    p=q[0]*q[1]-q[2];
	    else if(ch[sh[0]]==42&&ch[sh[1]]==47)
		    p=q[0]*q[1]/q[2];
	    else if(ch[sh[0]]==43&&ch[sh[1]]==42)
		    p=q[0]+q[1]*q[2];
	    else if(ch[sh[0]]==43&&ch[sh[1]]==43)
		    p=q[0]+q[1]+q[2];
	    else if(ch[sh[0]]==43&&ch[sh[1]]==45)
		    p=q[0]+q[1]-q[2];
	    else if(ch[sh[0]]==43&&ch[sh[1]]==47)
		    p=q[0]+q[1]/q[2];
	    else if(ch[sh[0]]==45&&ch[sh[1]]==42)
		    p=q[0]-q[1]*q[2];
    	else if(ch[sh[0]]==45&&ch[sh[1]]==43)
	     	p=q[0]-q[1]+q[2];
    	else if(ch[sh[0]]==45&&ch[sh[1]]==45)
	    	p=q[0]-q[1]-q[2];
	    else if(ch[sh[0]]==45&&ch[sh[1]]==47)
	    	p=q[0]-q[1]/q[2];
    	else if(ch[sh[0]]==47&&ch[sh[1]]==42)
	    	p=q[0]/q[1]*q[2];
	    else if(ch[sh[0]]==47&&ch[sh[1]]==43)
	    	p=q[0]/q[1]+q[2];
	    else if(ch[sh[0]]==47&&ch[sh[1]]==45)
	    	p=q[0]/q[1]-q[2];
	    else if(ch[sh[0]]==47&&ch[sh[1]]==47)
	    	p=q[0]/q[1]/q[2];
	}

	printf("%d\n",p);
	
	return 0;
}