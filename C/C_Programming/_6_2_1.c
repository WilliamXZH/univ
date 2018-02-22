#include<stdio.h>
long fac(int n)
{
	long t=1;
	int k;
	for(k=2;k<=n;k++)t*=k;
	return t;
}
void main()
{
	long cmn;
	int m,n,t;
	printf("intput m,n=");
	scanf("%d,%d",&m,&n);
	if(m<n)
	{
		t=m;
		m=n;
		n=t;
	}
	cmn=fac(m)/(fac(n)*fac(m-n));
	printf("cmn=%ld\n",cmn);
}