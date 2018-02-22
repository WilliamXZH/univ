#include<iostream>
#include<string>
using namespace std;

int main(){
    int cnt;
	string number;
    cin>>number>>cnt;
	int i=1;
    while(cnt--){
		int l = number.size();
        for(i--;i<l-1;i++){
			//cout<<number[i]<<":"<<number[i+1]<<endl;
        	if(number[i]<number[i+1]){
                number.erase(number.begin()+i);
				//cout<<number<<endl;
				break;
            }
        }
		if(i==l-1){number.erase(number.end()-1);}
    }
	cout<<number<<endl;
	return 0;
}