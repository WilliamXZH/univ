#include<iostream>
using namespace std;

typedef struct uid
{
	unsigned long data;
	struct uid *next;
}Node;

Node *head;
Node *tail;

void initialList();
bool testIfExist(unsigned long id);
void addNode(unsigned long id);

int main()
{
	int m = 0;
	unsigned long tmp;
	initialList();
	cin>>tmp;
	while (tmp!=0)
	{
		m++;
		if (testIfExist(tmp))
		{
			m--;
		}else
		{
			addNode(tmp);
		}
		cin>>tmp;
	}
	cout<<m;
}
bool testIfExist(unsigned long id)
{
	Node *ptr = head->next;
	while (ptr!=NULL)
	{
		if(ptr->data==id)
		{
			return true;
		}
		ptr = ptr->next;
	}

	return false;
}

void addNode(unsigned long id)
{
	Node *tmp = (Node*)malloc(sizeof(Node));
	tmp->data = id;

	tail->next = tmp;
	tmp->next = NULL;
	tail = tmp;
}

void initialList()
{
	head = (Node*)malloc(sizeof(Node));
	tail = head;
	tail->next = NULL;
}
