#include<iostream>
using namespace std;
void swap(int &a,int &b);

int xor(int a,int b){
	return (~a&b)|(a&~b);
}

void swap(int &a,int &b){
	a = a^b;
	b = a^b;
	a = a^b;
	//b = (b&~a)|(a&~b);
	//a = (b&~a)|(a&~b);

}

int plus(int a,int b){
	int x = a,y = b;
	while(x&y){
//		int t = x^y;
//		y = (x&y)<<1;
//		x = t;
		x = x^y;
		y = (~x&y)<<1;
	}
	return x|y;

}

/* a-b = a+(-b) = a+(~b+1) */
int minus(int a,int b){
	return plus(a,plus(~b,1));
}

int multiplication(int a,int b){
	
	if(b<0){
		if(a>=0){
			swap(a,b);
		}else{
			/* a*b = -(a*(-b)) */
			//return minus(0,multiplication(a,minus(0,b)));
			return plus(~multiplication(a,plus(~b,1)),1);
		}
	}

	int s = 0;
	while(b){
		//cout<<s<<endl;
		if(b&1){
			s = plus(s,a);
		}
		a = a<<1;
		b = b>>1;
	}
	return s;
}

int division(int a,int b){
	if(a<0){
		/* a/b = -((-a)/b) */
		//return minus(0,division(plus(~a,1),b));
		return plus(~division(plus(~a,1),b),1);
	}
	if(b<0){
		/* a/b = -(a/(-b)) */
		//return minus(0,division(a,plus(~b,1)));
		return plus(~division(a,plus(~b,1)),1);
	}else if(b==0){
		throw b;
		//return 0;
	}
	
	int s = 0;
	int t = b;
	while(t<a){
		t = t<<1;
	}
	while(t>=b){
		s = s<<1;
		if(a>=t){
			a = minus(a,t);
			s = plus(s,1);
		}
		t = t>>1;
	}

	return s;

}

int main(){
	//cout<<plus(3,11)<<endl;
	//int x =25, y =11;
	int x = -13,y=6;
	cout<<xor(x,y)<<":"<<(x^y)<<endl;
//	swap(x,y);
//	cout<<x<<":"<<y<<endl;
//	cout<<plus(x,y)<<endl;
//	cout<<minus(x,y)<<endl;
	cout<<multiplication(x,y)<<endl;
	cout<<division(x,y)<<endl;
	cout<<division(3,0)<<endl;
	cout<<"Test Finished!"<<endl;

//	for(int i=-10;i<10;i++){
//		for(int j=-10;j<10;j++){
//			cout<<'('<<i<<','<<j<<')'<<plus(i,j)<<endl;
//		}
//	}

}