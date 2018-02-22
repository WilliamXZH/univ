#include<reg51.h>
#include<stdio.h>
main(){
	char data *p1,*p2;
	xdata int a;
	p1=0x20;
	*p1=0x04;
	p2=0x35;
	*p2=0x05;
	a=*p1*(*p2);
	printf("The result is %x",a);
	return(0);
} 
