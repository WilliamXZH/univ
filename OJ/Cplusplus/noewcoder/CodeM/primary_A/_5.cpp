#include<iostream>
using namespace std;


void swap(int &a,int &b){
	a = a^b;
	b = a^b;
	a = a^b;
}
bool test(int a,int b){
	if(a<b){
		swap(a,b);
	}

	while(a%b!=0){
		a = a-b;
		if(a<b){
			swap(a,b);
		}
	}

	if(b==1)return true;
	else return false;
}

int print(int n,int a[],int l,int r,int k){
	int count = 0;
	int size = 0;

	//int length = r-l+1;
	//bool *f = new bool[r-l+1];
	int *c = new int[r-l+1];
	int *num = new int[r-l+1];

	for(int i=l;i<=r;i++){
		bool flag = false;
		int sub = 0;

		for(int j=0;j<size;j++){
			if(a[i]==num[j]){
				flag = true;
				sub = j;
			}
		}

		if(flag){
			c[sub]++;
		}else{
			c[size] = 1;
			num[size] = a[i];
			size++;
		}
	}

	for(int liv = 0;liv<size;liv++){
		cout<<num[liv]<<":"<<c[liv]<<endl;
		if(test(c[liv],k)){
			count++;
		}
	}

	return count;

}

void count(int n,int m,int a[],int l[],int r[],int k[]){
	for(int i=0;i<m;i++){
		cout<<print(n,a,l[i]-1,r[i]-1,k[i]);

		if(i!=m-1){
			cout<<endl;
		}
	}
}

int main(){
	int n,m;
	int *a,*l,*r,*k;

	cin>>n>>m;

	a = new int[n];
	l = new int[m];
	r = new int[m];
	k = new int[m];

	for(int i=0;i<n;i++){
		cin>>a[i];
	}
	for(int j=0;j<m;j++){
		cin>>l[j]>>r[j]>>k[j];
	}
	count(n,m,a,l,r,k);
}