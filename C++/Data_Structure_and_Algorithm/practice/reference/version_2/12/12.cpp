// 12.cpp : Defines the entry point for the console application.
//
#include"stdafx.h"
#include<string>
#include <iostream>
using namespace std;
#include<conio.h>//getch
#include<cstdlib>//��������ͷ�ļ�

#define M 100
#define INF 999666333

/**��������**/
void Welcome();//��ӭ����
void returnMainFace();//���������溯��
void MainFace();//������
void create_graph();//������������ͼ
void print_graph();//�����������ͼ
void guide_line();//������·
void DFS(int c);//�����������������·
void checked();//����Ƿ����һ���Ϸ��ľ�������ֲ�ͼ
void Num_Name();//��ӡ�������뾰�����ƵĶ�Ӧ��Ϣ
void Floyd(int A[M][M],int path[M][M]);//Floyd�㷨
void Y_N();//ѡ���жϺ���
void check_circuit();//�жϻ�·

/**�������ݽṹ**/
struct Matrix
{
    int m[M][M];//�����ڽӾ���
    string Pname[M];//�������������
};

typedef struct
{
    string Sname;//��������
    int count;//����������
    int edge;//��·����
    Matrix mat;//�ڽӾ���
}Scenic;

/**������������Ϊȫ�ֱ���**/
Scenic S;
/***************************/

//����һ�������ڽӾ���
void create_graph()
{
    if(S.count>0)
    {
        cout<<"\n*��ǰ�Ѵ���һ����������ֲ�ͼ��\n*�������������Ǹþ�������ֲ�ͼ����Y/N��";
        Y_N();
    }
    cout<<"\n*�����뾰�������ƣ�";
    cin>>S.Sname;
    cout<<"\n*������þ����ľ�������Ŀ��";
    cin>>S.count;
    cout<<"\n*�����뾰���ĵ�·����Ŀ��";
    cin>>S.edge;
    int i,j;
    for(i=0;i<S.count;i++)
    {
        for(j=0;j<S.count;j++)
        {
            S.mat.m[i][j]=0;
        }
    }
    cout<<"\n*�������·�������ӵ����������š����Ƽ���·�ĳ���\n";
    cout<<"\t����ʽ�����������밴��С����ǰ����ں��ԭ�򣬾����Ŵ�1��ʼ��";
    for(i=0;i<S.edge;i++)
    {
        cout<<"\n*�� "<<i+1<<" ����·\n";
        int n1,n2;
        //��������1��ʼ�������±���㿪ʼ
        cout<<"\t-���� 1 ��ţ�";
        cin>>n1;
        n1--;
        cout<<"\t-���� 1 ���ƣ�";
        cin>>S.mat.Pname[n1];

        cout<<"\t-���� 2 ��ţ�";
        cin>>n2;
        n2--;
        cout<<"\t-���� 2 ���ƣ�";
        cin>>S.mat.Pname[n2];

        cout<<"\t-������֮��ĵ�·���ȣ�";
        cin>>S.mat.m[n1][n2];
        S.mat.m[n2][n1]=S.mat.m[n1][n2];
    }
    cout<<"\n*���������ɹ���";
    returnMainFace();
}

void print_graph()//���ڽӾ������ʽ�������ֲ�
{
    checked();
    cout<<"\n*��������ֲ�ͼ���ڽӾ����ʾ����ѯ�ɹ���\n";
    cout<<"*�������ƣ�"<<S.Sname<<endl;
    int i,j;
    cout<<"\n\t -----";
    for(i=0;i<S.count;i++)
    {
        cout<<"---";
    }
    cout<<endl;
    cout<<"\t|���|";
    //cout<<"    |"
    for(i=0;i<S.count;i++)
    {
        cout<<' '<<i+1<<' ';
    }
    cout<<'|'<<endl<<"\t|-----";
    for(i=0;i<S.count;i++)
    {
        cout<<"---";
    }
    cout<<'|'<<endl;
    for(i=0;i<S.count;i++)
    {
        for(j=0;j<S.count;j++)
        {
            if(j==0)
            {
                cout<<"\t|  "<<i+1<<" | "<<S.mat.m[i][j]<<' ';
            }
            else
            {
                cout<<' '<<S.mat.m[i][j]<<' ';
            }
        }
        cout<<'|'<<endl;
    }
    cout<<"\t -----";
    for(i=0;i<S.count;i++)
    {
        cout<<"---";
    }
    Num_Name();
    cout<<"ע��\n\t'0'��ʾ���������û��ֱ�ӵ����·�����򾰵㵽����·������Ҫ��\n";
    returnMainFace();
}

