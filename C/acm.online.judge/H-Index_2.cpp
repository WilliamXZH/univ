#include <iostream> 
#include <algorithm>  
#define N 10000
using namespace std;
int a[N];  
   
bool cmp (int a,int b) {  
    return a > b;  
}  
int max(int x,int y)
{
	return x>y?x:y;
}
int main () {  
    int t,n;  
    cin>>t;  
    while (t--) {  
        cin>>n;  
        for (int i = 1; i <= n; i++) {  
            cin>>a[i];  
        }  
        a[n+1] = -1;  
        sort (a+1, a+1+n, cmp);  
        int ans = -1;  
        for (int h = 0; h <= n; h++) {  
            if (a[h] >= h && a[h+1] <= h) {  
                ans= max(ans, h);
            }
        }  
        cout<<ans<<endl;  
    }  
    return 0;  
}  