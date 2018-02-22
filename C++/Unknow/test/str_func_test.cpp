#include<iostream>
using namespace std;

int func(char *str,int n){
	cout<<str<<endl;
	int i =0;
	while(!(str[i]>='A'&&str[i]<='Z'||str[i]>='a'&&str[i]<='z'))i++;
	if(str[i]>'Z'||str[i]<'A'){
		cout<<"第一个字母不是大写字母"<<endl;
		return 0;
	}else{
		int c = 0;
		for(;i<n;i++){
			if(str[i]<='Z'&&str[i]>='A'){
				c++;
				cout<<str[i];
			}
		}
		cout<<endl;
		return c;
	}
}

int main(int argc, char **argv){
	if(argc<2){
		cout<<"未传入字符串!"<<endl;
	}else if(argc>2){
		cout<<"字符串数量过多!"<<endl;
	}else{
		cout<<"大写字母数:"<<func(argv[1],strlen(argv[1]))<<endl;
	}
	return 0;
}