#include<iostream>
using namespace std;
#define PrintLine for(int increase=0;increase<50;increase++)cout<<"-";cout<<endl;
#define abs(x) (x>0?x:-x)
typedef struct process
{
	char ProcessName[3];
	int CPUTime;
	int NeedTime;
	int Priority;
	char state;
	int RoundTime,WaitingTime;
	struct process *pointer;
}PCB;
class QUENE
{
	private:
		int n;
		int CPUTIME;
		PCB *head,*tail;
	public:
		QUENE();
		int Empty_Quene();//置空线性表
		int UniqueTest();//判断是否只剩下一个，已定义但未使用
		int Test_If_Run();//检测是否需要调度运行
		void Running(PCB *target);//调度运行所做的主要操作
		void TestIfFinish(PCB *P);//检测是否完成，已定义但未使用
		void In_Quene(PCB *p);//线性表初始化操作
		void In_Quene(PCB *p,PCB *pre);//非标准线性表初始化操作，未定义和使用
		void In_Quene(char *name,int time,int priority);//构造PCB并链接线性表
		void Init_Quene();//初始化线性表
		void Init_Quene(int n,int *time,int *prio);//初始化线性表并使用数组载入数据
		void Init_AutoSort_Quene(int n,int *time,int *prio);//初始化线性表并自动排序，未定义
		void Init_Quene(int n,char **name,int *time,int *prio);//包含进程名的初始化线性表
		void Input_Quene();//输入线性表
		void Print_Result();//打印最终结果
		void Print_Quene();//打印队列信息
		void Print_PCB(PCB *p);//打印一个PCB的信息
		void ScheduleRunning();//调度运行的入口，从这里开始
		void Sort_Quene();//线性表排序
		void MenuOfQuene();
		PCB* Out_Quene();//线性表删除操作
		PCB* Out_PCB_Of(PCB *p);//线性表删除操作，p之后的一个PCB
		PCB* Get_Pre_PCB_Of(PCB *p);//获取线性表中位于p之前最近的一个PCB
		PCB* Get_Next_PCB_Of(PCB *p);//获取优先级低于p且与p相差最小的PCB
		PCB* GetHighestPriority(PCB *END);//获得最高优先级的PCB
		PCB* GetHighestPriority(PCB *END,int count);//END之后的count个PCB中优先级最高的PCB
		PCB* GetLowestPriority();//获取最低优先级PCB，未使用
};
void QUENE::Input_Quene(){
	int i,n,*time,*prio;
	char **name;
	cout<<"输入进程个数n(若n>0,则需要输入进程名称,n<0,则自动生成名称):";
	cin>>n;
	time=(int*)malloc(abs(n)*sizeof(int));
	prio=(int*)malloc(abs(n)*sizeof(int));
	cout<<"输入"<<abs(n)<<"个要求运行时间"<<endl;
	for(i=0;i<abs(n);i++)cin>>time[i];
	cout<<"输入"<<abs(n)<<"个优先级数"<<endl;
	for(i=0;i<abs(n);i++)cin>>prio[i];
	if(n>0){
		name=(char**)malloc(abs(n)*sizeof(char*));
		cout<<"输入"<<abs(n)<<"个进程名字"<<endl;
		for(i=0;i<abs(n);i++){
			name[i]=(char*)malloc(3*sizeof(char));
			cin>>name[i];
		}
		Init_Quene(n,name,time,prio);
	}else Init_Quene(abs(n),time,prio);
}
void QUENE::MenuOfQuene(){
	int choose;
	int time[5]={2,3,1,2,4},prio[5]={1,5,3,4,2};
	Empty_Quene();
	while(1){
		PrintLine;
		cout<<"1.样例初始化"<<endl;
		cout<<"2.输入初始化"<<endl;
		cout<<"3.线性表排序"<<endl;
		cout<<"4.调度运行"<<endl;
		cout<<"5.线性表查看"<<endl;
		cout<<"6.线性表置空"<<endl;
		cout<<"0.退出"<<endl;
		if(!(cin>>choose))return;
		switch(choose){
			case 0:
				return;
			case 1:
				Init_Quene(5,time,prio);
				break;
			case 2:
				Input_Quene();
				break;
			case 3:
				Sort_Quene();
				break;
			case 4:
				ScheduleRunning();
				break;
			case 5:
				Print_Quene();
				break;
			case 6:
				Empty_Quene();
				break;
			default:
				cout<<"choose error!"<<endl;
				break;
		}
	}
}
int main(){
	QUENE qu;
	qu.MenuOfQuene();
}

