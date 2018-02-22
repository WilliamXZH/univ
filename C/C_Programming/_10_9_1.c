#include<stdio.h>
void main()
{
	struct bs
	{
		unsigned a:2;
		unsigned b:6;
		unsigned c:4;
		int i;
	};
	struct bs data;
	data.a=1;
	data.b=7;
	data.c=17;
	data.i=1000;
	printf("data.a=%d \ndata.b=%d \ndata.c=%d \ndata.i=%d\n",data.a,data.b,data.c,data.i);
}