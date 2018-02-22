#include<iostream>
using namespace std;

int n,m;
int count(int **nums,int c[26],int cur,int total){
	//cout<<cur<<":"<<total<<":"<<c[cur]<<endl;
	if(cur>=26){
		if(total>=n&&total<=m){
			return 1;
		}else{
			return 0;
		}
	}
	int t = 0;
	for(int i=0;i<c[cur];i++){
		//cout<<nums[cur][i]<<endl;
		t += count(nums,c,cur+1,total+nums[cur][i]);
	}
	//cout<<"t:"<<t<<endl;
	return t;
}

int main(){
	int t;
	cin>>t;
	for(int i=0;i<t;i++){
		//int n,m;
		cin>>n>>m;
		//cout<<n<<"\t"<<m;
		int c[26];
		int *nums[26];
		for(int j=0;j<26;j++){
			cin>>c[j];
			c[j]++;
			nums[j] = new int[c[j]];
			for(int k=0;k<c[j];k++){
				nums[j][k]=k*(65+j);
				//cout<<nums[j][k]<<endl;
			}
		}
		cout<<"Case #"<<i<<": "<<count(nums,c,0,0)<<endl;
	}
	return 0;
}