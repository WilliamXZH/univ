#include<iostream>
#include<set>
#include<vector>
using namespace std;
using std::set;

struct xy
{
	int x;
	int y;
};

struct comp
{
	bool operator()(const xy &a, const xy &b){
		return a.x<b.x;
	}
};

int main(){
	int n;
	cin>>n;
	int *x = new int[n];
	int *y = new int[n];
	for(int i=0;i<n;i++){
		cin>>x[i]>>y[i];
	}
	set<xy,comp> s;
	vector<int> vec;
	for(int j=0;j<n;j++){
		bool next = false;
		for(int liv_i=0;liv_i<vec.size();liv_i++){
			if(j==vec[liv_i]){
				next = true;
			}
		}
		if(next){
			continue;
		}

		bool gt = true;
		for(int k=0;k<n;k++){
			if(x[j]<x[k]&&y[j]<y[k]){
				gt = false;
			}

			if(x[j]>x[k]&&y[j]>y[k]){
				vec.push_back(k);
			}
		}
		if(gt){
			xy nxy;
			nxy.x=x[j];
			nxy.y=y[j];
			s.insert(nxy);
		}
	}
	set<xy,comp>::iterator iter = s.begin();
	for(;iter!=s.end();iter++){
		cout<<(*iter).x<<' '<<(*iter).y<<endl;
	}

	return 0;
}