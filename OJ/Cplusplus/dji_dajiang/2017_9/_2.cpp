#include<iostream>
using namespace std;

void set(int **p,int n,int m){
	for(int i=0;i<n;i++){
		for(int j=0;j<m;j++){
			if(p[i][j]>1){
				for(int k=1;k<p[i][j];k++){
					if(i-k>=0){
						p[i-k][j]=1;
					}
					if(j-k>=0){
						p[i][j-k]=1;
					}
					if(i+k<n){
						p[i+k][j]=1;
					}
					if(j+k<m){
						p[i][j+k]=1;
					}
				}
			}
		}
	}
}

int ox,oy;
int get(int **p,int n,int m,int x,int y,int c){
	//cout<<x<<":"<<y<<"?"<<c<<endl;
	if(x==ox&&y==oy){
		return c;
	}
	int min = n*m;
	if(x>0&&p[x-1][y]==0){
		p[x-1][y]=1;
		int tmp = get(p,n,m,x-1,y,c+1);
		p[x-1][y]=0;
		if(tmp!=-1&&tmp<min)min=tmp;
	}
	if(x+1<n&&p[x+1][y]==0){
		p[x+1][y]=1;
		int tmp = get(p,n,m,x+1,y,c+1);
		p[x+1][y]=0;
		if(tmp!=-1&&tmp<min)min=tmp;
	}
	if(y>0&&p[x][y-1]==0){
		p[x][y-1]=1;
		int tmp = get(p,n,m,x,y-1,c+1);
		p[x][y-1]=0;
		if(tmp!=-1&&tmp<min)min=tmp;
	}
	if(y+1<m&&p[x][y+1]==0){
		p[x][y+1]=1;
		int tmp = get(p,n,m,x,y+1,c+1);
		p[x][y+1]=0;
		if(tmp!=-1&&tmp<min)min=tmp;
	}
	if(min==n*m)return -1;
	else return min;
}

int main(){
	int n,m;
	int tx,ty;
	while(cin>>n>>m){
		cin>>tx>>ty;
		cin>>ox>>oy;
		int **p = new int*[n];
		for(int i=0;i<n;i++){
			p[i] = new int[m];
			for(int j=0;j<m;j++){
				cin>>p[i][j];
			}
		}
		//cout<<"set"<<endl;
		set(p,n,m);
		//cout<<"set!"<<endl;
		cout<<get(p,n,m,tx,ty,0)<<endl;
		for(int k=0;k<n;k++){
			delete p[k];
		}
		delete p;
	}
}