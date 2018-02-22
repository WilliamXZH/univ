#include<iostream>
using namespace std;

struct State
{
	int m;//the number of missionarys
	int c;//the number of cannibals
	int direct;//the direct boat is going
	State* next;
};

struct Rout
{
	State* p;
	int step;
	Rout(State* q,int s)
	{
		p=q;
		step=s;
	}
}; 

int isValid(int m,int c,int direct,State* p)
{
	if(m<0 || m>MISSIONARYS)
	{
		cout<<"illeagal number of missionarys !"<<endl;
		return 0;
	}
	if(c<0 || c>CANNIBALS)
	{
		cout<<"illeagal number of cannibals !"<<endl;
		return 0;
	}
	if(m<c && m!=0 || MISSIONARYS-m<CANNIBALS-c && MISSIONARYS-m!=0)
	{
		cout<<"missionarys will be eaten!"<<endl;
		return 0;
	} 
	if(p==NULL)return 1;
	do
	{
		if(p->m==m && p->c ==c && p->direct ==direct)
		{
			cout<<"Exists!if continue,may couse recurrence !"<<endl;
			return 0;
		}
		p=p->next ;
	}while(p!=NULL);
	return 1;
} 

void ShowMatrix()
{
	for(int m=0;m<=MISSIONARYS;m++)
	{
		for(int c=0;c<=CANNIBALS;c++)
		{
			cout<<isValid(m,c,0,NULL)<<" ";
		}
		cout<<endl;
	}
} 

void show(State* p) 
{
	cout<<"("<<p->m <<" ,"<<p->c <<")";
	while(p->next !=NULL)
	{
		p=p->next ;
		cout<<"<--("<<p->m <<" ,"<<p->c <<")";
	}
	cout<<endl;
} 

void showRout(vector<Rout> list){
	int MinStep=999999;
	State* MinP=NULL;
	for(int i=0;i<list.size ();i++){
		cout<<"##"<<list[i].step<<"##";
		if(list[i].step<MinStep)
		{
			MinStep=list[i].step;
			MinP=list[i].p;
		}
		show(list[i].p );
	}
	cout<<"MinStep=##"<<MinStep<<"##";
	if(MinStep!=999999)
	{
		show(MinP);
	} 
}

//recursive a lgorithm
void findMethod(int m,int c,int direct,State* p,int step){
	// cout<<"m="<<m<<",c="<< c <<" ,direct="<<direct<<endl;
	State* q=new State();
	q->next =p;
	q->m=m;
	q->c=c;
	q->direct =direct;
	p=q;
	//show(p);
	int successNumTemp=successNum;
	if(m==0 && c==0){
		cout<<"the programme has searched "<<routNum<<" routs!"<<endl;
		show(p);
		Rout r(p,step);
		listSuccessRout.push_back(r);
		successNum++;
		cout<<"Successfully!used "<<step<<" steps!"<<endl;
		return;
	}
	for(int i =0;i<=BOATCAPACITY;i++){
		for(int j =0;j<=BOATCAPACITY-i;j++){
			if(i==0 && j==0 || !(i>=j || i==0))continue;//step over the illeagal stretagy
			int mnew=m+direct*i;
			int cnew=c+direct*j;
			cout<<"mnew="<<mnew<<",cnew="<< cnew <<endl;
			routNum++;
			if(isValid(mnew,cnew,-direct,p)){
				findMethod(mnew,cnew,-direct,p,step+1);
			}
		}
	}
	if(successNumTemp==successNum){
	delete p;//to free the space
	}
} 



