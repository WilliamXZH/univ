#include <iostream>
using namespace std;
#include <stdio.h>
#include <string>
#include "Node.h"
#include "Graph.h"
#include "Slist.h"
#include "Stack.h"
#include "Queue.h"
#include <fstream>
#include <cstdlib>
#include<stdlib.h>
#include<cstdlib>
#define max 100
#define infinite 32767
#include<iostream>
using namespace std;


int  ALGraph::LocateVex(string name){

	ifstream file;   
    char node[512]="data1.txt";  
    file.open(node,ios::in); 
	int m=CountLines(node);
	file.close();

	for (int i = 0; i < m; i++)
	{
		if (ArcNode[i].name == name)
			return i;	

	}
	    return -1;
}

int  ALGraph::CountLines(char *filename)  
{  
    ifstream ReadFile;  
    int n=0;  
    string tmp;  
    ReadFile.open(filename,ios::in);//ios::in ��ʾ��ֻ���ķ�ʽ��ȡ�ļ�  
    if(ReadFile.fail())//�ļ���ʧ��:����0  
    {  
        return 0;  
    }  
    else//�ļ�����  
    {  
        while(getline(ReadFile,tmp,'\n'))  
        {  
            n++;  
        }  
        ReadFile.close();  
        return n;  
    }  
}  

