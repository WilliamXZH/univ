#include<FSTREAM>
#include<STRING>
using namespace std;

template<class T>
class median{
private:
	/* it seems to the account of the array-x or array-y. */
	int n;
	/* it presents the median, but seems no useful. */
	T mid;
	/* used to store the values of the two array. */
	T *x,*y;
public:
	/* print the content read from file. */
	void PrintFile();

	/* read the file content according to the parameter filename. */
	void ReadFile(string filename);

	/* write the median to the file who's name is parameter filename. */
	void WriteFile(string filename);

	/* get the median, which is the main DC algorithm. */
	double GetMedian(T *x,T *y,int len);
	/* I don't know whether the returned value should be double or T type. */
	//T GetMedian(T *x,T *y,int len);
};

template<class T>
void median<T>::PrintFile(){
	cout<<n<<endl;
	for(int i=0;i<n;i++){
		cout<<x[i];
		if(i<n-1){
			cout<<" ";
		}
		else{
			cout<<"\n";
		}
	}
	for(int j=0;j<n;j++){
		cout<<y[j];
		if(j<n-1){
			cout<<" ";
		}else{
			cout<<"\n";
		}
	}
}

template<class T>
void median<T>::ReadFile(string filename){
	ifstream fin(filename.c_str());
	//fin=open(filename.c_str(),ios::in);
	
	if(!fin){
		cout<<"file cannot open!"<<endl;
		//return ;
		exit(0);
	}else if(fin.eof()){
		cout<<"file is null."<<endl;
		exit(0);
	}

	fin>>n;
	x=new T[n];
	y=new T[n];
	for(int i=0;i<n;i++){
		fin>>x[i];
		if(fin.bad()||fin.fail()||i!=0&&x[i]<x[i-1]){
			cout<<"error in read file content."<<endl;
			//return;
			//system("pause");
			exit(0);
		}
	}
	for(int j=0;j<n;j++){
		fin>>y[j];
		if(fin.bad()||fin.fail()||j!=0&&y[j]<y[j-1]){
			cout<<"error in read file."<<endl;
			system("pause");
			exit(0);
		}
	}

	fin.close();
}
template<class T>
double median<T>::GetMedian(T *x,T *y,int len){
	if(len==1){
		cout<<x[len-1]<<"\t"<<y[len-1]<<endl;
		return (x[len-1]+y[len-1])/2.0;
	}
	if(len%2==0){
		int tmp=len/2;
		if(x[tmp-1]<y[tmp-1]){
			if(x[tmp]<y[tmp]){
				return GetMedian(y,x+tmp,tmp);
			}else{
				return GetMedian(y,y+tmp,tmp);
			}
		}else{
			if(x[tmp]<y[tmp]){
				return GetMedian(x,x+tmp,tmp);
			}else{
				return GetMedian(x,y+tmp,tmp);
			}
		}
	}else{
		int tmp=(len-1)/2;
		if(x[tmp]<y[tmp]){
			return GetMedian(x+tmp,y,tmp+1);
		}else{
			return GetMedian(x,y+tmp,tmp+1);
		}
	}
}

template<class T>
void median<T>::WriteFile(string filename){
	ofstream fout(filename.c_str());
	fout<<GetMedian(x,y,n);

	fout.close();
}