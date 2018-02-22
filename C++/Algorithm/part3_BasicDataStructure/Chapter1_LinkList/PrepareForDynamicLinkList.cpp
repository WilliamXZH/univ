#include<stdlib.h>
#include<stdio.h>
typedef int ElemType;
typedef struct List *link;
typedef struct List Lnode;

void display(link Head);
int locate(link Head,ElemType x);
int lenth(link Head);
int compare(link Head1,link Head2);
ElemType get(link Head,int i);
link create(link Head);
link connect(link Head1,link Head2);
link insert(link Head,ElemType x,int i);
link del(link Head,int i);
link setnull(link Head);

struct List
{
	ElemType data;
	struct List *next;
};
/*int main(){
	int l;
	link head1,head2;
	head1=create(head1);
	head2=create(head2);
	connect(head1,head2);
	head1=insert(head1,888,5);
	head1=del(head1,3);
	display(head1);
	printf("\n	length is %d\n",lenth(head1));
	printf("\n	get is %d\n",get(head1,3));
	printf("\n	locate 12 is %d",locate(head1,12));
	head=setnull(head);
}*/
//LinkList's building
link create(link Head){
	ElemType newData;
	link NewPoint;
	//先建立一个节点
	Head=(link)malloc(sizeof(Lnode));
	printf("please input number:\n");
	scanf("%d",&newData);
	Head->data=newData;
	Head->next=NULL;

	while(1){
		NewPoint=(link)malloc(sizeof(Lnode));
		if(NewPoint==NULL)break;
		printf("please input number:input '-1'means exit\n");
		scanf("%d",&newData);
		if(newData==-1)return Head;
		NewPoint->data=newData;
		NewPoint->next=Head;
		Head=NewPoint;
	}
	return Head;
}
link setnull(link Head){
	link p=Head;
	while(p!=NULL){
		p=p->next;
		free(Head);
		Head=p;
	}
	return p;
}
link insert(link Head,ElemType x,int i){
	link NewPoint,p=Head;
	int j=1;
	NewPoint=(link)malloc(sizeof(Lnode));
	NewPoint->data=x;
	if(i==1){
		NewPoint->next=Head;
		Head=NewPoint;
	}else{
		while(j<i-1&&p->next!=NULL){
			p=p->next;
			j++;
		}
		if(j==i-1){
			NewPoint->next=p->next;
			p->next=NewPoint;
		}else
			printf("insert is Failure, i is not right!");
	}
	return Head;
}
int lenth(link Head){
	int len=0;
	link p;
	p=Head;
	while(p!=NULL){
		len++;
		p=p->next;
	}
	return len;
}
ElemType get(link Head,int i){
	int j=1;
	link p;p=Head;
	while(j<i&&p!=NULL){
		p=p->next;
		j++;
	}
	if(p!=NULL)
		return p->data;
	else 
		printf("data is error!");
	return -1;
}
int locate(link Head,ElemType x){
	int n=0;link p;p=Head;
	while(p!=NULL&&p->data!=x){
		p=p->next;
		n++;
	}
	if(p!=NULL)
		return -1;
	else 
		return n+1;
}
void display(link Head){
	link p;p=Head;
	if(p==NULL)
		printf("\nList is empty\n");
	else
		do{
			printf("%d ",p->data);
			p=p->next;
		}while(p!=NULL);
}
link connect(link Head1,link Head2){
	link p;
	p=Head1;
	while(p->next!=NULL){
		p=p->next;
	}
	p->next=Head2;

	return Head1;
}
link del(link Head,int i){
	int j=1;
	link p,t;
	p=Head;
	if(i==1){
		p=p->next;
		free(Head);
		Head=p;
	}else{
		while(j<i-1&&p->next!=NULL){
			p=p->next;
			j++;
		}
		if(p->next!=NULL&&j==i-1){
			t=p->next;
			p->next=t->next;
		}
		if(t!=NULL)
			free(t);
	}
	return Head;
}
int compare(link Head1,link Head2){
	link p1,p2;
	p1=Head1;
	p2=Head2;
	while(1){
		if(p1->next==NULL&&p2->next==NULL)
			return 1;
		if(p1->data!=p2->data)
			return 0;
		else{
			p1=p1->next;
			p2=p2->next;
		}
	}
}
int main(){
	int l;
	link head1,head2;
	head1=create(head1);
	printf("\nHead1 is\n");
	display(head1);
	
	head2=create(head2);
	printf("\nHead2 is\n");
	display(head2);

	l=compare(head1,head2);
	printf("\nHead1+Head2 is\n");
	display(head1);

	l=lenth(head1);
	printf("\nlenth is %d\n",l);

	l=get(head1,12);
	printf("\nget is %d\n",l);

	l=locate(head1,12);
	printf("\nlocate 12 is %d",l);

	head1=insert(head1,888,5);
	display(head1);

	head1=del(head1,5);
	display(head1);

	head1=setnull(head1);
	display(head1);
}