void ALGraph::CreatGraph(){

	ifstream file;   
    char node[512]="data1.txt";  
    file.open(node,ios::in); 
	int number_node=CountLines(node);

	cout<<"  "<<endl;
	cout<<"���ڴ��ļ�"<<node<<"�ж�ȡ���ݣ����Ժ�...."<<endl;
	cout<<"������ľ������ǣ�"<<number_node<<".  ��������Ϣ���£�"<<endl;
	cout<<"----------------------------------------------------------"<<endl;
	cout<<"                      ���������Ϣ "<<endl;
	cout<<"----------------------------------------------------------"<<endl;

    /*ifstream inf("data1.txt"); 
  	cout<<"����������������:";
	for (int i = 0; i < number_node; i++)
	{
	   getline(inf,node_name[i]);
	   cout<<node_name[i]<<'\t';
	}
	
    inf.close(); 
    cout<<endl;
	
   
	FILE *f;
	f=fopen("data.txt","r");
	 
	 if((f=fopen("data.txt","r"))<0)
     {
     printf("open the file is error!\n");
     exit(0);
     }
     //lseek(fd,0,SEEK_SET);
  
	 for (int i = 0; i < number_node; i++)
	 {
		 while(2==fscanf(f,"%c,%lf\n",&list[i].name,&list[i].popularity))
        { 
			cout<<list[i].name<<list[i].popularity<<endl;
	     }
	 }    
     fclose(f);
	
	 char buffer[max]; 
     ifstream in("data.txt");  
     if (! in.is_open())  
     { cout << "Error opening file"; exit (1); }  
     while (!in.eof() )  
     {  
         in.getline (buffer,100);         
     }  
	 in.close();
	 
	 */

	
	string *buffer=new string [number_node];
	int i= 0;
    if(file.fail())  
    {  
        cout<<"�ļ�������."<<endl;  
        file.close();  
    }  
    else//�ļ�����  
    {  		
		while(!file.eof()) //��ȡ���ݵ�����  
        {   			
            file>>buffer[i];                       
            i++;  
        }  		
	}

	file.close(); 
    cout<<endl;

	cout<<"   ��������   ��ӭ��   ��Ϣ��   ����        �������"<<endl;
	cout<<endl;

	int *p=new int [number_node];
	for (int i = 0; i < number_node; i++)
	{
		string s = buffer[i];
		char c[2000];
        strcpy(c,s.c_str());
		char delims[] = ",";
        char *result = NULL;

        result = strtok( c, delims );
		ArcNode[i].name=result;
		cout<<"    "<<ArcNode[i].name<<"       ";

	    result = strtok( NULL, delims);
		ArcNode[i].popularity=atoi(result);
		cout<<ArcNode[i].popularity<<"      ";

		result = strtok( NULL, delims);
		ArcNode[i].reating_area=result;
		cout<<ArcNode[i].reating_area<<"      ";

		result = strtok( NULL, delims);
		ArcNode[i].toillet=result;
		cout<<ArcNode[i].toillet<<"      ";

		result = strtok( NULL, delims);
		ArcNode[i].intruduction=result;
		cout<<ArcNode[i].intruduction<<endl;
	}
	cout<<"----------------------------------------------------------"<<endl;
	cout<<"  "<<endl;

	 /* while( result != NULL ) {
         printf( "result is \"%s\"\n", result );
         result = strtok( NULL, delims );}
	}*/


	
	ifstream filee;   
    char edge[512]="data2.txt";  
    filee.open(edge,ios::in); 
	int number_edge=CountLines(edge);
	cout<<"���ڴ��ļ�"<<edge<<"�ж�ȡ���ݣ����Ժ�......"<<endl;
	cout<<"������ıߵ����ǣ�"<<number_edge<<"!������ɣ���ѡ��2���в鿴"<<endl;
	

	string *bufferr=new string [number_edge];
	int j= 0;
    if(filee.fail())  
    {  
        cout<<"�ļ�������."<<endl;  
        filee.close();  
    }  
    else//�ļ�����  
    {  		
		while(!filee.eof()) //��ȡ���ݵ�����  
        {   			
            filee>>bufferr[j];                       
            j++;  
        }  		
	}

	filee.close(); 
    cout<<endl;

	cout<<"++++++++++++++++++++++++++++++++++++++++++++++"<<endl;
	cout<<"�����޸Ķ�����Ϣ����ֱ���޸��ļ�"<<node<<"����"<<endl;
	cout<<"�����޸ıߵ���Ϣ����ֱ���޸��ļ�"<<edge<<"����"<<endl;
	cout<<"++++++++++++++++++++++++++++++++++++++++++++++"<<endl;
	
	string node_one,node_two;
	int weight,n,m;
	
	for (int j = 0; j < number_node; j++)		 
	  po[j] = &ArcNode[j].next;

	for (int i = 0; i < number_edge; i++)
	{   
		//cout<<"�������"<<i+1<<"���ߵ����������Լ��ñߵ�Ȩֵ��";
	    //cin>>node_one>>node_two>>weight;
		string ss = bufferr[i];
		char cc[100];
        strcpy(cc,ss.c_str());
		char delimss[] = "����";
        char *resultt = NULL;

        resultt = strtok(cc, delimss);
		node_one=resultt;

		resultt = strtok( NULL, delimss);
		node_two=resultt;

	    resultt = strtok( NULL, delimss);
		weight=atoi(resultt);
	
		n=LocateVex(node_one);
		m=LocateVex(node_two);

		if ((n!=-1)&&(m!=-1))
		{
            *po[n]=new AdjList(m,weight);
			po[n]=&((*po[n])->next);
			*po[m]=new AdjList(n,weight);
			po[m]=&((*po[m])->next);
		}

	}

	
	//�ڽӾ����ʼ��ȫ��Ϊinfinite
	for (int k = 0; k < number_node; k++)
	{
		for (int q = 0; q < number_node; q++)
		{
			matrix[k][q]=infinite;
		}
	}

	//Ϊ�ڽӾ���ֵ  AdjList *pol;
	for (int i = 0; i < number_node; i++)
	{
		pol = ArcNode[i].next;
		while (pol)
		{
			n=pol->position;
			m=pol->weight;
			pol=pol->next;
			matrix[i][n]=m;
		}

	}

	//�ڽӾ���Խǵ�ֵΪ0
	for (int i = 0; i < number_node; i++)
	{
		for (int j = 0; j < number_node; j++)
		{
			if (i==j)matrix[i][j]=0;
		}
	}
}

