#include<stdio.h>
#include<algorithm>
using namespace std;
int a[10005],dp[10005];
const int MAX=99999999;
int main(){
    int N,i,j;
    while(scanf("%d",&N)!=EOF){
        for(i=0;i<10005;i++) dp[i]=MAX;
        dp[0]=0;
        for(i=0;i<N;i++) scanf("%d",&a[i]);
        int step[10005];
        for(i=1;i<=N;i++)
            for(j=0;j<i;j++)
                if(a[j]+j>=i)
                    dp[i]=min(dp[i],dp[j]+1);
        printf("%d\n",dp[N]==MAX?-1:dp[N]);
    }
}