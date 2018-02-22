#include<reg51.h>
#include<stdio.h>
main(){
/*	char data *p1,*p2;
	xdata int a;
	p1=0x20;
	*p1=0x04;
	p2=0x35;
	*p2=0x05;
	a=*p1*(*p2);
	printf("The result is %x",a);
	return(0);*/
	unsigned int a,k,*p3;
	char i,*p1,*p2;
	p1=0x20;
	p2=0x25;
	p3=0x30;
	a=*p3;
	printf("%d",a);
	k=10000;
	while(a/k==0)k/=10;
	for(i=0;a!=0;i++){
		*p2=a/k;
		a=a%k;
		p2++;
		k/=10;
		*p1=i;
	}
} 