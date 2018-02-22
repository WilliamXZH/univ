#include<stdio.h>
void main(){
	int i=4,a=0;
	a=(i++)+(++i)+(i--)+(--i);
	printf("%d\n",a);
}