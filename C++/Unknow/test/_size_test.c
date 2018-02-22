#include<stdio.h>


struct test
{
	char c;
	//bool d;
	short d;
	short e;
	double z;
	int y;
	//short x;
};

struct ts
{
	int i;
	char a;
	char b;
};

void main(){
	printf("%d\n",sizeof (struct ts) );
	printf("%d\n",sizeof(struct test));
}