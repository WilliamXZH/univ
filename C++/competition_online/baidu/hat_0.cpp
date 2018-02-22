//#include <bits/stdc++.h>
#include<iostream>
#include<set>
using namespace std;

int n;
set<int> S;
int main() {
    int n;
    cin >> n;
    for(int i = 0; i < n; i++) {
        int x; cin >> x;
        S.insert(x);
    }
    int cnt = 0;
    for(auto &x : S) {
        cnt++;
        if(cnt == 3) {
            cout << x << endl;
            break;
        }
    }
    if(cnt < 3) cout << -1 << endl;
    return 0;
}