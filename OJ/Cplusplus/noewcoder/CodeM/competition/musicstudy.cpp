#include<iostream>
using namespace std;
//#define square(x) (x*x)
int square(int x){
	return x*x;
}
int minDiff(int n,int *a,int m,int *b);
int difference(int n,int *a,int *b);

void print(int n, int *a){
	for(int i=0;i<n;i++){
		cout<<a[i]<<'\t';
	}
	cout<<endl<<endl;
}

int main(){
	int n;
	int *first;

	cin>>n;
	first = new int[n];

	for(int i=0;i<n;i++){
		cin>>first[i];
	}

	int m;
	int *second;

	cin>>m;

	if(m<n)return 0;
	
	second = new int[m];

	for(int j=0;j<m;j++){
		cin>>second[j];
	}

	cout<<minDiff(n,first,m,second);

	return 0;
}


int minDiff(int n,int *a,int m,int *b){
	int min = -1;
	int l = m-n+1;
	for(int i=0;i<l;i++){
		int diff = difference(n,a,&b[i]);
		//cout<<diff<<endl;
		min = diff<min||min<0?diff:min;
	}

	return min;
}

int difference(int n,int *a,int *b){
	int res = 0;

//	print(n,a);
//	print(n,b);

	for(int i=0;i<n;i++){
		res += square((a[i]-b[i]));
	}
//	cout<<res<<endl;

	return res;
}
