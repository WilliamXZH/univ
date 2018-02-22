#include<iostream>
#include<vector>
using namespace std;

int main(){
	int t;
	cin>>t;
	for(int i=0;i<t;i++){
		int n;
		vector<int> v;
		cin>>n;
		for(int j=0;j<n;j++){
			int x,y;
			bool fx = false;
			bool fy = false;
			cin>>x>>y;
			for(int k=0;k<v.size();k++){
				if(x==v[k]){
					fx=true;
					//vector<int>::iterator it = vec.begin()+k;
					v.erase(v.begin()+k);
					break;
				}else if(y==v[k]){
					fy=true;
					v.erase(v.begin()+k);
					break;
				}
			}
			if(!fx){
				v.push_back(x);
			}
			if(!fy){
				v.push_back(y);
			}
		}
		if(v.size()<=2){
			cout<<"YES"<<endl;
		}else{
			cout<<"NO"<<endl;
		}
	}
}