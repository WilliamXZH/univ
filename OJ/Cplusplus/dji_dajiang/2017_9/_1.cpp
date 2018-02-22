#include<iostream>
using namespace std;

int round(double x){
	int y = x*10;
	if(y%10>=5){
		return y/10+1;
	}else{
		return y/10;
	}
}

void test(){
	for(double i=1.0;i<3;i+=0.1){
		cout<<i<<":"<<round(i)<<endl;
	}
}

int calc(){
	//test();
	int H,x,y,h,s;
	cin>>H>>x>>y>>h>>s;
	double t1 = (double)h/x;
	double r;
	if(s<=t1){
		return x*s;
	}else if(x<=y){
		return h;
	}
	double t2 = t1 + (H-h)/(double)(x-y);
	if(s>=t2){
		return H;
	}else{
		return round(h + (double)(s-t1)*(x-y));
	}
}

int main(){
	cout<<calc()<<endl;
	//cout<<r<<",ËÄÉáÎåÈë"<<round(r)<<endl;
}