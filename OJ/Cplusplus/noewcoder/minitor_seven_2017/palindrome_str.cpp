#include<iostream>
using namespace std;

int getmin(char str[]);

int main()
{
	char str[1001];
	cin>>str;
	cout<<getmin(str);
}


int getmin(char str[]){
	int count = 0;

	int flag[26];
	for(int i=0;i<26;i++){
		flag[i]=0;
	}

	int k=0;
	while(str[k]!='\0'){
		flag[str[k]-'a']++;
		k++;
	}

	for(int j=0;j<26;j++){
		//cout<<j<<'\t'<<flag[j]<<endl;
		if(flag[j]%2!=0){
			count++;
		}
	}

	return count==0?1:count;

}



