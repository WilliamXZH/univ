#include<iostream>
#include<string>
#include<algorithm>
#include<map>
using namespace std;
int main(){
    string s;
    int i,j,num,len;
    while(cin>>s){
        len=s.length();
        s=s+s;
        i=0,j=0,num=0;
        int Min=len;
        map<char,int> book;
        while(true){
            while(i<s.length()&&num<5){
                if((s[i]=='A'||s[i]=='B'||s[i]=='C'||s[i]=='D'||s[i]=='E')
                    &&book[s[i]]++==0)
                    num++;
                i++;
            }
            if(num<5) break;
            Min=min(Min,i-j);
            if((s[j]=='A'||s[j]=='B'||s[j]=='C'||s[j]=='D'||s[j]=='E')
                &&--book[s[j]]==0) num--;
            j++;
        }
        printf("%d\n",len-Min);
    }
}//尺取法，求包含ABCDE的最短字串