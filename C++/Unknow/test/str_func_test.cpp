#include<iostream>
using namespace std;

int func(char *str,int n){
	cout<<str<<endl;
	int i =0;
	while(!(str[i]>='A'&&str[i]<='Z'||str[i]>='a'&&str[i]<='z'))i++;
	if(str[i]>'Z'||str[i]<'A'){
		cout<<"��һ����ĸ���Ǵ�д��ĸ"<<endl;
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
		cout<<"δ�����ַ���!"<<endl;
	}else if(argc>2){
		cout<<"�ַ�����������!"<<endl;
	}else{
		cout<<"��д��ĸ��:"<<func(argv[1],strlen(argv[1]))<<endl;
	}
	return 0;
}