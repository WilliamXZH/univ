#include<stdlib.h>
#include<fstream>
#include<iostream>
#include<string>
using namespace std;

/*-------------���Ƿָ���--------������ջ�Ķ���---------------------------------*/
class stack					
{
private:
    int top;
    string *stacka;
    int maxsize;
public:
    stack(int size=20);
    ~stack(){ delete [] stacka; }
    void push(const string &item);
    string pop(void);
    string gettop(void) const ;
    bool empty(void) const { return (top==-1); }
    bool full(void) const { return (top==maxsize-1); }
    void clear(void) { top=-1; }
};

stack::stack(int size)		     //ջ��Ĺ��캯��
{
    top=-1;
    maxsize=size;
    stacka=new string[maxsize];
    if(!stacka)
    {
        cerr<<"allocate memory failed."<<endl;
        exit(1);
    }
}

void stack::push(const string &item)        //ѹջ����
{
    if(full())
    {
        cerr<<"stack full, cannot push."<<endl;
        return;
    }
    top++;
    stacka[top]=item;
}

string stack::pop(void)				        //��ջ����
{
    if(empty())
    {
        cerr<<"stack empty, cannot pop."<<endl;
        exit(1) ;
    }
    string item=stacka[top];
    top--;
    return item;
}

string stack::gettop(void) const	         //ȡջ������
{
    if(empty())
    {
        cerr<<"stack empty, cannot gettop."<<endl;
        exit(1) ;
    }
    return stacka[top];
}
/*--------------ջ�������-----------------------*/
stack syn;
stack sem;
char i='1';//���ڼ�¼���ɵ��м����t�ĸ�����
/*--------------����Ӧѹջ�ı��ʽ���к�-----------------------*/
int getBDS(string a,string b)
{
   if(a=="E"&&((b<="z"&&b>="a")||(b<="9"&&b>="0")||b=="("))
	   return 1;
   else if(a=="E1" && b=="+")
	   return 2;
   else if(a=="E1" && b=="-")
	   return 3;
   else if(a=="E1" && (b==")"||b=="#"))
	   return 4;
   else if(a=="T" && ((b<="z"&& b>="a")||(b<="9"&&b>="0")||b=="("))
	   return 5;
   else if(a=="T1"&&(b=="+"||b=="-"||b==")"||b=="#"))
	   return 8;
   else if(a=="T1"&&b=="*")
	   return 6;
   else if(a=="T1"&&b=="/")
	   return 7;
   else if(a=="F"&&((b<="z"&& b>="a")||(b<="9"&&b>="0")))
	   return 9;
   else if(a=="F"&&b=="(")
	   return 10;
   else
	   return 0;
}
/*--------------��syn��ѹջ-----------------------*/
void pushToSyn(int a,string b)
{
	if(a==1)
	{
		syn.pop();////////////////////////
		syn.push("E1");
	    //cout<<"E1��ջ"<<endl;
	    syn.push("T");
	    //cout<<"T��ջ"<<endl;

	}
	if(a==2)
	{
		syn.pop();
		syn.push("E1");
		//cout<<"E1��ջ"<<endl;
		syn.push("G+");
		//cout<<"G+��ջ"<<endl;
		syn.push("T");
		//cout<<"T��ջ"<<endl;
		syn.push("+");
		//cout<<"+��ջ"<<endl;
	}
	if(a==3)
	{
		syn.pop();
		syn.push("E1");
		//cout<<"E1��ջ"<<endl;
		syn.push("G-");
		//cout<<"G-��ջ"<<endl;
		syn.push("T");
		//cout<<"T��ջ"<<endl;
		syn.push("-");
		//cout<<"-��ջ"<<endl;
	}
	if(a==4)
	{
		//cout<<"����ѹ��syn"<<endl;
		syn.pop();
	}
	if(a==5)
	{
		syn.pop();
		syn.push("T1");
		//cout<<"T1��ջ"<<endl;
		syn.push("F");
		//cout<<"F��ջ"<<endl;
	}
	if(a==6)
	{
		syn.pop();
		syn.push("T1");
		//cout<<"T1��ջ"<<endl;
		syn.push("G*");
		//cout<<"G*��ջ"<<endl;
		syn.push("F");
		//cout<<"F��ջ"<<endl;
		syn.push("*");
		//cout<<"*��ջ"<<endl;
	}
	if(a==7)
	{
		syn.pop();
		syn.push("T1");
		//cout<<"T1��ջ"<<endl;
		syn.push("G/");
		//cout<<"G/��ջ"<<endl;
		syn.push("F");
		//cout<<"F��ջ"<<endl;
		syn.push("/");
		//cout<<"/��ջ"<<endl;
	}
	if(a==8)
	{
		syn.pop();
	}
	if(a==9)
	{
		syn.pop();
		syn.push(b);
		//cout<<"С��ĸ��ջ"<<endl;
		syn.push("PUSH");
		//cout<<"PUSH��ջ"<<endl;
		syn.push(b);
		//cout<<"С��ĸ��ջ"<<endl;
	}
	if(a==10)
	{
		syn.pop();
		syn.push(")");
		//cout<<")��ջ"<<endl;
		syn.push("E");
		//cout<<"E��ջ"<<endl;
		syn.push("(");
		//cout<<"(��ջ"<<endl;
		
	}
}
/*------------��synջ��ȡԪ�����ַ�����ǰԪ��compare ˳��ѹ��semջ��--------------*/
int compare(string a)
{   //����0------���ʽ����
    //����2----ƥ��ɹ�
	int w=1;
	while(w==1)//
	{
	    string top=syn.gettop();
		//cout<<"��synջ��ȡ��ջ��Ԫ��"<<top<<endl;
		if(top==a)
		{  // cout<<"ƥ��ɹ����ͷ�synջ��Ԫ��"<<a<<endl;
			syn.pop();
			w=2;
			break;
		}
		if(top=="PUSH")
		{
			syn.pop();
			sem.push(syn.gettop());
			//cout<<syn.gettop()<<"ѹ��semջ��"<<endl;
			syn.pop();
			w=1;
			//cout<<"semջ��Ԫ��Ϊ"<<sem.gettop()<<endl;
			continue;
		}
		if(top=="G+")
		{
			
			string p1,p2;
			p2=sem.pop();
			p1=sem.pop();
			cout<<"(+ "<<p1<<' '<<p2<<' '<<'t'<<i<<')'<<endl;
			char tt[3]={'t',i};
			sem.push(tt);
			//cout<<"semջ��Ԫ��Ϊ��"<<sem.gettop()<<endl;///////////////////////////
			syn.pop();
			i++;
	    	w=1;
			continue;
		}
		if(top=="G-")
		{
			
			string p1,p2;
			p2=sem.pop();
			p1=sem.pop();
			cout<<"(- "<<p1<<' '<<p2<<' '<<'t'<<i<<')'<<endl;
			char tt[3]={'t',i};
			sem.push(tt);
			//cout<<"semջ��Ԫ��Ϊ��"<<sem.gettop()<<endl;///////////////////////////
			syn.pop();
			i++;
	    	w=1;
			continue;
		}
		if(top=="G*")
		{
			string p1,p2;
			p2=sem.pop();
			p1=sem.pop();
			cout<<"(* "<<p1<<' '<<p2<<' '<<'t'<<i<<')'<<endl;
			char tt[3]={'t',i};
			sem.push(tt);
			//cout<<"semջ��Ԫ��Ϊ��"<<sem.gettop()<<endl;///////////////////////////
			syn.pop();
			i++;
			w=1;
			continue;
		}
		if(top=="G/")
		{
			
			string p1,p2;
			p2=sem.pop();
			p1=sem.pop();
			cout<<"(/ "<<p1<<' '<<p2<<' '<<'t'<<i<<')'<<endl;
			char tt[3]={'t',i};
			sem.push(tt);
			//cout<<"semջ��Ԫ��Ϊ��"<<sem.gettop()<<endl;///////////////////////////
			syn.pop();
			i++;
	    	w=1;
			continue;
		}
		//cout<<"��compare�С�������"<<endl;///////////////////////////////
		int b=getBDS(top,a);
		if(b==0)
		{
			/////cout<<"������ʽ�д���";
			w=0;
			break;
		}
		pushToSyn(b,a);
		w=1;
	}
	return w;

}
void main()
{
	int k=1;
	while(k)
	{
		  string s;
		  syn.push("#");
		  syn.push("E");
		  cout<<"������һ�����ʽ���ԡ�#������:"<<endl;
		  cin>>s;
		  for(int j=0;j<s.size();j++)
		  {
			  char p[2]={s[j]};  
			  //cout<<"����"<<p<<endl;
			  int c=compare(p);
			  if(c==0)
			  {
				  cout<<"������ʽ����"<<endl;
				  break;
			  }	  
		  }
		 cout<<"�м�������ɽ�����"<<endl;
		 cout<<"����---------- 1"<<endl;
		 cout<<"����---------- 0"<<endl;
		 cin>>k;
	}
}