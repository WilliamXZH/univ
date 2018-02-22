#include <iostream>

using namespace std;

const int maxn = 500 + 5;

double dp[2][maxn][maxn];
int n ;
int main() {
    cin >> n;
    double ans = 0;
    dp[0][1][0] = 1.0;
    for(int i = 1; i <= n; i++) {
        int cur = i % 2, old = 1 - (i % 2);
        for(int j = 1; j <= i + 1; j++) for(int k = 0; k < j; k++) dp[cur][j][k] = 0;
        for(j = 1; j <= i; j++) for(int k = 0; k < j; k++) {
            if(dp[old][j][k] > 0) {
                int pos1 = j, pos2 = k + 1;
                if(pos1 == pos2) ++pos1;
                dp[cur][pos1][pos2] += 0.5 * dp[old][j][k];
                int pos3 = j, pos4 = k - 1;
                if(pos4 == -1) {pos3++,pos4++;}
                dp[cur][pos3][pos4] += 0.5 * dp[old][j][k];
            }
        }
    }
    for(i = 1; i <= n + 1; i++) {
        for(int j = 0; j < i; j++) {
            ans += i * dp[n % 2][i][j];
        }
    }
    printf("%.1f\n", ans);
    return 0;
}