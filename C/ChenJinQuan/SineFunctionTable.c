#include<math.h>
#include<stdio.h>

#define pi 3.141592653589

void main()
{
	int i, j;
	int sinx[180];
	for (i=0;i<18;i++)
	{
		for(j=0;j<10;j++)
		{
			double x = pi*(i*20+j*2)/180;
			sinx[i*10+j] = (int)127*sin(x)+128;
			//why not is 128*sin(x) referenced to question???
			
			printf("%02x ",sinx[i*10+j]);
		}
		for(j=0;j<sinx[i*10]/6;j++){
			printf(" ");
		}
		printf("*\n");
		for(j=0;j<30;j++)printf(" ");
		for(j=0;j<sinx[i*10+5]/6;j++){
			printf(" ");
		}
		printf("*\n");
	}
//	for(i=0;i<18;i++){
//		for(j=0;j<sinx[i*10]/5;j++){
//			printf(" ");
//		}
//		printf("*\n");
//	}
}