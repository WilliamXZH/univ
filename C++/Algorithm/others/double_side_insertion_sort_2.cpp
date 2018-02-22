#include<iostream>
using namespace std;

void func(int r[],int n){
	int i,j,low,high,m;
	int *d = new int[n];

	d[0] = r[0];
	int first = 0;
	int final = 0;
	cout<<d[0]<<'?'<<endl;

	for(i=1;i<n;i++){
		//cout<<r[i]<<endl;;
		if(r[i]>=d[0]){
			low = 0;
			high = final;
			while(low<=high){
				m = (low+high)/2;
				if(r[i]<d[m]){
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
			cout<<d[high]<<endl;
		}else{
			if(first==0){
				first = n-1;
				d[n-1] = r[i];
			}else{
				low = first;
				high = n-1;
				while(low<=high){
					m=(low+high)/2;
					if(r[i]<d[m]){
						high = m-1;
					}else{
						low = m+1;
					}
				}
				for(int j=first;j<=high;j++){
					d[j-1] = d[j];
				}
				d[high] = r[i];
				first--;
				cout<<d[high]<<endl;
			}
		}
	}
	r[0] = d[first];
	for(i=(first+1)%n,j=1;i!=first;i=(i+1)%n,j++){
		r[j] = d[i];
		cout<<d[j]<<'-';
	}
	cout<<endl;
}

int main(){
	
	int r[10] = {2,4,6,8,0,1,3,5,7,9};
	func(r,10);
	for(int i=0;i<10;i++){
		cout<<r[i]<<' ';
	}

}