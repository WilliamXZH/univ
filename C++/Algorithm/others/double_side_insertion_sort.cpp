#include<iostream>
#include<vector>
using namespace std;

typedef struct node 
{
	int key;
}vec;

void func(vec r[],vec d[],int n){
	int i,j,low,high,m;

	d[1] = r[1];
	int first = 1;
	int final = 1;

	for(i=2;i<=n;i++){
		if(r[i].key>=d[1].key){
			low = 1;
			high = final;
			while(low<=high){
				m = (low+high)/2;
				if(r[i].key<d[m].key){
					high = m-1;
				}else{
					low = m+1;
				}
			}
			for(int j=final;j>=high+1;j--){
				d[j+1] = d[j];
			}
			d[high+1] = r[i];
			final++;
		}else{
			if(first==1){
				first = n;
				d[n] = r[i];
			}else{
				low = first;
				high = n;
				while(low<=high){
					m=(low+high)/2;
					if(r[i].key<d[m].key){
						high = m-1;
					}else{
						low = m+1;
					}
				}
				for(int j=first;j<high;j++){
					d[j-1] = d[j];
				}
				d[high] = r[i];
				first--;
			}
		}
	}
	r[1] = d[first];
	for(i=first%n+1,j=2;i!=first;i=i%n+1,j++){
		r[j] = d[j];
	}
}
int main(){
}