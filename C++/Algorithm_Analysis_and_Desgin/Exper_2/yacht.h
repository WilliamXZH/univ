#include<fstream>
#include<STRING>
using namespace std;

class yacht{
private:
	int n;
	int **p;
public:
	/* read the input from the file. */
	void readFile(string filename);
	/* write the result into the file. */
	void writeFile(string filename);

	/* the concrete algorithm with recursion. */
	int result(int i,int j);
};
int yacht::result(int i,int j){
	cout<<i<<"\t"<<j<<endl;

	if(i==j)return p[i][j];

	int r=INT_MAX;
	for(int k=i+1;k<n;k++){
		int rt=p[i][k]+result(k,j);
		if(r>rt){
			r=rt;
		}
	}
	return r;

}

void yacht::readFile(string filename){
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
	
	p=new int*[n];//may be different in different compiler.
	for(int i=0;i<n;i++){
		p[i]=new int[n];
		for(int j=0;j<n;j++){
			if(j<=i)p[i][j]=0;
			else fin>>p[i][j];
		}
	}
	cout<<"read file finished!"<<endl;
	fin.close();
}

void yacht::writeFile(string filename){
	ofstream fout(filename.c_str());
	
	fout<<result(0,n-1);

	fout.close();
}