/*#include <iostream>
#include "list"
using namespace std;

#define N 11
#define M 12
#define MEMORYBLOK 4
#define LENGTH 128

struct page {
	int number;
	int flag;
	int frame;
	int location;
	int change;
};

struct action {
	char operate;
	int pageNum;
	int offset;
};

struct page pageTable[N];
list<action> actionForm;

int P[MEMORYBLOK];//存放依次使用的页号
int Q[MEMORYBLOK];//存放内存块对应的页号
int K=0;//指针，指向下一可用或待替换的帧

void init() {

	page page0 = {0,1,1,11,0};
	pageTable[0] = page0;

	page page1 = {1,1,2,12,0};
	pageTable[1] = page1;

	page page2 = {2,1,3,13,0};
	pageTable[2] = page2;

	page page3 = {3,0,-1,21,0};
	pageTable[3] = page3;

	page page4 = {4,0,-1,22,0};
	pageTable[4] = page4;

	page page5 = {5,0,-1,23,0};
	pageTable[5] = page5;

	page page6 = {6,0,-1,121,0};
	pageTable[6] = page6;
	

	//对PQ的初始化
	for(int i=0; i<MEMORYBLOK; i++) {
		Q[i] = -1;
	}
	for(i=0; i<MEMORYBLOK; i++) {
		P[i] = -1;
	}
	for(i=0;i<N;i++){
		if(pageTable[i].flag == 1){
			P[K]=i;//对已经放入内存中的页，依次存入P中，1，2，3
			K = (K+1)%MEMORYBLOK;
		}
	}
	for(i=0; i<N; i++) {
		if(pageTable[i].flag == 1) {
			int frame = pageTable[i].frame;
			Q[frame] = pageTable[i].number;//Q[1]=0;Q[2]=1;Q[3]=2;
		}
	}
	
	action a1={'+',1,70};
	action a2={'+',1,50};
	action a3={'*',2,15};
	action a4={'s',3,21};
	action a5={'g',0,56};
	action a6={'-',6,40};
	action a7={'y',4.53};
	action a8={'+',5,23};
	action a9={'s',1,37};
	action a10={'g',2,78};
	action a11={'+',4,1};
	action a12={'s',6,84};

	actionForm.push_back(a1);
	actionForm.push_back(a2);
	actionForm.push_back(a3);
	actionForm.push_back(a4);
	actionForm.push_back(a5);
	actionForm.push_back(a6);
	actionForm.push_back(a7);
	actionForm.push_back(a8);
	actionForm.push_back(a9);
	actionForm.push_back(a10);
	actionForm.push_back(a11);
	actionForm.push_back(a12);
}


void select(){

	cout<<"选取帧进行替换："<<endl;

	int pageNum=P[K];
	int frame=pageTable[pageNum].frame;

	if(pageTable[pageNum].change == 1)//没有修改过，直接覆盖，修改过的话，写回磁盘
	{
		cout<<"把主存中页号为"<<pageNum<<"中的内容写回磁盘，地址："<<pageTable[pageNum].location<<endl;
	}
	else
		cout<<"页号为"<<pageNum<<"中的内容没有修改过，直接覆盖！"<<endl;

	Q[frame] = -1;
	pageTable[K].flag = 0;
	cout<<"重新执行操作"<<endl;
}

void run() {

	while( !actionForm.empty() ) {

		action a = actionForm.front();
		
		cout<<"*********************************"<<endl;
		if(a.operate=='s')
			cout<<"操作：存"<<"	页号："<<a.pageNum<<" 偏移量："<<a.offset<<endl;
		else if(a.operate=='g')
			cout<<"操作：取"<<"	页号："<<a.pageNum<<" 偏移量："<<a.offset<<endl;
		else if(a.operate=='y')
			cout<<"操作：移位"<<" 页号："<<a.pageNum<<"	偏移量："<<a.offset<<endl;
		else
			cout<<"操作："<<a.operate<<" 页号："<<a.pageNum<<" 偏移量："<<a.offset<<endl;

		int pageNum = a.pageNum;

		//如果不在主存中
		if (pageTable[pageNum].flag == 0) {
			cout<<"请求的页："<<pageNum<<"不在主存中，需要从磁盘中读取"<<endl;
			for (int i = 0; i < MEMORYBLOK; i++) {
				if ( Q[i] == -1 ) {//即该块空闲
					pageTable[pageNum].frame = i;
					cout<<"把磁盘"<<pageTable[pageNum].location<<"地址中的内容加载到了主存中的第"<<i<<"个帧"<<endl;
					Q[i] = pageNum;
					break;
				}
			}
			//即内存已满
			if (i==MEMORYBLOK)
			{
				cout<<"主存已满！"<<endl;
				select();
				continue;//重新执行该命令
			}
			pageTable[pageNum].flag = 1;
		}

		//计算绝对地址
		int result;

		result = pageTable[pageNum].frame*LENGTH + a.offset;
		cout<<"绝对地址为："<<pageTable[pageNum].frame<<"*"<<LENGTH<<"+"<<a.offset<<"="<<result<<endl;
		
		pageTable[pageNum].change = 1;

		actionForm.pop_front();

		//FIFO
		for(int i=0;i<MEMORYBLOK;i++){
			if(P[i]==pageNum)//如果该页在内存中已存在
				break;
		}
		if(i==MEMORYBLOK){
			P[K]=pageNum;
			K = (K+1)%MEMORYBLOK;//计算下一个空闲帧
		}
	}
	cout<<"数组P："<<endl;
	for(int i=0;i<MEMORYBLOK;i++){
		cout<<i<<"     :     "<<P[i]<<"   "<<endl;
	}
	cout<<"数组Q："<<endl;
	for(i=0;i<MEMORYBLOK;i++){
		cout<<i<<"     :     "<<Q[i]<<"   "<<endl;
	}
}
main() {
	init();
	cout<<"块长为："<<LENGTH<<endl;
	run();
	return 0;
}*/