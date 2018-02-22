#include<iostream>
using namespace std;

int sizestr(char str[]);
int dstr(char str[],int l);
bool cmpstr(char str[],int x);

int main(){
	char str[201];
	cin>>str;
	cout<<dstr(str,sizestr(str));

	return 0;
}


int sizestr(char str[]){
	int i=0;
	while(str[++i]!='\0');
	return i;
}

int dstr(char str[],int l){
	if(l%2!=0){
		l--;
	}else{
		l -= 2;
	}

	while(l!=0){
		if(cmpstr(str,l/2)){
			break;
		}
		l -= 2;
	}
	return l;
}
bool cmpstr(char str[],int x){
	int i=x-1;
	int j=2*x-1;
	while(i!=-1&&str[i--]==str[j--]);
	//cout<<x<<'\t'<<i<<endl;
	return i==-1;
}