/********/
//�����������������·
int visited[M]={0};
int np=0;//�ҵ��ľ������
int p[M];//��ʾ������������ֵ
void DFS(int c)
{
    np++;
    p[c]++;
    if(np==S.count)
    {
        cout<<S.mat.Pname[c]<<endl;
        returnMainFace();
    }
    else
        cout<<S.mat.Pname[c]<<" --> ";
    visited[c]=1;
    for(int i=0;i<S.count;i++)
    {
        if(S.mat.m[c][i]>0&&visited[i]==0)
        {
            DFS(i);
            if(S.count>np)
            {
                cout<<S.mat.Pname[c]<<"-->";
                p[c]++;
            }
        }
    }
    if(np==S.count)returnMainFace();
}

void guide_line()//������·
{
    checked();
    cout<<"\n*��������ʼ����ľ����ţ�";
    int c;
    cin>>c;
    c--;
    for(int i=0;i<S.count;i++)
    {
        visited[i]=0;
        p[i]=0;//����ó�ֵΪ0
    }
    np=0;
    cout<<"*�γɵĵ�����·ͼ������������Ȳ��ԣ�������ʾ��\n\n\t";
    DFS(c);
}
/********/

void check_circuit()//�жϻ�·
{
    checked();
    if(np==0)
    {
        cout<<"\n*ȱ�ٺϷ��ĵ�����·ͼ��\n*��������һ���Ϸ��ĵ�����·ͼ��\n";
        returnMainFace();
    }
    bool f=true;
    for(int i=0;i<S.count;i++)
    {
        if(p[i]>1)
        {
            if(f)
            {
                cout<<"\n*�õ�����·ͼ���ڻ�·\n��·�е��ظ��߹��ľ�����ʾ���£�\n\t";
                f=false;
            }
            cout<<"��ţ�"<<i+1<<" ��"<<"�������ƣ�"<<S.mat.Pname[i]<<endl;
        }
    }
    if(f)
    {
        cout<<"\n\t*δ�ҵ������ڸõ�����·ͼ�еĻ�·��\n";
    }
    returnMainFace();
}

void Floyd(int A[M][M],int path[M][M])
{
    int i,j,k;
    for(i=0;i<S.count;i++)
    {
        for(j=0;j<S.count;j++)
        {
            if(S.mat.m[i][j]==0&&i!=j)
                A[i][j]=INF;
            else if(i==j)
                A[i][j]=0;
            else
                A[i][j]=S.mat.m[i][j];
            if(i!=j&&S.mat.m[i][j]<INF)
                path[i][j]=i;
            else
                path[i][j]=-1;
        }
    }
    /*
    for(i=0;i<S.count;i++)
    {
        for(j=0;j<S.count;j++)
        {
            cout<<path[i][j]<<' ';
        }
        cout<<endl;
    }
    */
    for(k=0;k<S.count;k++)
    {
        for(i=0;i<S.count;i++)
        {
            for(j=0;j<S.count;j++)
            {
                if(A[i][j]>A[i][k]+A[k][j])
                {
                    A[i][j]=A[i][k]+A[k][j];
                    path[i][j]=path[k][j];
                }
            }
        }
    }
    /*
    for(i=0;i<S.count;i++)
    {
        for(j=0;j<S.count;j++)
        {
            cout<<path[i][j]<<' ';
        }
        cout<<endl;
    }
    */
}
/********/

void min_distance()//���·��������
{
    checked();
    //int A[M][M],path[M][M];
    int path[M][M];
    int A[M][M];
    Floyd(A,path);
    //Dispath
    while(true)
    {
        system("cls");
        Num_Name();
        int i,j,k,s;
        int apath[M],d;
        cout<<"*������Ҫ��ѯ�����·������̾������������ı�ţ�\n";
        cout<<"\t-���� 1��";
        cin>>i;
        i--;
        cout<<"\t-���� 2��";
        cin>>j;
        j--;
        if(A[i][j]<INF&&i!=j)
        {
            cout<<"\n*�� "<<S.mat.Pname[i]<<" �� "<<S.mat.Pname[j]<<" �����·��Ϊ��";
            k=path[i][j];
            d=0;apath[d]=j;
            while(k!=-1&&k!=i)
            {
                d++;apath[d]=k;
                k=path[i][k];
            }
            d++;apath[d]=i;
            cout<<S.mat.Pname[apath[d]];
            //cout<<apath[d];
            for(s=d-1;s>=0;s--)
            {
                cout<<" --> "<<S.mat.Pname[apath[s]];
                //cout<<','<<apath[s];
            }
            cout<<" ����̾���Ϊ��"<<A[i][j]<<endl;
        }
        else if(i==j)
        {
            cout<<"\n*���������벻�Ϸ���\n";
        }
        else
        {
            cout<<"\n*����������䲻����·��\n";
        }
        cout<<"\n�Ƿ����ִ�����·������̾���Ĳ�ѯ��Y/N��";
        Y_N();
    }
    returnMainFace();
}

