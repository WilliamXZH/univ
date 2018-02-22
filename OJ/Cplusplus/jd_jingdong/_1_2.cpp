#include<iostream>
#include<math.h>
using namespace std;

int main(){
	long n;
	cin>>n;
	cout<<n<<endl;
	long k = (long)sqrt(n*2);
	if(n>k*(k-1))k++;
	cout<<k<<endl;
}