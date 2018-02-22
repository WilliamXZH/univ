
#include<iostream>
using namespace std;
bool check(int n) {
    char s[11];
    int cur = 0, t = 0;
    while(n > 0) {
        s[cur] = n % 10;
        t += s[cur++];
        n /= 10;
    }
    if(t % 2) return false;
    t /= 2;
    bool ok[42] = {0};
    ok[s[0]] = true;
    for(int i = 1; i < cur; i++) {
        int v = s[i];
        for(int j = 41; j >= 0; j--) {
            if(ok[j] && j + v <= 41) {
                ok[j + v] = true;
            }
        }
        if(ok[t]) {
            return true;
        }
    }
    return false;
}
int l, r;
int main() {
    int res = 0;
    cin >> l >> r;
    for(int i = l; i <= r; i++) {
        if(check(i)) res++;
    }
    cout << res << endl;
    return 0;
}