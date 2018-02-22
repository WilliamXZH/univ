#include<iostream>
using namespace std;

int len(char *s){
	int c = 0;
	while(s[c++]!='\0');
	return c;
}

void dfs(char *s,char *t,int l,int i,int j,int si,int ti){
	if(si>=l||ti>=i){
		return;
	}else if(si==l&&ti==i){
		t[ti] = '\0';
		cout<<t<<'\t';
	}


}

int main(){
	char s[100];
	char t[100];
	while(cin>>s){
		int l = len(s);
		for(int i=0;i<l;i+=2){
			for(int k=0;k<l-i*2;k++)t[k]=s[k]-'1'+'a';
			for(int j=l-i*2-1;j>=0;j--){
				dfs(s,l,i/2,j);
			}
		}
	}
}