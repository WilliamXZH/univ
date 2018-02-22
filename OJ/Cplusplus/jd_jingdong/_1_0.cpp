#include<iostream>
using namespace std;
long long n;
int main() {
    cin >> n;
    long long l = 1, r = 2000000000LL, mid;
    while(l < r) {
        mid = (l + r) / 2;
        if(mid * (mid + 1) / 2 >= n)
            r = mid;
        else
            l = mid + 1;
    }
    cout << l << endl;
    return 0;
}