void build_road()//��·�޽��滮ͼ����С��������prime�㷨��
{
    //Prim
    checked();
    cout<<"\n*��·�޽��滮ͼ��prime�㷨���滮���£�\n";
    int lowcost[M],min,closest[M],i,j,k,v=0,sum=0,num=0;
    int A[M][M];
    for(i=0;i<S.count;i++)
    {
        for(j=0;j<S.count;j++)
        {
            if(S.mat.m[i][j]==0&&i!=j)
                A[i][j]=INF;
            else if(i==j)
                A[i][j]=0;
            else
                A[i][j]=S.mat.m[i][j];
        }
    }
    for(i=0;i<S.count;i++)
    {
        lowcost[i]=A[v][i];
        closest[i]=v;
    }
    for(i=1;i<S.count;i++)
    {
        min=INF;
        for(j=0;j<S.count;j++)
        {
            if(lowcost[j]!=0&&lowcost[j]<min)
            {
                min=lowcost[j];
                k=j;
            }
        }
        if(min<INF)
        {
            cout<<"\t-�� "<<++num<<" ��·���� "<<S.mat.Pname[closest[k]]<<" �� "<<S.mat.Pname[k]<<" ��������·����Ϊ��"<<min<<endl;
            sum+=min;
        }
        lowcost[k]=0;
        for(j=0;j<S.count;j++)
        {
            if(A[k][j]!=0&&A[k][j]<lowcost[j])
            {
                lowcost[j]=A[k][j];
                closest[j]=k;
            }
        }
    }
    cout<<"*�޽���·���ܳ���Ϊ��"<<sum<<endl;
    returnMainFace();
}

void MainFace()//������
{
    system("cls");
    cout<<"\n���˵���\n";
    cout<<"\t1��������������ֲ�ͼ��\n";
    cout<<"\t2�������������ֲ�ͼ���ڽӾ��󣩣�\n";
    cout<<"\t3�����������·ͼ��\n";
    cout<<"\t4���жϵ�����·ͼ���޻�·��\n";
    cout<<"\t5�����������������·������̾��룻\n";
    cout<<"\t6�������·�޽��滮ͼ��\n";
    cout<<"\t0���˳���\n";
    cout<<"\n*���������ѡ��";
    char c;
    c=getch();
    cout<<c<<endl;
    while(!(c>='0'&&c<='6'))
    {
        cout<<"*�����������������룺";
        c=getch();
        cout<<c<<endl;
    }
    switch(c)
    {
    case '1':
        create_graph();break;
    case '2':
        print_graph();break;
    case '3':
        guide_line();break;//������·
    case '4':
        check_circuit();break;//�жϻ�·
    case '5':
        min_distance();break;//��̾���
    case '6':
        build_road();break;//��С������
    case '0':
        cout<<"\n\t\t\t*��������رձ�ϵͳ*\n";
        exit(0);
    }
}

void returnMainFace()
{
    cout<<"\n\t\t\t��������������˵�... ...";
    getch();
    system("cls");
    MainFace();
}

void Welcome()
{
    cout<<"\n\n\t\t******��ӭʹ�þ���������Ϣ����ϵͳ******\n\n";
    cout<<" \t \t \t �����������ϵͳ... ...";
    getch();
    MainFace();
}

void checked()
{
    system("cls");
    if(S.count<=1)
    {
        cout<<"\n*ȱ�ٺϷ��ľ�������ֲ�ͼ��\n*���ȴ���һ���Ϸ��ľ�������ֲ�ͼ��\n";
        returnMainFace();
    }
}

void Num_Name()
{
    cout<<"\n*��Ŷ�Ӧ�������ƣ�\n";
    for(int i=0;i<S.count;i++)
    {
        cout<<"\t"<<i+1<<"��"<<S.mat.Pname[i]<<endl;
    }
}

void Y_N()
{
    char ch;
    while(ch=getch())
    {
        if(ch=='Y'||ch=='y')
        {
            cout<<ch<<endl;
            break;
        }
        if(ch=='N'||ch=='n')
        {
            cout<<ch<<endl;
            returnMainFace();
        }
    }
}

int main()
{
    Welcome();
    return 0;
}

