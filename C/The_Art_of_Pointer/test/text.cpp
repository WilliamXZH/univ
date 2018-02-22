#include<stdio.h>

void main(){
	int i,j,k;
	int a[][3] = {1,2,3,4,5,6,7,8,9};
	for(i=0;i<3;i++){
		for(j=0;j<3;j++){
			printf("%d\t%d\n",a[i][j],&a[i][j]);
		}
	}
	printf("%d\n",*a[2]);
}