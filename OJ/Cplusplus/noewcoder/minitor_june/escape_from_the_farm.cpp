#include <bits/stdc++.h>

using namespace std;

const int mod = 1e9 + 7;
int n, k;
int dp[55][1005];
int main() {
    cin >> n >> k;
    dp[0][0] = 1;
    for(int i = 0; i < n; i++) {
        for(int j = k; j >= 1; j--) {
            for(int k = 0; k < n; k++) {
                dp[j][k] = (dp[j][k] + dp[j - 1][k - i < 0 ? k - i + n : k - i]) % mod;
            }
        }
    }
    cout << dp[k][0] << endl;
    return 0;
}