void ALGraph::OutputGraph(){
	cout<<endl;

	ifstream file;   
    char node[512]="data1.txt";  
    file.open(node,ios::in); 
	int m=CountLines(node);
	file.close();
	cout<<"================================================================================================================"<<endl;	
	cout<<"                                              ��������ֲ�����                                              "<<endl;
	cout<<"================================================================================================================"<<endl;
	cout<<"       ";

	for (int i = 0; i < m; i++)
	{
		cout<<"  ";
		cout<<ArcNode[i].name;	
	}
	cout<<endl;
	for (int w = 0; w < m; w++)
	{
		cout<<ArcNode[w].name;
		for (int z = 0; z < m; z++)
		{   
			cout<<"   ";
			if(matrix[w][z]==0)cout<<"0    ";
			else if(matrix[w][z]==infinite)cout<<matrix[w][z];
			else if(matrix[w][z]<10)cout<<matrix[w][z]<<"    ";
			else cout<<matrix[w][z]<<"   ";
		}
		cout<<endl;
	}
	cout<<"================================================================================================================"<<endl;
	
}

bool ALGraph::IsEdge(string node_one,string node_two){

	int n=LocateVex(node_one);
	int m=LocateVex(node_two);
	if(matrix[n][m]==0||matrix[n][m]==infinite)
		return false;
	else return true;
}

bool ALGraph::IsEdge(int m,int n){
	if(matrix[m][n]!=0 && matrix[m][n]!=infinite)
		return true;
	else return false;
}

