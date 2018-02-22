#include<iostream>
#include<cstring>
using namespace std;

int compare(char a[],char b[]);
int main(){
	char country[300][50],tem[50];
	for(int i=0;;i++){
		cin>>country[i];
		if(compare(country[i],"end")==-1)break;
	}
	for(int j=0;j<i-1;j++){
		for(int k=j+1;k<i;k++)
		{
			if(!compare(country[j],country[k])){
				//cout<<country[j]<<" "<<country[k]<<endl;;
				strcpy(tem,country[j]);
				strcpy(country[j],country[k]);
				strcpy(country[k],tem);
			}
		}
	}
	for(j=0;j<i;cout<<country[j],j++)if(j!=0)cout<<",";

}
int compare(char a[],char b[]){
	for(int i=0;(a[i]!='\0')&&(b[i]!='\0')&&a[i]==b[i++];);
	//cout<<a[i-1]<<" "<<b[i-1]<<endl;
	if(a[--i]<b[i])return 1;
	else if(a[i]==b[i])return -1;
	else return 0;
}