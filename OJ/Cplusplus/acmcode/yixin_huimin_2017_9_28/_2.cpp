#include<iostream>
using namespace std;

int main(){
	int n,w;
	cin>>n>>w;
	int al = n;
    int bl = 0;
	int ac,bc;
	for(int i=1;i<w;i++){
		ac = al*n;
		bc = bl*n+(al-bl);
        if(bc>100003)bc = bc%100003;
        if(ac>100003&&ac%100003>bc)ac = ac%100003;
        al = ac;
        bl = bc;
	}
	cout<<(bc%100003)<<endl;
}