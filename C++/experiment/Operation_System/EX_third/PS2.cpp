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

int P[MEMORYBLOK];//�������ʹ�õ�ҳ��
int Q[MEMORYBLOK];//����ڴ���Ӧ��ҳ��
int K=0;//ָ�룬ָ����һ���û���滻��֡

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
	

	//��PQ�ĳ�ʼ��
	for(int i=0; i<MEMORYBLOK; i++) {
		Q[i] = -1;
	}
	for(i=0; i<MEMORYBLOK; i++) {
		P[i] = -1;
	}
	for(i=0;i<N;i++){
		if(pageTable[i].flag == 1){
			P[K]=i;//���Ѿ������ڴ��е�ҳ�����δ���P�У�1��2��3
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

	cout<<"ѡȡ֡�����滻��"<<endl;

	int pageNum=P[K];
	int frame=pageTable[pageNum].frame;

	if(pageTable[pageNum].change == 1)//û���޸Ĺ���ֱ�Ӹ��ǣ��޸Ĺ��Ļ���д�ش���
	{
		cout<<"��������ҳ��Ϊ"<<pageNum<<"�е�����д�ش��̣���ַ��"<<pageTable[pageNum].location<<endl;
	}
	else
		cout<<"ҳ��Ϊ"<<pageNum<<"�е�����û���޸Ĺ���ֱ�Ӹ��ǣ�"<<endl;

	Q[frame] = -1;
	pageTable[K].flag = 0;
	cout<<"����ִ�в���"<<endl;
}

void run() {

	while( !actionForm.empty() ) {

		action a = actionForm.front();
		
		cout<<"*********************************"<<endl;
		if(a.operate=='s')
			cout<<"��������"<<"	ҳ�ţ�"<<a.pageNum<<" ƫ������"<<a.offset<<endl;
		else if(a.operate=='g')
			cout<<"������ȡ"<<"	ҳ�ţ�"<<a.pageNum<<" ƫ������"<<a.offset<<endl;
		else if(a.operate=='y')
			cout<<"��������λ"<<" ҳ�ţ�"<<a.pageNum<<"	ƫ������"<<a.offset<<endl;
		else
			cout<<"������"<<a.operate<<" ҳ�ţ�"<<a.pageNum<<" ƫ������"<<a.offset<<endl;

		int pageNum = a.pageNum;

		//�������������
		if (pageTable[pageNum].flag == 0) {
			cout<<"�����ҳ��"<<pageNum<<"���������У���Ҫ�Ӵ����ж�ȡ"<<endl;
			for (int i = 0; i < MEMORYBLOK; i++) {
				if ( Q[i] == -1 ) {//���ÿ����
					pageTable[pageNum].frame = i;
					cout<<"�Ѵ���"<<pageTable[pageNum].location<<"��ַ�е����ݼ��ص��������еĵ�"<<i<<"��֡"<<endl;
					Q[i] = pageNum;
					break;
				}
			}
			//���ڴ�����
			if (i==MEMORYBLOK)
			{
				cout<<"����������"<<endl;
				select();
				continue;//����ִ�и�����
			}
			pageTable[pageNum].flag = 1;
		}

		//������Ե�ַ
		int result;

		result = pageTable[pageNum].frame*LENGTH + a.offset;
		cout<<"���Ե�ַΪ��"<<pageTable[pageNum].frame<<"*"<<LENGTH<<"+"<<a.offset<<"="<<result<<endl;
		
		pageTable[pageNum].change = 1;

		actionForm.pop_front();

		//FIFO
		for(int i=0;i<MEMORYBLOK;i++){
			if(P[i]==pageNum)//�����ҳ���ڴ����Ѵ���
				break;
		}
		if(i==MEMORYBLOK){
			P[K]=pageNum;
			K = (K+1)%MEMORYBLOK;//������һ������֡
		}
	}
	cout<<"����P��"<<endl;
	for(int i=0;i<MEMORYBLOK;i++){
		cout<<i<<"     :     "<<P[i]<<"   "<<endl;
	}
	cout<<"����Q��"<<endl;
	for(i=0;i<MEMORYBLOK;i++){
		cout<<i<<"     :     "<<Q[i]<<"   "<<endl;
	}
}
main() {
	init();
	cout<<"�鳤Ϊ��"<<LENGTH<<endl;
	run();
	return 0;
}*/