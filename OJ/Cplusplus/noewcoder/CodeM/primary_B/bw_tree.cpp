#include<iostream>
using namespace std;

int get(int n,int *depth,bool *flag){
	int tmp = -1;
	//cout<<"get"<<endl;;
	for(int i=0;i<n;i++){
		//cout<<tmp<<":"<<flag[i]<<depth[i]<<endl;
		if(flag[i]==false&&(tmp==-1||depth[i]>depth[tmp])){
			tmp=i;
		}
	}
	//cout<<tmp<<"end_get"<<endl;
	return tmp;
}

void set(int n,int k,int cur,int *last,bool *flag){
	//cout<<"set:"<<cur;
	for(int i=0;i<k;i++){
		flag[cur] = true;
		cur = last[cur];
		if(cur==-1)break;
		//cout<<cur;
	}
	//cout<<"end_set"<<endl;
}

int main()
{
	int n;
	int *k;
	int *last;
	int *depth;
	bool *flag;

	cin>>n;
	
	k = new int[n];
	last = new int[n];
	depth = new int[n];
	flag = new bool[n];

	int liv;
	last[0]=-1;
	depth[0]=0;
	for(liv=1;liv<n;liv++){
		cin>>last[liv];
		last[liv]--;
		int liv_d=1;
		int liv_sub=last[liv];
		while(liv_sub!=0){
			liv_sub=last[liv_sub];
			liv_d++;
		}
		depth[liv]=liv_d;
		//cout<<liv<<'\t'<<last[liv]<<'\t'<<depth[liv]<<endl;
	}
	for(liv=0;liv<n;liv++){
		flag[liv] = false;
		cin>>k[liv];
	}

	int count = 0;
	while((liv=get(n,depth,flag))!=-1){
		//cout<<liv<<'\t'<<depth[liv]<<endl;
		set(n,k[liv],liv,last,flag);
		count++;
		//getchar();
	}
	cout<<count;
}