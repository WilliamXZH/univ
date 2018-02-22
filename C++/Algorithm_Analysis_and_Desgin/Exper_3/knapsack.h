#include<fstream>
using namespace std;


template<class T,class Y>
class knap{
private:
	int n,*r;
	T c,*w,bcv;
	Y *v;
public:
	void readFile(char *filename);
	void writeFile(char *filename);

	bool backTrack(int i,T cw,Y cv);
};

template<class T,class Y>
bool knap<T,Y>::backTrack(int i,T cw,Y cv){
	if(i>=n){
		if(cv>bcv){
			bcv=cv;
			return true;
		}else return false;
	}else{
		bool flag=false;
		if(cw+w[i]<=c){
			if(backTrack(i+1,cw+w[i],cv+v[i])){
				flag=true;
				r[i]=1;
			}
		}
		if(backTrack(i+1,cw,cv)){
			flag=true;
			r[i]=0;
		}
		return flag;
	}
}

template<class T,class Y>
void knap<T,Y>::writeFile(char *filename){
	ofstream fout(filename);
	
	backTrack(0,0,0);
	
	for(int i=0;i<n;i++){
		cout<<r[i]<<"\t";
		fout<<r[i]<<"\t";
	}
	
	fout.close();
}

template<class T,class Y>
void knap<T,Y>::readFile(char *filename){
	ifstream fin(filename);
	
	cout<<filename<<endl;
	if(!fin){
		cout<<"file cannot open!"<<endl;
		//return ;
		exit(0);
	}else if(fin.eof()){
		cout<<"file is null."<<endl;
		exit(0);
	}
	
	cout<<"prepare to read file."<<endl;
	
	fin>>n>>c;
	w=new T[n];
	v=new Y[n];
	r=new int[n];
	
	cout<<n<<"\t"<<c<<endl;
	
	bcv=0;
	for(int i=0;i<n;i++){
		fin>>w[i];
	}

	for(int j=0;j<n;j++){
		fin>>v[j];
	}
	
	cout<<"read file finished!"<<endl;
	fin.close();
}
