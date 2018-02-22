#include<iostream>
using namespace std;

int main(){
	int n;
	scanf("%d",&n);;
	int *a = new int[n];
	for(int i=0;i<n;i++){
		scanf("%d",&a[i]);
	}
	int m;
	scanf("%d",&m);
	while(m--){
		int l,r;
		scanf("%d %d",&l,&r);
		if(r-l<2){
			printf("0\n");
		}else{
			int c = 0;
			int t = r-l-1;
			for(int j=l-1;j<r-2;j++){
				if(a[j]<=a[j+1]&&a[j+1]<=a[j+2]){
					c++;
				}
			}
			printf("%d\n",c);
		}
	}
}