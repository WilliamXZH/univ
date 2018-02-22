#include <iostream>
using namespace std;
#include <stdio.h>
#include <string>
#include "node.h"
#include "Graph.h"
#define max 10
#define infinite 32767


int Graph::location(string name){
	for (int i = 0; i < number_node; i++)
	{
		if (node_name[i]==name)return i;	
	}
	    return -1;
}

void Graph::CreatGraph(){
	cout<<"�����붥�����ͱ���:";
	cin>>number_node>>number_edge;
	cout<<endl;
	cout<<"       \"��������������Ϣ\""<<endl;
	cout<<endl;


	cout<<"����������������:";
	for (int i = 0; i < number_node; i++)
	{
		cin>>node_name[i];
		
	}


	Node_List * *po[max];
	

	for (int j = 0; j < number_node; j++)
	{
		list[j].name=node_name[j];
		po[j] = &list[j].next;
	}

	string node_one,node_two;
	int weight,n,m;

	for (i = 1; i < number_edge+1; i++)
	{   
		cout<<"�������"<<i<<"���ߵ����������Լ��ñߵ�Ȩֵ��";
	    cin>>node_one>>node_two>>weight;
		n=location(node_one);
		m=location(node_two);
		if ((n!=-1)&&(m!=-1))
		{
            *po[n]=new Node_List(m,weight);
			po[n]=&((*po[n])->next);
			*po[m]=new Node_List(n,weight);
			po[m]=&((*po[m])->next);
		}

	}

	Node_List *pol;


	//�ڽӾ����ʼ��ȫ��Ϊinfinite
	for (int k = 0; k < number_node; k++)
	{
		for (int q = 0; q < number_node; q++)
		{
			matrix[k][q]=infinite;
		}
	}

	//Ϊ�ڽӾ���ֵ
	for (i = 0; i < number_node; i++)
	{
		pol = list[i].next;
		while (pol)
		{
			n=pol->position;
			m=pol->weight;
			pol=pol->next;
			matrix[i][n]=m;
		}

	}

	//�ڽӾ���Խǵ�ֵΪ0
	for (i = 0; i < number_node; i++)
	{
		for (int j = 0; j < number_node; j++)
		{
			if (i==j)matrix[i][j]=0;
		}
	}


}

void Graph::OutputGraph(){
	cout<<endl;
	cout<<"�ڽ׾���Ϊ"<<endl;
	for (int i = 0; i < number_node; i++)
	{
		cout<<"   ";
		cout<<node_name[i];	
	}
	cout<<endl;
	for (int w = 0; w < number_node; w++)
	{
		cout<<node_name[w];
		for (int z = 0; z < number_node; z++)
		{   
			cout<<"   ";
			if(matrix[w][z]==0)cout<<"0    ";
			else if(matrix[w][z]==infinite)cout<<matrix[w][z];
			else cout<<matrix[w][z]<<"    ";
		}
		cout<<endl;
	}
}

bool Graph::IsEdge(string node_one,string node_two){

	int n=location(node_one);
	int m=location(node_two);
	if(matrix[n][m]==0||matrix[n][m]==infinite)
		return false;
	else return true;
}

bool Graph::IsEdge(int m,int n){
	if(matrix[m][n]!=0 && matrix[m][n]!=infinite)
		return true;
	else return false;
}

void Graph::DFS(string name){
	
	int n=location(name);

	for (int j = 0; j < number_node; j++)
       list[j].visited=false;
		
	list[n].visited=true;
	//used = new bool[number_node]; 

    DFS(n);
	cout<<"Welcome"<<endl;

	/*for(int i = 0; i < number_node; i++)  
    {  
        if(!used[i]) DFS(i, used);  
    }  
    cout << endl;  
    delete []used;*/ 
}

bool Graph::VisitedDone(){

	for (int i = 0; i < number_node; i++)
	{
		if(list[i].visited!=true)
			return false;
	}

	return true;

}

void Graph::DFS(int v){	
	
	bool done=VisitedDone();   
    cout<< node_name[v] << "-->" ;
	

	if(done){ 
		cout<<"(Visited Done!)-->";  
		return; 
	}
	
	for(int i = 0; i < number_node; i++)  
    {  		   
		   if(IsEdge(v,i) && !list[i].visited){
			  list[i].visited = true;
			  //cout<< node_name[v] << " " ;
			  DFS(i); 			 
             } 		
    }

	if(done){ }
	else cout<< node_name[v] << "-->" ;
}  

void Graph::MiniDistanse(string start,string dest){

	int s=location(start);
	int d=location(dest);
	int k,min;
	bool final[max];//������������ʶ�����Ƿ���ȷ�������·��
	int dist[max]; 
	string path[2*max]; 

	   //��ʼ��
	   for (int i = 0; i < number_node; i++)
	   {
		dist[i]=matrix[s][i];
		if (IsEdge(s,i)) path[i]=list[s].name+"-->"+list[i].name;
		else  path[i]="";
		final[i]=false;//��ʼ����ʶ����Ϊ0

	   }

	    dist[s]=0;  
        final[s]=true; 


		for (int j = 0; j < number_node; j++)
		{
			min=infinite;
			for (int i = 0; i < number_node; i++)
			{
				if(dist[i]<min && final[i]==false){   
                     min=dist[i];  
                     k=i;  
                }//�ҵ�dist��������Сֵ��λ��k 
			}

			if(k==d){
				cout<<"���·��Ϊ��"<<endl;
				cout<<path[k]<<endl;
				cout<<"��̾���Ϊ��"<<dist[k]<<endl;
			}
			final[k]=1;

			for(i=0;i<number_node;i++)  
            {
				if(dist[i]>dist[k]+matrix[k][i] && final[i]==false)  
                {  
                  dist[i]=dist[k]+matrix[k][i];  
				  path[i]=path[k]+"-->"+list[i].name;  
                }  
            } 
		}

}