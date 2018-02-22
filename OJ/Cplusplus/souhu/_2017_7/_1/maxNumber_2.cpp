#include<iostream>
#include<string>
using namespace std;

void print(int f[],int n){
	//int l = sizeof(f)/sizeof(int);
	for(int i=0;i<n;i++){
		cout<<f[i]<<' ';
	}
	cout<<endl;
}

int main(){
	int cnt;
	string v;
	cin>>v>>cnt;
	//vector<int> v;
	int *f = new int[cnt];
	for(int i=0;i<cnt;i++){
		f[i] = -1;
	}
	int size = v.size();
	for(int j=0;j<size;j++){
		int tmp = -1;
		for(int k=0;k<cnt;k++){
			if(f[k]<0||v[j]<v[f[k]]){
				//cout<<"comp:"<<v[j]<<":"<<v[f[k]]<<endl;
				//tmp = f[k];
				for(int l=cnt-1;l>k;l--){
					if(f[l-1]<0){
						continue;
					}else{
						f[l]=f[l-1];
					}

				}
				f[k] = j;
				//print(f,cnt);
				//cout<<f[k]<<endl;
				break;
			}
		}
	}
	//print(f,cnt);
	for(int x=0;x<size;x++){
		bool flag = true;
		for(int y=0;y<cnt&&f[y]>=0;y++){
			if(x==f[y]){
				flag = false;
				break;
			}
		}
		if(flag){
			cout<<v[x];
		}
	}

}