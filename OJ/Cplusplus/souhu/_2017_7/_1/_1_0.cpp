#include<string>
#include<iostream>
using namespace std;
int main(){
    string s;
    int len,i;
    while(cin>>s>>len){
        i=1;
        while(len--){
            int slen=s.length();
            for(i--;i<slen-1;i++)
                if(s[i]<s[i+1]){
                    s.erase(s.begin()+i);
                    break;
                }
            if(i==slen-1) s.erase(s.end()-1);
        }
        cout<<s<<endl;
    }
}