#include<FSTREAM>
using namespace std;

class gray{
private:
	int n;
	string *p;
public:
	/* read the n from the file. */
	void readFile(string filename);

	/* write 2^n gray code into the file. */
	void writeFile(string filename);
	
	/*  */
	void getAscGray(int cur,int len,int m);
	/*  */
	void getDescGray(int cur,int len,int m);
};

void gray::readFile(string filename){
	ifstream fin(filename.c_str());
	fin>>n;
	int t=1;
	for(int i=0;i<n;i++){
		t*=2;
	}
	p=new string[t];
	//cout<<n<<'\t'<<sizeof(*p)<<endl;
	fin.close();
}
void gray::writeFile(string filename){
	
	ofstream fout(filename.c_str());
	int t=1;
	//cout<<"???"<<n<<endl;
	//p[0]="";
	for(int tmp=0;tmp<n;tmp++){
		t*=2;
		p[0]+='0';
		//cout<<p[0][tmp]<<endl;
	}
	//cout<<p[0]<<endl;

	getAscGray(0,t,0);
	for(int i=0;i<t;i++){
		fout<<p[i]<<"\n";
	}
}

void gray::getAscGray(int cur,int len,int m){
	if(len==0||len==1)return;

	p[cur+len-1]=p[cur];
	p[cur+len-1][m]=p[cur+len-1][m]=='0'?'1':'0';

	cout<<cur+len-1<<":"<<p[cur+len-1]<<endl;
	
	getAscGray(cur,len/2,m+1);
	getDescGray(cur+len-1,len/2,m+1);
}
void gray::getDescGray(int cur,int len,int m){
	if(len==0||len==1)return;

	p[cur-len+1]=p[cur];
	p[cur-len+1][m]=p[cur-len+1][m]=='0'?'1':'0';

	cout<<cur-len+1<<":"<<p[cur-len+1]<<endl;
	
	getDescGray(cur,len/2,m+1);
	getAscGray(cur-len+1,len/2,m+1);
}