PCB* QUENE::GetLowestPriority(){
	PCB *p=head,*temp=p;
	while(p!=NULL){
		if(p->Priority<temp->Priority)temp=p;
		p=p->pointer;
	}
	return temp;
}
PCB* QUENE::Get_Pre_PCB_Of(PCB *p){
	/*PCB *tem=head,*temp=GetHighestPriority(tail);
	while(tem!=NULL){
		if(tem->Priority>=p->Priority&&tem->Priority<temp->Priority)temp=tem;
		tem=tem->pointer;
	}*/
	PCB *tem=head;
	while(tem!=NULL){
		if(tem->pointer==p)break;
		tem=tem->pointer;
		//cout<<"GetPrePCB"<<endl;

	}
	return tem;
}
PCB* QUENE::Get_Next_PCB_Of(PCB *p){
	PCB *tem=head,*temp=GetLowestPriority();
	while(tem!=NULL){
		if(tem->Priority<=p->Priority&&tem->Priority>temp->Priority)temp=tem;
		//cout<<"GetNextPCB:"<<tem->ProcessName<<endl;
		tem=tem->pointer;
	}
	return temp;
}
void QUENE::Sort_Quene(){
	int count=n;
	if(head==NULL){cout<<"The quene is null."<<endl;return;}
	PCB *pre,*thead=GetHighestPriority(tail),*p=thead;
	while(count--){
		pre=Get_Pre_PCB_Of(p);
		if(pre==NULL)head=p->pointer;
		else pre->pointer=p->pointer;
		tail->pointer=p;
		p->pointer=NULL;
		tail=p;
		p=GetHighestPriority(p,count);
		//cout<<count<<endl;
	}
	head=thead;
}
int QUENE::UniqueTest(){
	int count=0;
	PCB *p=head;
	while(p!=NULL){
		if(!p->NeedTime)count++;
		p=p->pointer;
		cout<<"UniqueTest"<<endl;
	}
	//cout<<n<<" "<<count<<endl;
	if(1+count==n)return 1;
	else return 0;
}
PCB* QUENE::GetHighestPriority(PCB* END){
	return GetHighestPriority(END,n);
}
PCB* QUENE::GetHighestPriority(PCB* END,int count){
	int prio=-20;
	PCB *p=END->pointer,*temp=p;
	if(p==NULL)p=head;
	while(count--){
		if(p->NeedTime&&p->Priority>prio){
			temp=p;
			prio=p->Priority;
		}
		if(p->pointer!=NULL)p=p->pointer;
		else p=head;
	}
	return temp;
}
void QUENE::Running(PCB *target){
	PCB *p=head;
	CPUTIME++;
	while(p!=NULL){
		if(!p->NeedTime)p->state='E';//TestIfFinish(p);
		else if(p==target){
			p->CPUTime++;
			p->NeedTime--;
			p->Priority--;
			if(p->NeedTime)p->state='W';
			else{p->state='E';p->RoundTime=CPUTIME;}
		}else if(p->CPUTime){
			p->CPUTime++;
			p->state='R';
			p->WaitingTime++;
		}else p->WaitingTime++;
		p=p->pointer;
	}
}
void QUENE::TestIfFinish(PCB *p){
	p->state='E';
}
void QUENE::ScheduleRunning(){
	PCB *current=head;
	if(head==NULL){cout<<"The Quene is null."<<endl;return;}
	Print_Quene();
	while(Test_If_Run()){
		current=GetHighestPriority(current);
		Running(current);
		cout<<"Running:"<<current->ProcessName<<endl;
		Print_Quene();
		_sleep(1000);
	}
	Print_Result();
}
int QUENE::Test_If_Run(){
	PCB *p=head;
	while(p!=NULL){
		if(p->NeedTime)return 1;
		else p=p->pointer;
	}
	return 0;
}
int QUENE::Empty_Quene(){
	int count=n;
	PCB *p;
	if(!n)return 0;
	while(count--){
		p=Out_Quene();
		if(p!=NULL)Print_PCB(p);
		else cout<<"syntax error:The PCB is NULL."<<endl;
		//Print_PCB(Out_Quene());
	}
	return 1;
}
void QUENE::Print_Result(){
	PCB *p=head;
	cout<<"NAME "<<"RoundTime "<<"WaitingTime"<<endl;
	while(p!=NULL){
		cout<<" "<<p->ProcessName<<"\t"<<p->RoundTime<<"\t   "<<p->WaitingTime<<endl;
		p=p->pointer;
	}
}
void QUENE::Print_PCB(PCB *p){
	cout<<" "<<p->ProcessName<<"\t"<<p->CPUTime<<"\t"<<p->NeedTime<<"\t"<<p->Priority<<"\t"<<p->state<<endl;
}
void QUENE::Print_Quene(){
	PCB *p=head;
	cout<<"CPUTIME:"<<CPUTIME<<endl;
	cout<<"NAME"<<" "<<"CPUTIME"<<" "<<"NEEDTIME"<<" "<<"PRIORITY"<<" "<<"STATE"<<endl;
	while(p!=NULL){
		Print_PCB(p);
		p=p->pointer;
	}
}
PCB* QUENE::Out_Quene(){
	return Out_PCB_Of(head);
}
PCB* QUENE::Out_PCB_Of(PCB *p){
	PCB *pre;
	if(p==NULL)return NULL;
	if(p==head)head=p->pointer;
	else{
		pre=Get_Pre_PCB_Of(p);
		pre->pointer=p->pointer;
		if(p==tail)tail=pre;
	}
	p->pointer=NULL;
	n--;
	return p;
}
QUENE::QUENE(){Init_Quene();}
void QUENE::Init_Quene(){
	n=0;
	CPUTIME=0;
	//head=(PCB*)malloc(sizeof(PCB));
	head=NULL;
	tail=head;
}
void QUENE::Init_Quene(int n,int *time,int *prio){
	int i;
	char **name=(char**)malloc(n*sizeof(char*));
	for(i=0;i<n;i++){
		name[i]=(char*)malloc(3*sizeof(char));
		name[i][0]='P';
		name[i][1]=i+'1';
		name[i][2]='\0';
	}
	Init_Quene(n,name,time,prio);
}
void QUENE::Init_Quene(int n,char **name,int *time,int *prio){
	int i;
	Init_Quene();
	for(i=0;i<n;i++)In_Quene(name[i],time[i],prio[i]);
}
void QUENE::In_Quene(char *name,int time,int priority){
	PCB *p=(PCB*)malloc(sizeof(PCB));
	strcpy(p->ProcessName,name);
	p->NeedTime=time;
	p->CPUTime=0;
	p->Priority=priority;
	p->pointer=NULL;
	p->state='R';
	p->RoundTime=0;
	p->WaitingTime=0;
	In_Quene(p);
}
void QUENE::In_Quene(PCB *p){
	if(head==NULL)head=p;
	else tail->pointer=p;
	tail=p;
	n++;
}