#include <iostream>
#include<cstdio>

using namespace std;

const int maxn = 1e6 + 5;
const int mod = 1e9 + 7;
int vis[maxn];

int main() {
    int n;
    scanf("%d", &n);
    long ans = 1;
    for(int i = 2; i <= n; i++) {
        if(vis[i]) continue;
        for(int j = i + i; j <= n; j += i) vis[j] = 1;
        int tmp = n, cnt = 0;
        while(tmp >= i) tmp /= i, cnt++;
        ans = ans * (cnt + 1) % mod;
    }
    printf("%lld\n", ans);
    return 0;
}