void ALGraph::CreatTourSortGraph(){

	ifstream file;   
    char node[512]="data1.txt";  
    file.open(node,ios::in); 
	int m=CountLines(node);
	file.close();
	string change;
	Slist slist;
	//Slist *newslist;
	int i=1,p;

	//cout<<"��ȱ�������Ϊ��"<<endl;
	string s = TourSortGraph;
	//cout<<s<<endl;
	//cout<<"=============================="<<endl;

	char c[100];
    strcpy(c,s.c_str());
		
	char delims[] = "-";
    char *result = NULL;
    result = strtok(c, delims);
    while(result != NULL)
    {
		change = result;
		p=LocateVex(change);
		slist.insert(p);
		i++;		
        result = strtok(NULL, delims);
    }

	//��ȱ�������ת���ɵ���ͼ������Slist slist����
	int a=1,b=a+1;
	int d=1,e=d+1;
	int a_value,b_value,d_value,q;
	//int lastt;
	bool issedge = false;
	int last=slist.Last();
	//cout<<last<<endl;
	a_value=slist.getelem(a);
	b_value=slist.getelem(b);
	bool isedge=IsEdge(a_value,b_value);
	bool iseedge=false;
	int u=0;


	while (b_value!=last)
	{
	  isedge=IsEdge(a_value,b_value);
	  if (isedge){ 
		  //cout<<a_value<<"--"<<b_value<<"have"<<endl;  
	  }else{ 
              q=1;iseedge=false;
			  while (!iseedge)
			  {                
				 d_value=slist.getelem(a-q);
			     //cout<<d_value<<endl;
				 //cout<<"q:"<<q<<endl;
		         slist.insert(a+q,d_value);
				 iseedge=IsEdge(d_value,b_value);
				 q++;
			  }
			  //slist.print(); 
			  //cout<<"-----------------------------"<<endl;
			  //insert(int i,int x);//�ڵ�i��λ�ò���Ԫ��x
			  //a_value=slist.getelem(a+1);
              //b_value=slist.getelem(b+1);
		      //issedge=IsEdge(a_value,b_value);
			  //a++;b++;
		      //} 
	  }
	  a++;b++;
	  a_value=slist.getelem(a);
	  b_value=slist.getelem(b);
	  //cout<<a_value<<"====="<<b_value<<endl;
	  isedge=IsEdge(a_value,b_value);
	  //cout<<isedge<<"---------------00000000"<<endl;
	  u++;
	}
	
	int num=slist.getNum();int g=num-1;int y=1;
	a_value=slist.getelem(num-1);
	b_value=slist.getelem(num);
	bool overloop = false;
	isedge=IsEdge(a_value,b_value);
	if (isedge){   }
	else{
		while (!overloop)
		{   
			d_value=slist.getelem(g-y);
			//cout<<"�����ֵ:"<<d_value<<endl;
			slist.insert(num,d_value);
			num=slist.getNum();
			//cout<<"num:"<<num<<endl;
	        a_value=slist.getelem(num-1);
	        b_value=slist.getelem(num);
			//cout<<a_value<<"====="<<b_value<<endl;
	        overloop =IsEdge(a_value,b_value);
			//cout<<overloop<<endl;
			y++;
			//cout<<"------------------------------"<<endl;
		}
	}

	
	/*for (a; a < m; a++,b++)
	{
	  a_value=slist.getelem(a);
	  b_value=slist.getelem(b);
	  bool isedge=IsEdge(a_value,b_value);
	  if (isedge){cout<<a_value<<"<--->"<<b_value<<"have egde"<<endl; }
	  else{    cout<<"Noooo"<<endl;             }
	}*/

	//slist.print(); 
	num=slist.getNum();
	cout<<"�Ƽ�����ͼΪ��"<<endl;
	cout<<"--------------------------------------------------------------------"<<endl;		 
	for (int s = 1; s < num+1; s++)
	{
		int r=slist.getelem(s);
		cout<<ArcNode[r].name<<"-->";
	}
	cout<<"ף��������죡��"<<endl;
	cout<<"--------------------------------------------------------------------"<<endl;		 


	//����Ϊ����ͼ��·�����
	//menu();
	cout<<"�Ƿ����������·ͼ�еĻ�·�������������y;�������������������˵�: ";
	char choice;
	cin>>choice;
	cout<<"--------------------------------------------------------------------"<<endl;	
	if(choice=='y'){
	
	//ArrayStack <int> save(45);
	int bb=0;
	myQueue<int> rode;
	bool haveLoop=slist.haveLoop();
	if (haveLoop){
		cout<<"����ͼ���ڻ�·!������"<<endl;
		cout<<"--------------------------------------------------------------------"<<endl;	
	    for (int i = 1; i < num+1; i++)
	    {
		   int val=slist.getelem(i);
		   int time=slist.have(val);
		   string  nameee=ArcNode[val].name;
		   if (time==1){}//cout<<i<<"."<<val<<"."<<nameee<<":���ִ���Ϊ1"<<endl;}//���ִ���Ϊ1���˾��㲻���ڻ�·
		   else{

            /*�ж��Ƿ��ǵ�һ�γ���
             *��Ϊ�ǻ�·��������յ���ͬ������ɶ�α���
			 *firstEmerge�������������ж��ǲ��ǵ�һ�η��ʸý��
            */
			bool firstEmerge=slist.firstEmerge(i);
			if(firstEmerge){

			  int first_place=slist.getloca(val); 
			  int vall=slist.getelem(i);
			 // save.push(vall);
			  rode.push(vall);
              int tome=1;
			  while (tome<time)
			  {   
				  first_place++;
				  vall=slist.getelem(first_place);
				 // save.push(vall);
				  rode.push(vall);
				  if (val==vall) tome++; 
			  }

			  //��ջ
			  int top;
			  while (!rode.empty())
			  {
				  top=rode.front();
				  cout<<ArcNode[top].name<<"-->";
				  rode.pop();
			  }
			  cout<<"Welcome!"<<endl;  
			  cout<<"--------------------------------------------------------------------"<<endl;	   
			}//if(firstEmerge)����
		   }//else����		      
      }//forѭ������
	
	}else {
		cout<<"����ͼ�����ڻ�·!������"<<endl;
		cout<<"--------------------------------------------------------------------"<<endl;	
	      }	
	}
	
}

void ALGraph::DFS(string name){

	ifstream file;   
    char node[512]="data1.txt";  
    file.open(node,ios::in); 
	int m=CountLines(node);
	file.close();

	int n=LocateVex(name);

	for (int j = 0; j < m; j++)
       ArcNode[j].visited=false;
		
	ArcNode[n].visited=true;
	int num_tour = 0;
	TourSortGraph="";
    DFS(n);
	//cout<<"Welcome"<<endl;

	/*for(int i = 0; i < number_node; i++)  
    {  
        if(!used[i]) DFS(i, used);  
    }  
    cout << endl;  
    delete []used;*/ 
}

