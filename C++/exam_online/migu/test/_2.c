#include<stdio.h>
void main(){
	int a[100],b[100];
	for(int i=0;scanf("%d %d",&a[i],&b[i])!=EOF;i++);
	for(int j=0;j<i;printf("%d\n",a[j]+b[j++]));
}