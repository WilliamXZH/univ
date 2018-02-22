#include<iostream>
#include<vector>
#include<stack>
using namespace std;

int size(const char *p){
	int i = 0;
	while(p[i++]!='\0');
	return i;
}
int max(vector<int> v){
	int max = v[0];
	for(int i=1;i<v.size();i++){
		if(max<v[i]){
			max = v[i];
		}
	}
	return max;
}

int getMax(const char *p,int n){
	
	int max = 0;
	int c = 0;
	int t = 0;
	int i = -1;
	while(p[++i]==')');
	for(;i<n;i++){
		if(p[i]=='('){
			t++;
		}else if(p[i]==')'){
			if(t>0){
				t--;
				c += 2;
			}else{
				t = 0;
			}
			if(t==0&&max<c)max = c;
		}
	}
	
	return max;
}

int getMax0(const char *p, int n){
	
}

int getMax1(const char *p,int n){
	int max = 0;
	int c = 0;
	int l = 0;
	for(int i=0;i<n;i++){
		if(p[i]=='('){
			l++;
		}else if(p[i]==')'&&l>0){
			l--;
			c++;
		}else{
			if(max<c){
				max = c;
			}
			c = 0;
		}
	}
	return (max>c?max:c)*2;
}

int getMax2(const char *p,int n){
	int l = 0;
	vector<int> v;
	int s = 0;
	for(int i=0;i<n;i++){
		if(p[i]=='('){
			s++;
		}else if(s>0&&p[i]==')'){
			s--;
			l += 2;
			if(s==0){
				v.push_back(l);
			}else{
				l = 0;
			}
		}
	}
	if(v.size()>0){
		return max(v);
	}else return 0;
}

int longestValidParentheses(const char *s)
{
    int i = 0;
    int count = 0;
    int left = 0;            //左括号数目
    int preCount = 0;        //已有最长括号对数目
        
    //略过最前面的右括号
  start:
    while (s[i] == ')')
        i++;
    //())()
    
    for (; s[i]; i++)
    {
        if (s[i] == '(')
            left++;
        else if (s[i] == ')' && left > 0)
        {
            count++;
            left--;
        }
          /* 当遇到这种状态，说明前面的有效括号已经结束 */
        else if (s[i] == ')' && left == 0)
        {
            if (count > preCount)       
                preCount = count;

            count = 0;            //前面括号已经匹配完，重新计数
            goto start;
        }
    }
    
    return (preCount > count ? preCount : count) * 2; //长度为括号对的两倍
}

int main(){
	char p[100];
	while(cin>>p){
		cout<<getMax1(p,size(p))<<endl;
		//cout<<longestValidParentheses(p)<<endl;
	}
}