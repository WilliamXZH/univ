#include <iostream>
#include <cmath>
#include <cstdlib>
#include <time.h>
#include <stack>
#include <cstring>
#include <algorithm>
#include <queue>
using namespace std;
#define maxn 2111
#define move Move
 
struct node {
    int x, y;
    int step;
    bool operator < (const node &a) const {
        return step > a.step;
    }
};
bool vis[maxn][maxn];
queue <node> gg;
int n, m, t;
char mp[maxn][maxn];
const int move[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
 
bool legal (int x, int y) {
    if (x < 1 || x > n || y < 1 || y > m)
        return 0;
    return 1;
}
 
void bfs () {
    while (!gg.empty ()) {
        node now = gg.front (); gg.pop ();
        for (int i = 0; i < 4; i++) {
            node next = now;
            next.x += move[i][0];
            next.y += move[i][1];
            if (!legal (next.x, next.y))
                continue;
            else if (vis[next.x][next.y])
                continue;
            else {
                int ss = next.step + 1;
                if (ss > t)
                    continue;
                else {
                    gg.push ((node){next.x, next.y, ss});
                    mp[next.x][next.y] = '.';
                    vis[next.x][next.y] = 1;
                }
            }
        }
    }
}
 
void dfs (int x, int y) { 
    vis[x][y] = 1;
    for (int i = 0; i < 4; i++) {
        int xx = x+move[i][0];
        int yy = y+move[i][1];
        if (legal (xx, yy) && !vis[xx][yy]) {
            if (mp[xx][yy] == '#')
                dfs (xx, yy);
        }
    }
}
 
int get () {
    memset (vis, 0, sizeof vis);
    int ans = 0;
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= m; j++) {
            if (!vis[i][j] && mp[i][j] == '#') {
                ans++;
                dfs (i, j);
            }
        }
    }
    return ans;
}
 
int main () {
    while (scanf ("%d%d%d", &n, &m, &t) == 3) {
        memset (mp, 0, sizeof mp);
        while (!gg.empty ())
            gg.pop ();
        for (int i = 0; i <= m+1; i++) {
            gg.push ((node){0, i, 0});
            gg.push ((node){n+1, i, 0});
        }
        for (int i = 1; i <= n; i++) {
            gg.push ((node){i, 0, 0});
            gg.push ((node){i, m+1, 0});
        }
        memset (vis, 0, sizeof vis);
        for (int i = 1; i <= n; i++) {
            scanf ("%s", mp[i]+1);
        }
        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= m; j++) {
                if (mp[i][j] == '.') {
                    gg.push ((node){i, j, 0});
                    vis[i][j] = 1;
                }
            }
        }
        if (t >= (min (n, m)+1)/2) { //ºÙ÷¶
            printf ("0\n");
            for (int i = 1; i <= n; i++) {
                for (int j = 1; j <= m; j++) {
                    printf (".");
                }
                printf ("\n");
            }
            continue;
        }
        bfs ();
        int ans = get ();
        printf ("%d\n", ans);
        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= m; j++) {
                printf ("%c", mp[i][j]);
            }
            puts ("");
        }
    }
    return 0;
}