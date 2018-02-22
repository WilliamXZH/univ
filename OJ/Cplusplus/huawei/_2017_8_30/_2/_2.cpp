#include<iostream>
using namespace std;
void  convertTo26(const char *input, char *output){
	int r = 0;
	//cout<<input<<endl;
	for(int i=0;input[i]!='\0';i++){
		if(input[i]<97||input[i]>122){
			char *err = "ERROR";
			int k=0;
			while((output[k]=err[k++])!='\0');
			//cout<<output<<endl;
			return;
		}
		r *= 26;
		r += input[i]-'a'+1;
	}
	int d = 10;
	while(r/d!=0)d*=10;
	//output = new char[10];
	d/=10;
	//cout<<r<<":"<<d<<endl;
	int j=0;
	for(;r!=0;d/=10,j++){
		output[j] = r/d+'0';
		r %= d;
	}
	output[j]='\0';
	//cout<<output<<endl;
}
int main(){
	char p[7],q[10];
	cin>>p;
	//cout<<p;
	convertTo26(p,q);
	cout<<q;
}