#include<iostream>
using namespace std;

int n, k, ans;
int dp[1005][1005];
int main() {
    cin >> n >> k;
    for(int h = 1; h <= n; h++)
	{
        dp[h][0] = 1;
	}
    for(int i = 2; i <= n; i++)
	{
        for(int j = 1; j <= k; j++)
            dp[i][j] = (dp[i - 1][j - 1] * (i - j) + dp[i - 1][j] * (j + 1)) % 2017;
	}
    cout << dp[n][k] % 2017 << endl;
    return 0;
}