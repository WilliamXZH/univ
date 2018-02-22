#include <cstdio>
#include <unordered_set>
#include <vector>
 
using namespace std;
 
int main(int argc, const char *argv[])
{
    unordered_set<int> first_array;
    int m, n;
    scanf("%d", &m);
    int tmp;
    for (int i = 0; i < m; i++)
    {
        scanf("%d", &tmp);
        first_array.emplace(tmp);
    }
 
    scanf("%d", &n);
    vector<int> ans;
    for (int i = 0; i < n; i++)
    {
        scanf("%d", &tmp);
        if (first_array.find(tmp) != first_array.end())
        {
            ans.push_back(tmp);
        }
    }
    for (int i = 0; i < ans.size(); ++i)
    {
        printf("%d%c", ans[i], ' ');
    }
 
    return 0;
}