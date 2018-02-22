#include<iostream>
using namespace std;
#define SIZE 1000

class list{
private:
		int l;
		int ptr[SIZE];
		int data[SIZE];
		int head;
		int tail;
public:
	list(){init();}
	void init(){
		for(int i=0;i<SIZE-1;i++){
			ptr[i]=i+1;
		}
		ptr[SIZE-1]=0;
		head=0;
		tail=ptr[head];
		l=0;
	};
	void empty(){init();}
	bool isempty(){return tail==ptr[head];}
	bool add(int t){
		if(ptr[tail]==head){
			return false;
		}else{
			data[tail]=t;
			tail=ptr[tail];
			l++;
		}
		return true;
	}
	bool find(int t){
		if(tail==ptr[head])return false;
		for(int i=head;ptr[i]!=tail;i=ptr[i]){
			if(data[ptr[i]]==t){
				return true;
			}
		}
		return false;
	}
	bool remove(int t){
		for(int i=head;ptr[i]!=tail;i=ptr[i]){
			if(data[ptr[i]]==t){
				int tmp = ptr[i];
				ptr[i] = ptr[ptr[i]];
				ptr[tmp]=ptr[head];
				ptr[head]=tmp;
				head=tmp;
				l--;
				return true;
			}
		}
		return false;
	}
	int size(){return l;}
};

int main()
{
	int m;
	int x=0;
	list data;

	int n = 0;

	cin>>m;

	for(int i=0;i<m;i++)
	{
		char c;
		cin>>c;
		if(c=='I'){
			int in;
			cin>>in;
			if(data.find(in)){
				if(n>0){
					n--;
					data.remove(in);
				}else{
					x = i+1;
					break;
				}
			}else{
				data.add(in);
			}
		}else if(c=='O')
		{
			int o;
			cin>>o;
			if(!data.remove(o)){
				if(n<=0){
					x = i+1;
					break;
				}else{
					n--;
				}
			}

		}else if(c=='?')
		{
			n++;
		}
	}
	if(x==0)cout<<-1;
	else cout<<x;
}