#include<stdio.h>
#include<string.h>
int d[10],len,dp[100];

int main(){
    int l,r,res=0;
    scanf("%d%d",&l,&r);
    for(int i=l;i<=r;++i){
        memset(dp,0,sizeof(dp));
        dp[0]=1;
        len=0;
        int n=i,cnt=0;
        while(n){
            d[len]=n%10;
            cnt+=d[len++];
            n/=10;
        }
        if(cnt&1)continue;
        cnt>>=1;
        for(int j=0;j<len;++j)for(int k=cnt;k>=d[j];--k)
            if(dp[k])continue;
        	else if(dp[k-d[j]])dp[k]=1;
        if(dp[cnt])++res;
    }

    printf("%d\n",res);

    return 0;
}