//#include<string>
#include<FSTREAM>
using namespace std;

template<class T>
class load{
private:
	int n,*r;
	T c,m,cw,bcw,*w;
public:
	void readFile(char *filename);
	void writeFile(char *filename);

	void backTrackByIte();
	void backTrackByIte_1();
	bool backTrackByRec(int t,T cw);
	void backTrackByRec_1(int i);
	void backTrackByRec_2(int i);
};

template<class T>
void load<T>::backTrackByIte(){
	int i=0;
	bool flag[]=new bool[n];
	bool bt=flase;

	while(true){
		if(i>=n){
			if(cw>bcw){
				bt=true;
				i--;
			}
			bool test=false;
			for(int x=0;x<n;x++){
				if(flag[x]){
					test=true;
					break;
				}
			}

			if(!test){
				break;
			}
		}else{	
			if(!bt){
				if(!flag[i]&&cw+w[i]<=c){
					flag[i]=true;
					cw+=w[i];
					m-=w[i];
					i++;
				}else{
					m-=w[i];

					if(cw+m>bcw){
						i++;
						flag[i]=false;
					}
					i++;
				}
			}else{
				
			}

		}
	}
}

template<class T>
void load<T>::backTrackByIte_1(){
	int i=0;
	int *tr=new int[n+1];

	//cout<<"backtrace"<<endl;
	while(true){
		//cout<<i<<" ";
		while(i<n&&cw+w[i]<=c){
			m-=w[i];
			cw+=w[i];
			tr[i]=1;
			i++;
		}
		if(i>=n){
			for(int j=0;j<n;j++){
				r[j]=tr[j];
			}
			bcw=cw;
		}else{
			m-=w[i];
			tr[i]=0;
			i++;
		}

		while(cw+m<=bcw){
			i--;
			while(i>=0&&!tr[i]){
				m+=w[i];
				i--;
			}

			if(i==-1){
				delete []tr;
				return;
			}
			tr[i]=0;
			cw-=w[i];
			i++;
		}
	}
}

template<class T>
bool load<T>::backTrackByRec(int t,T cw){
	cout<<t<<"\t"<<cw<<endl;

	if(t>=n){
		if(cw>bcw){
			bcw=cw;
			return true;
		}else return false;
	}else{
		bool flag=false;
		if(cw+w[t]<=c){
			if(backTrackByRec(t+1,cw+w[t])){
				flag=true;
				r[t]=1;
			}
		}
		if(backTrackByRec(t+1,cw)){
			flag=true;
			r[t]=0;
		}

		return flag;
	}

}

template<class T>
void load<T>::backTrackByRec_1(int i){
	if(i>=n){
		bcw=cw;
		return;
	}

	m-=w[i];

	if(cw+w[i]<=c){
		cw+=w[i];
		r[i]=1;
		backTrackByRec_1(i+1);
		cw-=w[i];
	}

	if(m+cw>bcw){
		r[i]=0;
		backTrackByRec_1(i+1);
	}

	m+=w[i];
}

template<class T>
void load<T>::backTrackByRec_2(int i){
	if(i>=n){
		bcw=cw;
		return;
	}

	m-=w[i];
	if(cw+w[i]<=c){
		r[i]=1;
		cw+=w[i];
		backTrackByRec_2(i+1);
		cw-=w[i];
	}

	if(cw+m>bcw){
		r[i]=0;
		backTrackByRec_2(i+1);
	}
	m+=w[i];

}


template<class T>
void load<T>::writeFile(char *filename){
	ofstream fout(filename);
	
	backTrackByIte_1();
	//backTrackByRec(0,0);
	//backTrackByRec_1(0);
	//backTrackByRec_2(0);

	for(int i=0;i<n;i++){
		cout<<r[i]<<"\t";
		fout<<r[i]<<"\t";
	}

	fout.close();
}

template<class T>
void load<T>::readFile(char *filename){
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
	r=new int[n];
	
	cout<<n<<"\t"<<c<<endl;

	m=0;
	cw=0;
	bcw=0;
	for(int i=0;i<n;i++){
		fin>>w[i];
		m+=w[i];
	}

	cout<<"read file finished!"<<endl;
	fin.close();
}

