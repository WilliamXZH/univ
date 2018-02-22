#include<iostream>
#include<iomanip>
using namespace std;

struct pages{
	int sign;  
	long BlockNum;
	long place;
	pages(int c,long a,long b){
		BlockNum=a;
		place=b;
		sign=c;
	}
	pages(long a,long b){
		BlockNum=a;
		place=b;
		sign=1;
	}
	pages(long a){
		place=a;
		BlockNum=-1;
		sign=0;
	}
};
pages ing[7]={pages(1,5,11),pages(8,12),pages(9,13),pages(1,21),pages(22),pages(23),pages(121)};
int store[32];


struct Instruction{
	int pageNum;
	int UnitNum;
	struct Instruction*next;
	Instruction(int a,int b){
		pageNum=a;
		UnitNum=b;
		next=NULL;
	}
	Instruction(){next=NULL;}
	friend class InsList;
};

class InsList{
	Instruction*head,*p;
	public:
		InsList(){
		head=NULL;
		p=NULL;
	}
	void charu(Instruction &a);
	void run();
};
void InsList::charu(Instruction &a){
	if(head==NULL) {
		Instruction*newzhi=new Instruction();
		newzhi=&a;
		head=p=newzhi;
	}else{
		Instruction*newzhi=new Instruction();	
		newzhi=&a;
		p->next=newzhi;
		p=newzhi;
	}      
}
void InsList::run(){
	p=head;
	while(p!=NULL){
		if(ing[p->pageNum].sign==1){
			cout<<"第"<<p->pageNum<<"页的"<<"绝对地址为"<<'\t';
			cout<<(ing[p->pageNum].BlockNum*128+p->UnitNum)<<endl;
			p=p->next;}
		else {
			cout<<"页号*"<<p->pageNum<<"不在主存中，产生缺页中断随后调入主存"<<endl;
			int i;
			for(i=0;i<32;i++) {if(store[i]==0) break;
		}
		ing[p->pageNum].BlockNum=i;
		ing[p->pageNum].sign=1;store[i]=1;
		}
	}
}
int main(){        
	cout<<"初始时页表为 :"<<endl;
    cout<<"┏"<<"页号"<<"┳"<<"标志"<<"┳"<<"主存块号"<<"┳"<<"在磁盘位置"<<"┓"<<endl;
	for(int j=0;j<7;j++) {
		cout<<"┣"<<setw(4)<<j<<"╋"<<setw(4)<<ing[j].sign
			<<"╋"<<setw(8)<<ing[j].BlockNum<<"╋"
			<<setw(10)<<ing[j].place<<"┫"<<endl; 
	}//cout<<ing[2].BlockNum<<endl;
	cout<<"┗"<<"━━"<<"┻"<<"━━"<<"┻"<<"━━━━"<<"┻"<<"━━━━━"<<"┛"<<endl;
    store[1]=1;store[5]=1;store[8]=1;store[9]=1;
    InsList a;
    Instruction zh[]={Instruction(0,70),Instruction(1,50),Instruction(2,15),Instruction(3,21),Instruction(0,56),
					Instruction(6,40),Instruction(4,53),Instruction(5,23),Instruction(1,37),
					Instruction(2,78),Instruction(4,1),Instruction(6,84)};
    for(int i=0;i<12;i++) {a.charu(zh[i]);}
    cout<<"运行..."<<endl;
	a.run();
	char q;cout<<"输入任意字符退出"<<endl;cin>>q;
}