#include<iostream>
#include<vector>
#include<numeric>
using namespace std;

int main() {
    int n, k;
    cin >> n;
    vector<int> arr(n);
    for(int i = 0; i < n; i++) {
        cin >> arr[i];
    }
    cin >> k;
    int s = accumulate(arr.begin(), arr.end(), 0);
    int m = 0;
    for(int hi = n - 1;hi>=0;hi--)
    {
        int sb = s, lo = 0;
        while(lo <= hi && (hi - lo + 1) > m){
            if (sb % k == 0) {
                m = hi - lo + 1;
                break;
            }
            sb -= arr[lo];
            lo++; 
        }
        s -= arr[hi];
    }
    cout << m;
}