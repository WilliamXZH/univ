#include<iostream>

#define length(a) (sizeof(a)/sizeof(a[0]))

using namespace std;

struct ListNode
{
	int val;
	ListNode *next;
	ListNode(int x):val(x),next(NULL){}
};

ListNode * addTwoNumber(ListNode *l1,ListNode *l2){
	return NULL;
}

void CreateList(ListNode *l,int p[]){
	ListNode *end=l;
	for(int i=0;i<length(p);i++){
		ListNode tmp;
		tmp.val=p[i];
		end.next=tmp
	}
}

int main(){
	
	ListNode *l1;

	return 0;
}