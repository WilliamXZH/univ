#include<iostream>
using namespace std;

//int dep=0;
bool yes = false;
void sort(int q[],int d,bool asc){
	for(int j=0;j<d;j++){
		for(int i=d-1;i>j;i--){
			if(asc){
				if(q[i]<q[i-1]){
					int tmp = q[i];
					q[i] = q[i-1];
					q[i-1] = tmp;
				}
			}else{
				if(q[i]>q[i-1]){
					int tmp = q[i];
					q[i] = q[i-1];
					q[i-1] = tmp;
				}
			}
		}
		//cout<<q[j]<<' ';
	}
	//cout<<endl;
}
void print(int q[],int n){
	for(int i=0;i<n;i++){
		cout<<q[i]<<' ';
	}
	cout<<endl;
}

bool dfs(int p[],int n,int c,int k,int q[],int d){
	//cout<<k<<endl;
	if(k==0){
		if(!yes){
			yes = true;
			cout<<"YES"<<endl;
			sort(q,d,true);
			for(int l=0;l<d;l++){
				//q2[l] = q[l];
				cout<<q[l]<<(l<d-1?' ':'');
			}
			cout<<endl;
		}
		//dep = d;
		//int *q2 = new int[d];
		//sort(q2,d);
		return true;
	}else if(k<0){
		return false;
	}else if(c>=n){
		return false;
	}
	bool flag = false;
	for(int i=c;i<n;i++){
		q[d] = p[i];
		if(dfs(p,n,i+1,k-p[i],q,d+1)){
			flag = true;
			//return true;
		}
	}
	return flag;
}

int main(){
	int n,k;
	cin>>n>>k;
	int *p = new int[n];
	int *q = new int[n];
	for(int i=0;i<n;i++){
		cin>>p[i];
	}
	sort(p,n,false);
	if(!dfs(p,n,0,k,q,0)){
		cout<<"NO"<<endl;
	}
//	}else{
//		cout<<"YES"<<endl;
//		print(q,dep);
//	}
}