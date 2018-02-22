#include<iostream>
#include<set>
using namespace std;

int main(){
	int n,m;
	int i,j,k,l;
	cin>>n>>m;
	int **d = new int*[n];
	for(i=0;i<n;i++){
		d[i] = new int[n];
		for(j=0;j<n;j++){
			d[i][j] = 0;
		}
	}
	for(i=0;i<n;i++){
		if(i<n-1){
			cin>>d[i][i+1];
			d[i+1][i] = d[i][i+1];
		}else{
			cin>>d[0][n-1];
			d[n-1][0] = d[0][n-1];
		}
	}
	for(i=0;i<m;i++){
		int u,v,w;
		cin>>u>>v>>w;
		d[u-1][v-1] = w;
		d[v-1][u-1] = w;
	}

//	for(i=0;i<n;i++){
//		for(j=0;j<n;j++){
//			cout<<d[i][j]<<' ';
//		}
//		cout<<endl;
//	}

	int q;
	cin>>q;
	for(l=0;l<q;l++){
		int x,y;
		cin>>x>>y;
		x--;
		y--;
		long *b = new long[n];
		for(i=0;i<n;i++){
			if(i==x){
				b[i] = 0;
			}else{
				b[i] = 2147483647;
			}
		}
		int t = x;
		set<long> s;
		while(true){
			for(i=0;i<n;i++){
				if(i!=x&&d[t][i]!=0&&b[t]+d[t][i]<b[i]){
					b[i] = b[t]+d[t][i];
					s.insert(i);
				}
			}
			if(s.size()==0){
				break;
			}else{
				set<long>::iterator iter = s.begin();
				t = *iter;
				s.erase(t);
			}
//			cout<<s.size()<<' '<<t<<' '<<b[t]<<endl;
//			for(i=0;i<n;i++){
//				cout<<b[i]<<' ';
//			}
//			cout<<endl;
		}
		printf("%lld",b[y]);
	}
}