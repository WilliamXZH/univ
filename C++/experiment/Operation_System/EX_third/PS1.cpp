#include <iostream>
#include "list"
using namespace std;

#define N 11
#define M 12
#define MEMORYBLOK 10
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

void init() {

	page page0 = {0,0,5,11,0};
	pageTable[0] = page0;

	page page1 = {1,1,8,12,0};
	pageTable[1] = page1;

	page page2 = {2,1,9,13,0};
	pageTable[2] = page2;

	page page3 = {3,1,1,21,0};
	pageTable[3] = page3;

	page page4 = {4,0,-1,22,0};
	pageTable[4] = page4;

	page page5 = {5,0,-1,23,0};
	pageTable[5] = page5;

	page page6 = {6,0,-1,121,0};
	pageTable[6] = page6;
	//
	pageTable[7] = page6;

	pageTable[8] = page6;

	pageTable[9] = page6;

	pageTable[10] = page6;
	

	//对PQ的初始化
	/*for(int i=0; i<MEMORYBLOK; i++) {
		Q[i] = -1;
	}
	for(i=0; i<MEMORYBLOK; i++) {
		P[i] = -1;
	}
	for(i=0;i<N;i++){
		if(pageTable[i].flag == 1){
			P[K]=i;
			K = (K+1)%MEMORYBLOK;
		}
	}
	for(i=0; i<N; i++) {
		if(pageTable[i].flag == 1) {
			int frame = pageTable[i].frame;
			Q[frame] = pageTable[i].number;
		}
	}*/
	
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

void run() {
	while( !actionForm.empty() ) {

		action a = actionForm.front();
		
		cout<<"*****************************************************"<<endl;
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
			cout<<"*"<<pageNum<<endl;
		}

		//计算绝对地址
		else{
			int result;

			result = pageTable[pageNum].frame*LENGTH + a.offset;
			cout<<"绝对地址为："<<pageTable[pageNum].frame<<"*"<<LENGTH<<"+"<<a.offset<<"="<<result<<endl;
		
			pageTable[pageNum].change = 1;
		}
		actionForm.pop_front();
	}
}
main() {
	init();
	run();
	return 0;
}