#include<stdio.h>

int len(int p[]){
	return sizeof(p)/sizeof(p[0]);
}
bool find(int p[],int n,int x){
	int high = n-1;
	int low = 0;
	int mid;// = (high+low)/2;
	//printf("%d\t",high);
	while(low<=high){
		mid = (high+low)/2;
		if(p[mid]==x)return true;
		else if(p[mid]<x)low = mid+1;
		else high = mid-1 ;
		printf("%d-%d-%d\n",low,mid,high);
	}
	return false;
}
bool find2(int p[],int n,int x){
	int high = n;
	int low = 0;
	int mid;
	while(low<high){
		mid = (low+high)/2;
		if(p[mid]==x)return true;
		else if(p[mid]<x) low = mid+1;
		else high = mid;
	}
	return false;
}

int find3(int p[],int n,int x){
	int mid;
	int right = n;
	int left = 0;
	while(left<right){
		mid = (left+right)/2;
		if(p[mid]==x)return true;
		else if(p[mid]<x)left = mid+1;
		else right = mid-1;
	}
	return false;
}
void main(){
	int i,j;
	int p[] = {1,2,3,4,5};
	for(i=0;i<=6;i++){
		printf("%d:%d\n",i,find3(p,5,i));
	}
}