//standard answer
#include <algorithm>
 #include <cassert>
 #include <cstring>
 #include <cstdio>

 const int N = 60;
 const int M = 500 + 10;

 int dp[N][N][M], sum[N][N], a[N][N], n, m;

 int main() {
	 assert(scanf("%d%d", &n, &m) == 2);
	 assert(1 <= n && n <= 50);
	 assert(1 <= m && m <= 500);
	 for (int i = 1; i <= n; ++ i) {
		 for (int j = 1; j <= i; ++ j) {
			 assert(scanf("%d", &a[i][j]) == 1);
			 assert(0 <= a[i][j] && a[i][j] <= 1000);
		 }
	 }

	 for (int i = 1; i <= n; ++ i) {
		 for (int j = 1; j <= i; ++ j) {
			 sum[i][j] = sum[i][j - 1] + a[n - j + 1][i - j + 1];
		 }
	 }

	 memset(dp, 200, sizeof(dp));
	 for (int i = 0; i <= n; ++ i) {
		 dp[i][0][0] = 0;
	 }
	 for (int i = 1; i <= n; ++ i) {
		 for (int j = i; j >= 0; -- j) {
			 for (int k = j; k <= m; ++ k) {
				 dp[i][j][k] = std::max(dp[i][j + 1][k],
										dp[i - 1][std::max(0, j - 1)][k - j] + sum[i][j]);
			 }
		 }
	 }
	 printf("%d\n", dp[n][0][m]);
	 return 0;
}