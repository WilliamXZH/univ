/*
 * List.h
 *
 *  Created on: 2016Äê4ÔÂ24ÈÕ
 *      Author: Administrator
 */
#include <iostream>
#include "ListNode.h"
using namespace std;
#ifndef LIST_H_
#define LIST_H_
template <class type> class List {
	ListNode<type>*first,*last;
	int length;
public:
	List(){
		first=NULL;
		last=NULL;
		length=0;
	}
	virtual ~List(){
	}
	void prin(){
		ListNode<type>*p=first;

		cout<<length<<endl;
		while(p!=NULL){
			type i=p->data;
			p=p->next;
			cout<<i<<endl;
		}
	}
	int Insert(const type x,const int i){

		if(i>length+1||i<=0){
			return 0;
		}
		ListNode<type>*insert =new ListNode<type>(x,NULL);
		ListNode<type>*p=first;
		int k=0;
		while(p!=NULL&&k<i){
			p=p->next;
			k++;
		}
		if(first==NULL||i==1){
			insert->next=first;
			if(first==NULL){
				last = insert;
			}
			first=insert;
		}
		else{
			insert->next=p->next;
			if(p->next==NULL){
				last=insert;
			}
			first=insert;
		}
		length++;
		return 1;


	}
};

#endif /* LIST_H_ */
