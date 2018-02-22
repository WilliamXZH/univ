#include<iostream>
#include<string>
using namespace std;

int main(){
	int t=0,n=0;
	int inci,incj,inck;
	int tmp=0;
	string strtmp;
	cin>>t;
	for(inci=0;inci<t;inci++){
		cin>>n;
		int *count=new int[n];
		string *a=new string[n];
		string *b=new string[n];
		for(incj=0;incj<n;incj++){
			count[incj]=incj+1;
			cin>>a[incj]>>b[incj];
		}
		for(incj=0;incj<n;incj++){
			for(inck=incj+1;inck<n;inck++){
				if(a[incj].compare(a[inck])<0){
					tmp=count[incj];
					strtmp=a[incj];
					count[incj]=count[inck];
					a[incj]=a[inck];
					count[inck]=tmp;
					a[inck]=strtmp;
				}
			}
			cout<<"NO."<<count[incj]<<":"<<b[count[incj]-1]<<endl;
		}
		cout<<endl;
	}
}
/*bool strcm(char *str1,char *str2){
	int i=-1;
	while((str1[++i]==str2[i])!='\0')
		cout<<str1[i]<<endl;
	//cout<<str1[i]<<endl;
	return (str1[i]>=str2[i]);
}*/