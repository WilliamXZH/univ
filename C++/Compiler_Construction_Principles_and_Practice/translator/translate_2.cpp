#include<stdlib.h>
#include<fstream>
#include<iostream>
#include<string>
using namespace std;

/*-------------我是分割线--------以下是栈的定义---------------------------------*/
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

stack::stack(int size)		     //栈类的构造函数
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

void stack::push(const string &item)        //压栈操作
{
    if(full())
    {
        cerr<<"stack full, cannot push."<<endl;
        return;
    }
    top++;
    stacka[top]=item;
}

string stack::pop(void)				        //出栈操作
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

string stack::gettop(void) const	         //取栈顶操作
{
    if(empty())
    {
        cerr<<"stack empty, cannot gettop."<<endl;
        exit(1) ;
    }
    return stacka[top];
}
/*--------------栈定义结束-----------------------*/
stack syn;
stack sem;
char i='1';//用于记录生成的中间变量t的个数。
/*--------------返回应压栈的表达式序列号-----------------------*/
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
/*--------------向syn中压栈-----------------------*/
void pushToSyn(int a,string b)
{
	if(a==1)
	{
		syn.pop();////////////////////////
		syn.push("E1");
	    //cout<<"E1入栈"<<endl;
	    syn.push("T");
	    //cout<<"T入栈"<<endl;

	}
	if(a==2)
	{
		syn.pop();
		syn.push("E1");
		//cout<<"E1入栈"<<endl;
		syn.push("G+");
		//cout<<"G+入栈"<<endl;
		syn.push("T");
		//cout<<"T入栈"<<endl;
		syn.push("+");
		//cout<<"+入栈"<<endl;
	}
	if(a==3)
	{
		syn.pop();
		syn.push("E1");
		//cout<<"E1入栈"<<endl;
		syn.push("G-");
		//cout<<"G-入栈"<<endl;
		syn.push("T");
		//cout<<"T入栈"<<endl;
		syn.push("-");
		//cout<<"-入栈"<<endl;
	}
	if(a==4)
	{
		//cout<<"将空压入syn"<<endl;
		syn.pop();
	}
	if(a==5)
	{
		syn.pop();
		syn.push("T1");
		//cout<<"T1入栈"<<endl;
		syn.push("F");
		//cout<<"F入栈"<<endl;
	}
	if(a==6)
	{
		syn.pop();
		syn.push("T1");
		//cout<<"T1入栈"<<endl;
		syn.push("G*");
		//cout<<"G*入栈"<<endl;
		syn.push("F");
		//cout<<"F入栈"<<endl;
		syn.push("*");
		//cout<<"*入栈"<<endl;
	}
	if(a==7)
	{
		syn.pop();
		syn.push("T1");
		//cout<<"T1入栈"<<endl;
		syn.push("G/");
		//cout<<"G/入栈"<<endl;
		syn.push("F");
		//cout<<"F入栈"<<endl;
		syn.push("/");
		//cout<<"/入栈"<<endl;
	}
	if(a==8)
	{
		syn.pop();
	}
	if(a==9)
	{
		syn.pop();
		syn.push(b);
		//cout<<"小字母入栈"<<endl;
		syn.push("PUSH");
		//cout<<"PUSH入栈"<<endl;
		syn.push(b);
		//cout<<"小字母入栈"<<endl;
	}
	if(a==10)
	{
		syn.pop();
		syn.push(")");
		//cout<<")入栈"<<endl;
		syn.push("E");
		//cout<<"E入栈"<<endl;
		syn.push("(");
		//cout<<"(入栈"<<endl;
		
	}
}
/*------------从syn栈顶取元素与字符串当前元素compare 顺道压入sem栈中--------------*/
int compare(string a)
{   //返回0------表达式出错
    //返回2----匹配成功
	int w=1;
	while(w==1)//
	{
	    string top=syn.gettop();
		//cout<<"从syn栈中取得栈顶元素"<<top<<endl;
		if(top==a)
		{  // cout<<"匹配成功，释放syn栈顶元素"<<a<<endl;
			syn.pop();
			w=2;
			break;
		}
		if(top=="PUSH")
		{
			syn.pop();
			sem.push(syn.gettop());
			//cout<<syn.gettop()<<"压入sem栈中"<<endl;
			syn.pop();
			w=1;
			//cout<<"sem栈顶元素为"<<sem.gettop()<<endl;
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
			//cout<<"sem栈顶元素为："<<sem.gettop()<<endl;///////////////////////////
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
			//cout<<"sem栈顶元素为："<<sem.gettop()<<endl;///////////////////////////
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
			//cout<<"sem栈顶元素为："<<sem.gettop()<<endl;///////////////////////////
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
			//cout<<"sem栈顶元素为："<<sem.gettop()<<endl;///////////////////////////
			syn.pop();
			i++;
	    	w=1;
			continue;
		}
		//cout<<"在compare中。。。。"<<endl;///////////////////////////////
		int b=getBDS(top,a);
		if(b==0)
		{
			/////cout<<"输入表达式有错误！";
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
		  cout<<"请输入一个表达式，以‘#’结束:"<<endl;
		  cin>>s;
		  for(int j=0;j<s.size();j++)
		  {
			  char p[2]={s[j]};  
			  //cout<<"读入"<<p<<endl;
			  int c=compare(p);
			  if(c==0)
			  {
				  cout<<"输入表达式错误！"<<endl;
				  break;
			  }	  
		  }
		 cout<<"中间代码生成结束！"<<endl;
		 cout<<"继续---------- 1"<<endl;
		 cout<<"结束---------- 0"<<endl;
		 cin>>k;
	}
}