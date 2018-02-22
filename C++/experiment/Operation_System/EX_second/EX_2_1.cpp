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
		int Empty_Quene();//�ÿ����Ա�
		int UniqueTest();//�ж��Ƿ�ֻʣ��һ�����Ѷ��嵫δʹ��
		int Test_If_Run();//����Ƿ���Ҫ��������
		void Running(PCB *target);//����������������Ҫ����
		void TestIfFinish(PCB *P);//����Ƿ���ɣ��Ѷ��嵫δʹ��
		void In_Quene(PCB *p);//���Ա��ʼ������
		void In_Quene(PCB *p,PCB *pre);//�Ǳ�׼���Ա��ʼ��������δ�����ʹ��
		void In_Quene(char *name,int time,int priority);//����PCB���������Ա�
		void Init_Quene();//��ʼ�����Ա�
		void Init_Quene(int n,int *time,int *prio);//��ʼ�����Ա�ʹ��������������
		void Init_AutoSort_Quene(int n,int *time,int *prio);//��ʼ�����Ա��Զ�����δ����
		void Init_Quene(int n,char **name,int *time,int *prio);//�����������ĳ�ʼ�����Ա�
		void Input_Quene();//�������Ա�
		void Print_Result();//��ӡ���ս��
		void Print_Quene();//��ӡ������Ϣ
		void Print_PCB(PCB *p);//��ӡһ��PCB����Ϣ
		void ScheduleRunning();//�������е���ڣ������￪ʼ
		void Sort_Quene();//���Ա�����
		void MenuOfQuene();
		PCB* Out_Quene();//���Ա�ɾ������
		PCB* Out_PCB_Of(PCB *p);//���Ա�ɾ��������p֮���һ��PCB
		PCB* Get_Pre_PCB_Of(PCB *p);//��ȡ���Ա���λ��p֮ǰ�����һ��PCB
		PCB* Get_Next_PCB_Of(PCB *p);//��ȡ���ȼ�����p����p�����С��PCB
		PCB* GetHighestPriority(PCB *END);//���������ȼ���PCB
		PCB* GetHighestPriority(PCB *END,int count);//END֮���count��PCB�����ȼ���ߵ�PCB
		PCB* GetLowestPriority();//��ȡ������ȼ�PCB��δʹ��
};
void QUENE::Input_Quene(){
	int i,n,*time,*prio;
	char **name;
	cout<<"������̸���n(��n>0,����Ҫ�����������,n<0,���Զ���������):";
	cin>>n;
	time=(int*)malloc(abs(n)*sizeof(int));
	prio=(int*)malloc(abs(n)*sizeof(int));
	cout<<"����"<<abs(n)<<"��Ҫ������ʱ��"<<endl;
	for(i=0;i<abs(n);i++)cin>>time[i];
	cout<<"����"<<abs(n)<<"�����ȼ���"<<endl;
	for(i=0;i<abs(n);i++)cin>>prio[i];
	if(n>0){
		name=(char**)malloc(abs(n)*sizeof(char*));
		cout<<"����"<<abs(n)<<"����������"<<endl;
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
		cout<<"1.������ʼ��"<<endl;
		cout<<"2.�����ʼ��"<<endl;
		cout<<"3.���Ա�����"<<endl;
		cout<<"4.��������"<<endl;
		cout<<"5.���Ա�鿴"<<endl;
		cout<<"6.���Ա��ÿ�"<<endl;
		cout<<"0.�˳�"<<endl;
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