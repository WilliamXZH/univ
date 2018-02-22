//#include<bits/stdc++.h>
#include<iostream>
using namespace std;
char ans[10][1005];
int a,b;
double d;
char c[10];
int tot=0;
void do2(char s){
    if(s=='+'){
        ans[1][tot+1]='*';
        ans[2][tot]='*';
        ans[2][tot+1]='*';
        ans[2][tot+2]='*';
        ans[3][tot+1]='*';
        tot+=5;
    }else if(s=='-'){
        ans[2][tot]='*';
        ans[2][tot+1]='*';
        ans[2][tot+2]='*';
        tot+=5;
    }else if(s=='*'){
        ans[1][tot]='*';
        ans[1][tot+2]='*';
        ans[2][tot+1]='*';
        ans[3][tot]='*';
        ans[3][tot+2]='*';
        tot+=5;
    }else if(s=='/'){
        ans[1][tot+2]='*';
        ans[2][tot+1]='*';
        ans[3][tot]='*';
        tot+=5;
    }else if(s=='='){
        ans[1][tot]='*';
        ans[1][tot+1]='*';
        ans[1][tot+2]='*';
        ans[1][tot+3]='*';
        ans[3][tot]='*';
        ans[3][tot+1]='*';
        ans[3][tot+2]='*';
        ans[3][tot+3]='*';
        tot+=6;
    }else if(s=='.'){
        ans[3][tot]='*';
        ans[3][tot+1]='*';
        ans[4][tot]='*';
        ans[4][tot+1]='*';
        tot+=4;
    }else if(s=='1'){
        ans[0][tot]='*';
        ans[1][tot]='*';
        ans[2][tot]='*';
        ans[3][tot]='*';
        ans[4][tot]='*';
        tot+=3;
    }else if(s=='2'){
        ans[0][tot]='*';
        ans[0][tot+1]='*';
        ans[0][tot+2]='*';
        ans[1][tot+2]='*';
        ans[2][tot]='*';
        ans[2][tot+1]='*';
        ans[2][tot+2]='*';
        ans[3][tot]='*';
        ans[4][tot]='*';
        ans[4][tot+1]='*';
        ans[4][tot+2]='*';
        tot+=5;
    }else if(s=='3'){
        ans[0][tot]='*';
        ans[0][tot+1]='*';
        ans[0][tot+2]='*';
        ans[1][tot+2]='*';
        ans[2][tot]='*';
        ans[2][tot+1]='*';
        ans[2][tot+2]='*';
        ans[3][tot+2]='*';
        ans[4][tot]='*';
        ans[4][tot+1]='*';
        ans[4][tot+2]='*';
        tot+=5;
    }else if(s=='4'){
        ans[0][tot]='*';
        ans[0][tot+2]='*';
        ans[1][tot]='*';
        ans[1][tot+2]='*';
        ans[2][tot]='*';
        ans[2][tot+1]='*';
        ans[2][tot+2]='*';
        ans[3][tot+2]='*';
        ans[4][tot+2]='*';
        tot+=5;
    }else if(s=='5'){
        ans[0][tot]='*';
        ans[0][tot+1]='*';
        ans[0][tot+2]='*';
        ans[1][tot]='*';
        ans[2][tot]='*';
        ans[2][tot+1]='*';
        ans[2][tot+2]='*';
        ans[3][tot+2]='*';
        ans[4][tot]='*';
        ans[4][tot+1]='*';
        ans[4][tot+2]='*';
        tot+=5;
    }else if(s=='6'){
        ans[0][tot]='*';
        ans[0][tot+1]='*';
        ans[0][tot+2]='*';
        ans[1][tot]='*';
        ans[2][tot]='*';
        ans[2][tot+1]='*';
        ans[2][tot+2]='*';
        ans[3][tot]='*';
        ans[3][tot+2]='*';
        ans[4][tot]='*';
        ans[4][tot+1]='*';
        ans[4][tot+2]='*';
        tot+=5;
    }else if(s=='7'){
        ans[0][tot]='*';
        ans[0][tot+1]='*';
        ans[0][tot+2]='*';
        ans[1][tot+2]='*';
        ans[2][tot+2]='*';
        ans[3][tot+2]='*';
        ans[4][tot+2]='*';
        tot+=5;
    }else if(s=='8'){
        ans[0][tot]='*';
        ans[0][tot+1]='*';
        ans[0][tot+2]='*';
        ans[1][tot]='*';
        ans[1][tot+2]='*';
        ans[2][tot]='*';
        ans[2][tot+1]='*';
        ans[2][tot+2]='*';
        ans[3][tot]='*';
        ans[3][tot+2]='*';
        ans[4][tot]='*';
        ans[4][tot+1]='*';
        ans[4][tot+2]='*';
        tot+=5;
    }else if(s=='9'){
        ans[0][tot]='*';
        ans[0][tot+1]='*';
        ans[0][tot+2]='*';
        ans[1][tot]='*';
        ans[1][tot+2]='*';
        ans[2][tot]='*';
        ans[2][tot+1]='*';
        ans[2][tot+2]='*';
        ans[3][tot+2]='*';
        ans[4][tot]='*';
        ans[4][tot+1]='*';
        ans[4][tot+2]='*';
        tot+=5;
    }else if(s=='0'){
        ans[0][tot]='*';
        ans[0][tot+1]='*';
        ans[0][tot+2]='*';
        ans[1][tot]='*';
        ans[1][tot+2]='*';
        ans[2][tot]='*';
        ans[2][tot+2]='*';
        ans[3][tot]='*';
        ans[3][tot+2]='*';
        ans[4][tot]='*';
        ans[4][tot+1]='*';
        ans[4][tot+2]='*';
        tot+=5;
    }
}
void do1(double x){
    char k[105];
    if(x-int(x)==0)sprintf(k,"%d",int(x));
    else if(x*10-int(x*10)==0)sprintf(k,"%.1f",x);
    else sprintf(k,"%.2f",x);
    int len = strlen(k);
    for(int i=0;i<len;i++){
        do2(k[i]);
    }
}
int main(){
    scanf("%d %s %d",&a,c,&b);
    if(c[0]=='+'){
        d = a + b;
    }else if(c[0]=='-'){
        d = a - b;
    }else if(c[0]=='*'){
        d = a * b;
    }else{
        d = 1.0*a / b;
    }
    do1(a);
    do2(c[0]);
    do1(b);
    do2('=');
    do1(d);
    string Ans[5];
    //cout<<tot<<endl;
    for(int i=0;i<5;i++){
        for(int j=0;j<tot;j++)
            if(ans[i][j]=='*')printf("*");
            else printf(" ");
        //    Ans[i]+=ans[i][j];
        printf("\n");
        //cout<<Ans[i]<<endl;
    }
}