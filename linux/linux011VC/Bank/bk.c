#include<stdio.h>
#include<time.h>
#include<malloc.h>
#include<string.h>
#include<stdlib.h>
#include<windows.h>
typedef struct
{
    int arrtime;//�ͻ�����ʱ��
    int duration;//�ͻ�����ҵ��ʱ�����flag��ֵ�������
    int flag;//�ͻ�����ҵ������ͣ�flag=0��һ��ҵ��flag=1������ҵ��
    int no;//�ͻ�����֮��Ҫ��ȡ�ı��
    int waittime;//�ͻ��ĵȴ�ʱ��
}customer,*CUST;
typedef struct qnode
{
    customer data;//����û���Ϣ
    struct qnode* next;
}LQNode;//�����еĽ������
typedef struct
{
    LQNode *front;
    LQNode *rear;
}WaitQueue;//�Ⱥ����Ķ���
typedef struct
{
    int totaltime;
    int customernum;
    LQNode *front;
    LQNode *rear;
    //���ô��ڱȽ�ʱ�䣬�ں���ĳ��Ӳ�������ͨ���㷨���д��ڱȽ�������ͻ����ĸ�����
}dealwindow;//*w[4];
//dealwindow w[4];


void Random(int *duration,int *artime,int *flag,int *ARRTIME);//��������ɿͻ���Ϣ
void EnWaitQueue(WaitQueue *Q,customer e);//ȡ����Ӳ���
void InitWaitQueue(WaitQueue *Q);//�ŶӶ��г�ʼ��


void InitWaitQueue(WaitQueue *Q)//��ʼ���Ⱥ����
{
    Q->front=Q->rear=(LQNode*)malloc(sizeof(LQNode));
    if(Q->front==NULL)
        exit(-1);
    Q->front->next=NULL;
}
void InitWindow(dealwindow *W)//��ʼ�����ڴ���ҵ�����
{
    W->totaltime=0;
    W->customernum=0;
    //W->comparetime=0;
     W->front=W->rear=(LQNode*)malloc(sizeof(LQNode));
      if(W->front==NULL)
        exit(-1);
    W->front->next=NULL;
}
void EnWaitQueue(WaitQueue *Q,customer e)//ȡ����Ӳ���
{
    LQNode *s;
    s=(LQNode*)malloc(sizeof(LQNode));
    if(!s)
    exit(-1);
    s->data=e;
    s->next=NULL;
    Q->rear->next=s;
    Q->rear=s;
}
void EnWindow(dealwindow *Q,customer e)//����ҵ�񴢴������Ӳ���
{
    LQNode *s;
    //��С��ʱ��ʼ��Ϊ0
    s=(LQNode*)malloc(sizeof(LQNode));
    if(!s)
    exit(-1);
    s->data=e;
    s->next=NULL;
    Q->rear->next=s;
    Q->rear=s;
    if(Q->totaltime<e.arrtime)
        {Q->totaltime=e.arrtime;}
    Q->totaltime+=e.duration;//���Ƚϴ��ڰ���ʱ�������
    Q->customernum++;
    e.waittime=Q->totaltime-e.arrtime;

}
int WaitQueueEmpty(WaitQueue *Q)//�����пղ���
{
    if( Q->front->next == NULL )  //���е�ͷ����Q->front->nextָ����еĵ�һ����㣬������ΪNULL�����м�Ϊ��
		return 1;
	else
		return 0;
}
void DeWaitQueue(WaitQueue *Q,customer *e)//���Ӳ���
{
   LQNode *first;
   if( !WaitQueueEmpty( Q ) )//�����зǿգ������Ԫ�ص�ɾ��
   {
       first = Q->front->next;       //��firstָ����еĵ�һ�����
		*e = first->data;    //��һ���������ݸ���eָ��ĵ�Ԫ
		Q->front->next = first->next; //�����е�ͷ���ָ���һ��������һ�����
		free( first );               //�ͷŵ�һ�����
		if( Q->front->next == NULL ) //���ɾ����ͷ�������Ϊ��
			Q->rear = Q->front;//����βָ��ָ��ͷ���
   }
    else
        {					//������Ϊ�գ�����
            printf( "DeleteQueue�������ѿ�!\n" );
        }
}
int DivWaitQueue(WaitQueue *Q,WaitQueue *SP)//SP����Ϊ����ҵ�������ŶӶ��У�
{                                               //������ĵĶ��л���Ϊһ�����������
    LQNode *p,*q,*temp;
    p=Q->front;
    //������г�ʼ��
    do
    {

        if(p->data.flag==1)//����ʼ�����е�SP�����û�ת�Ƶ��µĶ������棬
        {                    //���������û���ԭ���Ķ��������ȥ
          EnWaitQueue(SP,p->data);
          q->next=p->next;
          temp=p;
          q=q->next;
          p=q->next;
          free(temp);//printf("���ⴰ�ڵ���%d \n",SP->rear->data.no);
        }
        q=p;
        p=p->next;
    }
    while(p!=NULL);
    //printf("���е���\n");
    return 0;
}

