/*
 * ListNode.h
 *
 *  Created on: 2016Äê4ÔÂ24ÈÕ
 *      Author: Administrator
 */
#include <iostream>
using namespace std;
#ifndef LISTNODE_H_
#define LISTNODE_H_
template <class type> class ListNode{


public:
	ListNode(){
		next =NULL;
	}
	ListNode(const type &item,ListNode<type>*next1=NULL){
		data=item;
		next=next1;

	}
	~ListNode(){
		delete []next;
	}
	ListNode<type> *next;
	type data;
};
#endif /* LISTNODE_H_ */
