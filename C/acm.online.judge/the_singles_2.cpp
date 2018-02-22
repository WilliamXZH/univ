#include <iostream>
#include <cmath>
#include <cstdlib>
#include <time.h>
#include <stack>
#include <cstring>
#include <algorithm>
#include <queue>
using namespace std;
#define maxn 1111111
 
long a;
bool vis[maxn];
long ans[maxn], cnt;
 
int main () {
    while (scanf ("%lld", &a) == 1) {
        cnt = 0;
        memset (vis, 0, sizeof vis);
        long num = 1;
		int i;
        while (1) {
            cnt++;
            num = num%a;
            if (num == 0)
                break;
            if (vis[num]) {
                printf ("There is no Singles' Day!\n");
                goto out;
            }
            vis[num] = 1;
            num = num*10+1;
        }
        printf ("Singles' Day is on ");
        for(i=0; i < cnt; i++) {
            printf ("1");
        }
        printf (".\n");
        out:;
    }
    return 0;
}