bool ALGraph::VisitedDone(){

	ifstream file;   
    char node[512]="data1.txt";  
    file.open(node,ios::in); 
	int m=CountLines(node);
	file.close();

	for (int i = 0; i < m; i++)
	{
		if(ArcNode[i].visited!=true)
			return false;
	}

	return true;

}

void ALGraph::DFS(int v){	

	ifstream file;   
    char node[512]="data1.txt";  
    file.open(node,ios::in); 
	int m=CountLines(node);
	file.close();

	bool done=VisitedDone();   
	//cout<<v<< ArcNode[v].name << "-->" ;

	
	if(done){ 
		TourSortGraph=TourSortGraph+ArcNode[v].name;
	}else
	{
		TourSortGraph=TourSortGraph+ArcNode[v].name+"-";
	}

	if(done){ 
		//cout<<"^^^(���Ѿ�������ȫ������!�Ƽ�����·��)^^^-->";  
		return; 
	}
	
	for(int i = 0; i < m; i++)  
    {  		   
		   if(IsEdge(v,i) && !ArcNode[i].visited){
			  ArcNode[i].visited = true;
			  DFS(i); 			 
             } 		
    }

	//if(done){ }
	//else cout<< ArcNode[v].name << "-->" ;
}  

void ALGraph::MiniDistanse(string start,string dest){

	ifstream file;   
    char node[512]="data1.txt";  
    file.open(node,ios::in); 
	int m=CountLines(node);
	file.close();

	int s=LocateVex(start);
	int d=LocateVex(dest);
	int k,min;
	bool final[max];//������������ʶ�����Ƿ���ȷ�������·��
	int dist[max]; 
	string path[2*max]; 

	   //��ʼ��
	   for (int i = 0; i < m; i++)
	   {
		dist[i]=matrix[s][i];
		if (IsEdge(s,i)) path[i]=ArcNode[s].name+"-->"+ArcNode[i].name;
		else  path[i]="";
		final[i]=false;//��ʼ����ʶ����Ϊ0

	   }

	    dist[s]=0;  
        final[s]=true; 


		for (int j = 0; j < m; j++)
		{
			min=infinite;
			for (int i = 0; i < m; i++)
			{
				if(dist[i]<min && final[i]==false){   
                     min=dist[i];  
                     k=i;  
                }//�ҵ�dist��������Сֵ��λ��k 
			}

			if(k==d){
				cout<<"���·��Ϊ��";
				cout<<path[k]<<endl;
				cout<<"��̾���Ϊ��"<<dist[k]<<endl;
				cout<<"--------------------------------------------------------------------"<<endl;
			}
			final[k]=1;

			for(int i=0;i<m;i++)  
            {
				if(dist[i]>dist[k]+matrix[k][i] && final[i]==false)  
                {  
                  dist[i]=dist[k]+matrix[k][i];  
				  path[i]=path[k]+"-->"+ArcNode[i].name;  
                }  
            } 
		}

}

void ALGraph::Popu_Sorting(){

	ifstream file;   
    char node[512]="data1.txt";  
    file.open(node,ios::in); 
	int m=CountLines(node);
	file.close();

	int array[20];

	for (int i = 0; i < m; i++)
	{   
		array[i]=ArcNode[i].popularity;
		//cout<<list[i].popularity<<endl;
	}

	int k,n=1;
    int len=m; 
     
    quickSort(array,0,len-1); 
	cout<<"----------------------------------------"<<endl;
    cout<<"          1.���վ��㻶ӭ������ "<<endl;
	cout<<"(��ӭ��:�ι۸þ���ռ�ι��������İٷֱ�)"<<endl;
	cout<<"----------------------------------------"<<endl;
	for(k=0;k<len;k++) {
	
		for (int i = 0; i < m; i++)
		{
			if (ArcNode[i].popularity==array[k])			
				cout<<"    "<<n<<". "<<ArcNode[i].name<<":"<<array[k]<<endl;
		}
		n++;
	
	}
	cout<<"----------------------------------------"<<endl;
}

