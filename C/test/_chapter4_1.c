#include<stdio.h>
#include<stdlib.h>
#include<time.h>
#define n 30
void print(int num[]);
void bubbl(int num[]);
void choose(int num[]);
void main()
{
	int i,number[n];
	srand((unsigned)time(NULL));
	for(i=0;i<n;number[i]=rand(),i++);
	printf("ð������:����С����\n");
	bubbl(number);
	printf("ѡ������:���Ӵ�С��\n");
	choose(number);
}
void bubbl(int num[])
{
	int i,j,temp;
	print(num);
	for(i=0;i<n;i++)
	{
		for(j=i+1;j<n;j++)
		{
			if(num[i]>num[j])
			{
				temp=num[i];
				num[i]=num[j];
				num[j]=temp;
			}
		}
		//����printf("%d ",num[i]);
	}
	print(num);
}
void choose(int num[])
{
	int i,j,tem,p;
	printf("����ǰ:\n");
	print(num);
	for(i=0;i<n;i++)
	{
		for(p=i,j=i+1;j<n;j++)
			if(num[i]<num[j])p=j;
		tem=num[i];
		num[i]=num[p];
		num[p]=tem;
	}
	printf("�����:\n");
	print(num);
}
void print(int num[])
{
	int i;
	for(i=0;i<n;i++)
		printf("%d\t",num[i]);
	printf("\n");
}