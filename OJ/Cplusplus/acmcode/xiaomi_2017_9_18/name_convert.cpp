#include<iostream>
#include<string>
using namespace std;

int len(char* s){
	int c=0;
	while(s[c++]!='\0');
	return c;
}

int main(){
	char s[100];
	while(cin>>s){
		int c= 0;
		//cout<<s<<endl;
		char t[200];
		int l = len(s);
		t[c++] = '_';
		for(int i=0;i<l;i++,c++){
			//cout<<s[i]<<endl;
			if(s[i]>='0'&&s[i]<='9'){
				//t[c++]='_';
				i--;
				while(s[i+1]>='0'&&s[i+1]<='9'){
					t[c++]=s[++i];
				}
				t[c]='_';
			}else if(s[i]>='a'&&s[i]<='z'){
				//t[c++] = '_';
				i--;
				while(s[i+1]>='a'&&s[i+1]<='z'){
					//cout<<"s[i+1]"<<endl;
					t[c++] = s[++i]-'a'+'A';
				}
				t[c] = '_';
			}else if(s[i]>='A'&&s[i]<='Z'){
				if(s[i+1]>='a'&&s[i+1]<='z'){
					//t[c++] = '_';
					t[c++] = s[i];
					while(s[i+1]>='a'&&s[i+1]<='z'){
						t[c++] = s[++i]-'a'+'A';
					}
					t[c++] = '_';
				}else{
					//t[c++] = '_';
					t[c++] = s[i];
					while(s[i+1]>='A'&&s[i+1]<='Z'
						&&s[i+2]>='A'&&s[i+2]<='Z'){
						t[c++] = s[++i];
					}
					if(s[i+2]=='.'){
						t[c++] = s[++i];
						i++;
					}
					t[c++] = '_';
				}
			}
		}
		cout<<t<<endl;
	}
}
