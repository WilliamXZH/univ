#include<FSTREAM>
#include<string>
using namespace std;

class coin{
private:
	int n,t;
	int *T;
public:
	/* read the input from the file. */
	void readFile(string filename);
	/* write the result into the file. */
	void writeFile(string filename);
	
	/* the most important recursion function to count the least number. */
	int change(int i,int j,int c);
};

int coin::change(int i,int j,int c){
	cout<<i<<"\t"<<j<<"\t"<<c<<endl;

	if(j==0)return c;

	else if(i==0){
		if(j<T[i]){
			return INT_MAX;
		}else if(j>=T[i]){
			return change(i,j-T[i],++c);
		}
	}else{
		if(j<T[i]){
			return change(i-1,j,c);
		}else{
			int c1=change(i-1,j,c);
			int c2=change(i,j-T[i],++c);
			return c1<c2?c1:c2;
		}
	}
}

void coin::readFile(string filename){
	ifstream fin(filename.c_str());
	
	cout<<filename<<endl;
	if(!fin){
		cout<<"file cannot open!"<<endl;
		//return ;
		exit(0);
	}else if(fin.eof()){
		cout<<"file is null."<<endl;
		exit(0);
	}

	fin>>n;

	T=new int[n];
	for(int i=0;i<n;i++){
		fin>>T[i];
	}
	fin>>t;
	cout<<"read file finished!"<<endl;
	fin.close();
}
void coin::writeFile(string filename){
	ofstream fout(filename.c_str());
	
	int r=change(n-1,t,0);
/*	if(r==INT_MAX){
		fout<<¡Þ;
	}else{*/
		fout<<r;
//	}

	fout.close();
}
