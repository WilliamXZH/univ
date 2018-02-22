//DAUÍ³¼Æ
#include<bits/stdc++.h>
 using namespace std;
 
 set<long long>S;
 int main(){
     long long m;
     while(cin>>m){
         if(m==0)break;
         S.insert(m);
     }
     cout<<S.size()<<endl;
 }