void  OpenForDay(WaitQueue *Q)//���ݵ�������ɣ��ͻ��ĵ���ʱ������ɲ�����ȴ�������
{
    int Arrtime=0;//�ͻ�����ʱ�䣬���ſͻ����������Ӷ��ۼ�
    int no=1;//�ͻ��Ŷӱ�ţ����ſͻ����������Ӷ��ۼ�
    int starttime;
    int closetime;
    int hour,minute;
    int worktime;//����һ��Ĺ���ʱ��
    //ȡ��֮��Ķ��У��ö���������ҵ���һ��ҵ��һ���Ŷ�
    //WaitQueue *SP;//����ҵ�����
    customer e;
    e.arrtime=0;e.waittime=0;e.duration=0;e.flag=1;e.no=0;//��ʼ��
    printf("����������Ӫҵ�Ŀ�ʼʱ��ͽ���ʱ�䣺�����ʽ��8,15��ʾ��8�㵽15��\n");
    scanf("%d,%d",&starttime,&closetime);
    worktime=(closetime-starttime)*60;//����ʱ��
   //�ŶӶ��г�ʼ��
    printf("������ʱ��ȡ�Ŷ���\n");
    printf("����ҵ�����ͱ��Ϊ0��1 0����һ��ҵ�� 1��������ҵ��\n");
    printf("�ͻ����          ����ʱ��           ����ҵ������          ����ҵ������ʱ��\n");
    srand((unsigned)time( NULL ));
    do
    {
        Random(&e.duration,&e.arrtime,&e.flag, &Arrtime);
        Arrtime=e.arrtime;
        e.no=no;
        no++;
        hour=starttime+e.arrtime/60;
        minute=e.arrtime%60;
        EnWaitQueue(Q,e);
        printf("%3d             %3d h%3d min             %3d                 %3d min\n",
               Q->rear->data.no,hour,minute,Q->rear->data.flag,Q->rear->data.duration);
    }
    while(Arrtime<worktime-5);

}
void Random(int *duration,int *artime,int *flag,int *ARRTIME)//�����������
{
    int temp;//Ϊflag ��ֵ����ʱ����
    Sleep(2000);
    srand((unsigned)time( NULL ));  //��ʱ����Ϊ���Ӷ���������в���
    *artime=*ARRTIME+rand()%5+1;//���������ͻ��ĵ���ʱ����������5����
    temp=rand()%5;
        if(temp==1)//��������ҵ���������������Ϊ���������ķ�֮һ
            {
                *flag=1;//��������ҵ��
                *duration=rand()%15+1;//��������ҵ���ʱ�䲻����15����
            }
        else
            {
                *flag=0;//����һ��ҵ��
                *duration=rand()%5+1;//����һ��ҵ��ʱ�䲻����5����
            }
        Sleep(1000);

}
int MinTimeWindow(dealwindow w[])//�Ƚ��ĸ����ڵ���С��ʱ,�����ش������
{
    int i,k;
    int *temp;//����������ҵ���ʱ����
    k=0;
    *temp=w[k].totaltime;
    for(i=1;i<3;i++)//����ǰ������ͨ���ڵ���С��ʱ
    {

        if(*temp>w[i].totaltime)
        {
           *temp=w[i].totaltime;
           k=i;
        }

    }
    printf("��С���ں�%d\n",k);
    return k;
}

