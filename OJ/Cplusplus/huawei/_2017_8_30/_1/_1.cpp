#include<iostream>
#include<string>
#include<vector>
using namespace std;

#define len(ss) (sizeof(ss)/sizeof(ss[0]))

int main(){
	//cout<<(int)'a'<<":"<<(int)'A'<<endl;
	//string str = "123213";
	//cout<<str.assign(str,1,3)<<endl;
	int len;
	string py[] = {"Yi","Er","San","Si","Wu",
		"Liu","Qi","Ba","Jiu","Ling"};
	string el[] = {"One","Two","Three","Four","Five",
		"Six","Seven","Eight","Nine","Zero"};
	string s;
	cin>>s;
	vector<string> v;
	int l = s.length();
	for(int i=0;i<l;i++){
		bool legal = true;
		//cout<<"i:"<<i<<endl;
		//cout<<"s:"<<s<<endl;
		//cout<<"s[i]"<<s[i]<<endl;
		if(s[i]>90||s[i]<65){
			legal = false;
		}else{
			int t = 1;
			while(s[i+t]>=97&&s[i+t]<=122&&i+t<l)t++;
			string tmp = s;
			tmp.assign(s,i,t);
			legal = false;
			len = len(py);
			//cout<<i<<"<i:t>"<<t<<endl;
			//cout<<"tmp:"<<tmp<<endl;
			//cout<<"len:"<<len<<endl;
			for(int x=0;x<len;x++){
				//cout<<tmp<<":"<<py[x]<<endl;
				if(tmp==py[x]){
					//cout<<el[x];
					v.push_back(el[x]);
					legal = true;
					break;
				}
			}
			len = len(el);
			for(int y=0;y<len;y++){
				//cout<<tmp<<":"<<el[x]<<endl;
				if(tmp==el[y]){
					//cout<<py[y];
					v.push_back(py[y]);
					legal = true;
					break;
				}
			}
			i += t-1;
		}
		if(!legal){
			cout<<"ERROR"<<endl;
			break;
		}else{
			cout<<v[v.size()-1];
//			for(int k=0;k<v.size();k++){
//				cout<<v[k];
//			}
		}
	}

}