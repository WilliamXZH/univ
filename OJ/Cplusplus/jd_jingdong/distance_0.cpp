#include<iostream>
#include<algorithm>
#include<math.h>
#include<vector>
#include<stdio.h>
using namespace std;

int main(){
	int n,i;
	scanf("%d",&n);
	vector<double> a(n);
	for(i=0;i<n;i++)scanf("%lf",&a[i]);
	double res = -1;
	for(i=0;i<n-1;i++){
		int l=i+1,r=n-1;
		while(l<=r){
			int mid = (l+r)/2;
			double target = fabs(a[i]-a[mid]);
			if(target<180)l=mid+1;
			else if(target==180){
				res = 180.0;
				break;
			}else{
				r = mid-1;
			}
			if(target>180)target=360-target;
//			res = _cpp_max(res,target);//not sup int vc6.0
			res = __max(res,target);//in c
			res = _MAX(res,target);
		}
	}
	printf("%.8lf\n",res);
	return 0;
}