int Sortwindows(dealwindow w[],WaitQueue *Q,WaitQueue *SP)//���ִ��ڽ��ж��г��Ӳ���
{
   int i;
   int minum=0;//��С��ʱ�������
   //int mintime=0;//��С��ʱ���ڵ���ʱ
   customer e;
  // void InitWindow(dealwindow *W);
   //int MinTimeWindow(dealwindow w[]);
   //void DeWaitQueue(WaitQueue *Q,customer *e);//����
   //void EnWindow(dealwindow *Q,customer e);//���봰��
   //int WaitQueueEmpty(WaitQueue *Q);//���ö����пպ���
   for(i=0;i<4;i++)
   {
       InitWindow(&w[i]);
   }
   printf("��С���ں�%d\n",minum);
   while((!WaitQueueEmpty(Q))&&(!WaitQueueEmpty(SP)))
   {   
	   printf("��С���ں�%d\n",minum);
       minum=MinTimeWindow(w);
       if((w[minum].totaltime< w[3].totaltime)||(w[minum].totaltime= w[3].totaltime)&&(Q->front->next->data.arrtime<SP->front->next->data.arrtime))
           {
               DeWaitQueue(Q,&e);   //��ͨҵ����ӣ�����
               EnWindow(&w[minum],e);
			   printf("��С���ں�%d\n",minum);
           }
        if( Q->front->next->data.arrtime>SP->front->next->data.arrtime )
           {
               DeWaitQueue(SP,&e);   //����ҵ����ӣ�����
               EnWindow(&w[3],e);
           }
       if( w[minum].totaltime>w[3].totaltime&&w[3].totaltime<SP->front->next->data.arrtime
          &&Q->front->next->data.arrtime>SP->front->next->data.arrtime )//���ⴰ�ڿ��У���ͨ����æµ
           {
               DeWaitQueue(Q,&e);
               EnWindow(&w[3],e);
           }

   }
   while (!WaitQueueEmpty(Q))//ֻʣ��ͨҵ��
   {
       minum=MinTimeWindow(w);
       if((w[minum].totaltime< w[3].totaltime)||(w[minum].totaltime= w[3].totaltime))
           {
               DeWaitQueue(Q,&e);   //��ͨҵ����ӣ�����
               EnWindow(&w[minum],e);
			   printf("��С���ں�%d\n",minum);
           }
        if(w[minum].totaltime > w[3].totaltime)
        {
               DeWaitQueue(Q,&e);   //��ͨҵ����ӣ�����
               EnWindow(&w[3],e);
           }

   }
   while (!WaitQueueEmpty(SP))//ֻʣ������ҵ��
   {
            DeWaitQueue(SP,&e);   //����ҵ����ӣ�����
            EnWindow(&w[3],e);
   }printf("��С���ں�%d\n",minum);
   return 0;
}
void Search(dealwindow w[])
{
    int a;
    printf("������Ҫ��ѯ�Ĵ���");

}
int main()
{   int i=0;
    WaitQueue Q,*q;
    WaitQueue SP;
    dealwindow w[4];
    q=&Q;
    InitWaitQueue(&Q);
    OpenForDay(&Q);
    InitWaitQueue(&SP);

    DivWaitQueue(&Q,&SP);
    Sortwindows(w,&Q,&SP);
    printf("����x��%d\n",i);
    return 0;

}