void ALGraph::quickSort(int s[], int l, int r)  
{  
    if (l< r)  
    {        
        int i = l, j = r, x = s[l];  
        while (i < j)  
        {  
            while(i < j && s[j]>= x) // ���������ҵ�һ��С��x����  
                j--;   
            if(i < j)  
                s[i++] = s[j];  
            while(i < j && s[i]< x) // ���������ҵ�һ�����ڵ���x����  
                i++;   
            if(i < j)  
                s[j--] = s[i];  
        }  
        s[i] = x;  
        quickSort(s, l, i - 1); // �ݹ����  
        quickSort(s, i + 1, r);  
    }  
} 

void ALGraph::Find(string object){

	ifstream file;   
    char node[512]="data1.txt";  
    file.open(node,ios::in); 
	int m=CountLines(node);
	file.close();
	string find;

	for (int i = 0; i < m; i++)
	{
		string s =ArcNode[i].intruduction;
		if (ArcNode[i].name==object){
			cout<<"----------------------------------------------------"<<endl;
			find+=ArcNode[i].name;
			cout<<ArcNode[i].name<<":"<<ArcNode[i].reating_area<<"��Ϣ��,"<<ArcNode[i].toillet<<"ϴ�ּ�,��ӭ��Ϊ"<<ArcNode[i].popularity<<","<<ArcNode[i].intruduction<<endl;
		   return;
		   }
		else if (s.find(object) != string::npos)
		{
		   cout<<"----------------------------------------------------"<<endl;
		   find+=ArcNode[i].name;
		   cout<<ArcNode[i].name<<":"<<ArcNode[i].reating_area<<"��Ϣ��,"<<ArcNode[i].toillet<<"ϴ�ּ�,��ӭ��Ϊ"<<ArcNode[i].popularity<<","<<ArcNode[i].intruduction<<endl;
		   
		}
		else{       }
	}

	cout<<"----------------------------------------------------"<<endl;
	if (find=="")
	{
		cout<<"δ�ҵ���ؾ�����Ϣ��������������ؼ��ֲ��ң�"<<endl;
		cout<<"----------------------------------------------------"<<endl;
	
	}
		   
}

void ALGraph::MiniSpanTree(){
	
	ifstream file;   
    char node[512]="data1.txt";  
    file.open(node,ios::in); 
	int num_node=CountLines(node);
	file.close();

	int flag[max],treenode[max],n,mm,l,p=0;
	int matrix_tree[max][max];
	int distance=0;

	for (int i = 0; i < num_node; i++)
	{
		for (int j = 0; j < num_node; j++)
		{
			matrix_tree[i][j]=matrix[i][j];
		}
	}

	for (int i = 0; i < num_node; i++)flag[i]=0;

	l=n=mm=1000;
	for (int i = 0; i < num_node; i++)
	{
		for (int j = i; j < num_node; j++)
		{
			if ((matrix_tree[i][j]!=0)&&(matrix_tree[i][j]<l))
			{
				l=matrix_tree[i][j];
				mm=i;n=j;
			}
		}
	}
	p+=2;treenode[0]=mm;treenode[1]=n;
	flag[n]=flag[mm]=1;
	cout<<ArcNode[n].name<<"<---->"<<ArcNode[mm].name<<"   ����Ϊ��"<<l<<endl;
	distance=distance+l;

	while (p<num_node)
   {
	   l=n=mm=10000;
	   for (int i = 0; i < p; i++)
	   {
		   for (int j = 0; j < num_node; j++)
		   {
			   if ((matrix_tree[j][treenode[i]]!=0)&&(matrix_tree[j][treenode[i]]<l)&&(flag[j]==0))
			   {
                    l=matrix_tree[j][treenode[i]];
					n=treenode[i];mm=j;
			   }
		   }
	   }
	   if ((mm!=10000)&&(n!=10000)&&(l!=10000))
	   {
		   treenode[p]=mm;
		   p++;
		   cout<<ArcNode[n].name<<"<---->"<<ArcNode[mm].name<<"   ����Ϊ��"<<l<<endl;
		   distance=distance+l;
		   flag[mm]=1;

	   }

	}
	
	cout<<"--------------------------------------------------------------------"<<endl;		  
	cout<<"�޽��˵�·���ܾ���Ϊ��"<<distance<<endl;


}