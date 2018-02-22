#include<iostream>
#include<cmath> 
#include<cstdlib> 
using namespace std;
class item {
	public:
		friend class List;
		item(int p=0,int s=0,int b=0,int t=0){
			page=p;
			sign=s;
			block=b;
			time=t;
			next=NULL;
		} item *next;  
	private: 
		int page;
		int sign;
		int block;
		int time;
}; 
class List{ 
	public:  
		List(int p=0,int s=0,int b=0,int t=0) {
			list=new item(p,s,b,t);
		} 
		int check(int p);                      
		void print();
		int append(int p,int s,int b,int t);
		int diaohuanye(int p);
		void time();
	private: item *list; 
		item *end(); };  
		void List ::time()        
		{
			item *pt=list; 
			for(pt;pt;pt=pt->next) 
				if(pt->sign==1) 
			pt->time=pt->time+1; 
			return; 
		} 
		int List ::diaohuanye(int p){  
			int y,max=0;        
			item *pt=list;     
			item *pr=list;     
			for(pt;pt;pt=pt->next){ 
				if(pt->sign==1){ 
					if(pt->time > max) max=pt->time; 
				} 
			} 
			pt=list;           
			for(pt;pt;pt=pt->next)  { 
				if(pt->time==max) break; 
			}    
			pt->time=0; 
	 
			pt->sign=0;        
			cout<<"被调换的页的页号为:"<<pt->page<<"    "<<endl; cout<<"被调入的页的页号为:"<<p<<endl;  for(pr;pr;pr=pr->next)  { 
			if(pr->page==p)  break; 
			}
			pr->sign=1;         
			pr->block=pt->block;  
			pt->block=NULL;  
			y=pr->block; 
	 
			return y;               
		} 
		void List :: print(){ 
			cout<<"页号   标志  主存块号   进入时间"<<endl;  
			item *pt=list; 
			while(pt) {   
				if(pt->sign==1)  
					cout<<"  "<<pt->page<<"      "<<pt->sign<<"      "<<pt->block<<"        "<<pt->time<<endl;   
				else    
					cout<<"  "<<pt->page<<"    "<<pt->sign<<"     "<<" "<<"       "<<pt->time<<endl; 
				pt=pt->next;  
			}  
			cout<<endl;		
			
		} 
		int List::append(int p,int s,int b,int t){  
			item *pt=new item(p,s,b,t);  
			(end())->next=pt;  
			return 1; 
		} 
		item *List::end(){  
			item *q,*pt=list;  
			for(q=list;pt;q=pt,pt=pt->next);  
			return q; 
		} 
		int List::check(int p){  
			item *pt=list;  
			int a=-1;  
			for(;pt;pt=pt->next){  
				if(pt->sign==1&&pt->page==p)      
					a=pt->block;  
				}   
			return a; 
		} 
		void main() {  
			List list(0,1,5,4);        
			list.append(1,1,8,3);       
			list.append(2,1,9,2);       
			list.append(3,1,1,1);       
			list.append(4,0,NULL,0);  
			list.append(5,0,NULL,0);  
			list.append(6,0,NULL,0); 
			cout<<"**********模拟FIFO页面调度算法处理缺页中断**********"<<endl;
			cout<<"+++++++++++++++++++页表初始状态如下+++++++++++++++++"<<endl;  
			list.print();  
			int m=0,n;  
			int c=0,flag=0;  
			for(int i=0,k=0;;i++){
				cout<<"*****************"<<"第"<< (i+1)<<"步"<<"操作"<<"****************"<<endl;
				cout<<"请输入该操作对应的页号:";
				cin>>n;
				while(k==0){    
					if((n<0||n>=7)&&n!=999){     
						cout<<"输入错误!重新输入:";     
						k=0;     
						cin>>n;    
					}    
					else if(n==999){
						flag=1;
						k=1;
					}    
					else	k=1;   
				}  
				 if(flag==1)    
				break;   
				m=list.check(n);   
				if(m!=-1){   
				cout<<"该页已在主存中，所在的主存块号:"<<m<<endl;    
				list.time();   
			}else if(m==-1){
			cout<<"*缺页中断,页号:"<<n<<endl;  
			cout<<"************调用FIFO页面调度算法处理中断*************"<<endl;    
			c=list.diaohuanye(n);     
			list.time();   
			cout<<"该页所在的主存块号:"<<c<<endl; 
			cout<<"****************"<<"中断处理后页表的状态"<<"****************"<<endl;
		}
		list.print();
	} 
}
