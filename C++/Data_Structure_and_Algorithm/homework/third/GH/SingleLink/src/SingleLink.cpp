//============================================================================
// Name        : SingleLink.cpp
// Author      : 
// Version     :
// Copyright   : Your copyright notice
// Description : Hello World in C++, Ansi-style
//============================================================================
#include <iostream>
#include "List.h"
#include "ListNode.h"
using namespace std;
int main() {
	List <int> test;
	if(test.Insert(5,1)==0){
		cout<<"����ʧ��";
	}
	else{
		cout<<"����ɹ�";
	}
	test.Insert(4,1);
	test.Insert(3,1);
	test.Insert(2,1);
	test.Insert(1,1);
	test.prin();



	return 0;
}
