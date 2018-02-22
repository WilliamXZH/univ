#include<stdio.h>
#include<time.h>
#include<malloc.h>
#include<string.h>
#include<stdlib.h>
#include<windows.h>
typedef struct
{
    int arrtime;//客户到达时间
    int duration;//客户办理业务时间根据flag的值随机生成
    int flag;//客户办理业务的类型，flag=0是一般业务，flag=1是特殊业务
    int no;//客户进来之后要领取的编号
    int waittime;//客户的等待时间
}customer,*CUST;
typedef struct qnode
{
    customer data;//存放用户信息
    struct qnode* next;
}LQNode;//队列中的结点类型
typedef struct
{
    LQNode *front;
    LQNode *rear;
}WaitQueue;//等候区的队列
typedef struct
{
    int totaltime;
    int customernum;
    LQNode *front;
    LQNode *rear;
    //设置窗口比较时间，在后面的出队操作里面通过算法进行窗口比较来分配客户到哪个窗口
}dealwindow;//*w[4];
//dealwindow w[4];


void Random(int *duration,int *artime,int *flag,int *ARRTIME);//随机数生成客户信息
void EnWaitQueue(WaitQueue *Q,customer e);//取号入队操作
void InitWaitQueue(WaitQueue *Q);//排队队列初始化


void InitWaitQueue(WaitQueue *Q)//初始化等候队列
{
    Q->front=Q->rear=(LQNode*)malloc(sizeof(LQNode));
    if(Q->front==NULL)
        exit(-1);
    Q->front->next=NULL;
}
void InitWindow(dealwindow *W)//初始化窗口储存业务队列
{
    W->totaltime=0;
    W->customernum=0;
    //W->comparetime=0;
     W->front=W->rear=(LQNode*)malloc(sizeof(LQNode));
      if(W->front==NULL)
        exit(-1);
    W->front->next=NULL;
}
void EnWaitQueue(WaitQueue *Q,customer e)//取号入队操作
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
void EnWindow(dealwindow *Q,customer e)//窗口业务储存队列入队操作
{
    LQNode *s;
    //最小用时初始化为0
    s=(LQNode*)malloc(sizeof(LQNode));
    if(!s)
    exit(-1);
    s->data=e;
    s->next=NULL;
    Q->rear->next=s;
    Q->rear=s;
    if(Q->totaltime<e.arrtime)
        {Q->totaltime=e.arrtime;}
    Q->totaltime+=e.duration;//做比较窗口办理时间的作用
    Q->customernum++;
    e.waittime=Q->totaltime-e.arrtime;

}
int WaitQueueEmpty(WaitQueue *Q)//队列判空操作
{
    if( Q->front->next == NULL )  //队列的头结点的Q->front->next指向队列的第一个结点，若该项为NULL；队列即为空
		return 1;
	else
		return 0;
}
void DeWaitQueue(WaitQueue *Q,customer *e)//出队操作
{
   LQNode *first;
   if( !WaitQueueEmpty( Q ) )//若队列非空，则进行元素的删除
   {
       first = Q->front->next;       //将first指向队列的第一个结点
		*e = first->data;    //第一个结点的数据赋给e指向的单元
		Q->front->next = first->next; //将队列的头结点指向第一个结点的下一个结点
		free( first );               //释放第一个结点
		if( Q->front->next == NULL ) //如果删除队头结点后队列为空
			Q->rear = Q->front;//将队尾指针指向头结点
   }
    else
        {					//若队列为空，报错
            printf( "DeleteQueue：队列已空!\n" );
        }
}
int DivWaitQueue(WaitQueue *Q,WaitQueue *SP)//SP定义为特殊业务办理的排队队列，
{                                               //将最初的的队列划分为一般和特殊两类
    LQNode *p,*q,*temp;
    p=Q->front;
    //特殊队列初始化
    do
    {

        if(p->data.flag==1)//将初始队列中的SP特殊用户转移到新的队列里面，
        {                    //并将特殊用户在原来的队列里面除去
          EnWaitQueue(SP,p->data);
          q->next=p->next;
          temp=p;
          q=q->next;
          p=q->next;
          free(temp);//printf("特殊窗口的人%d \n",SP->rear->data.no);
        }
        q=p;
        p=p->next;
    }
    while(p!=NULL);
    //printf("运行到此\n");
    return 0;
}

void  OpenForDay(WaitQueue *Q)//数据的随机生成，客户的到达时间的生成并插入等待队列中
{
    int Arrtime=0;//客户到达时间，随着客户数量的增加而累加
    int no=1;//客户排队编号，随着客户数量的增加而累加
    int starttime;
    int closetime;
    int hour,minute;
    int worktime;//银行一天的工作时间
    //取号之后的队列，该队列中特殊业务和一般业务一起排队
    //WaitQueue *SP;//特殊业务队列
    customer e;
    e.arrtime=0;e.waittime=0;e.duration=0;e.flag=1;e.no=0;//初始化
    printf("请输入银行营业的开始时间和结束时间：输入格式如8,15表示从8点到15点\n");
    scanf("%d,%d",&starttime,&closetime);
    worktime=(closetime-starttime)*60;//工作时间
   //排队队列初始化
    printf("按到达时间取号队列\n");
    printf("办理业务类型编号为0和1 0代表一般业务 1代表特殊业务\n");
    printf("客户编号          到达时间           办理业务类型          办理业务所用时间\n");
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
void Random(int *duration,int *artime,int *flag,int *ARRTIME)//随机数生成器
{
    int temp;//为flag 赋值的临时变量
    Sleep(2000);
    srand((unsigned)time( NULL ));  //用时间作为种子对随机数进行操作
    *artime=*ARRTIME+rand()%5+1;//假设两个客户的到达时间间隔不超过5分钟
    temp=rand()%5;
        if(temp==1)//办理特殊业务的人数比例设置为总人数的四分之一
            {
                *flag=1;//办理特殊业务
                *duration=rand()%15+1;//办理特殊业务的时间不超过15分钟
            }
        else
            {
                *flag=0;//办理一般业务
                *duration=rand()%5+1;//办理一般业务时间不超过5分钟
            }
        Sleep(1000);

}
int MinTimeWindow(dealwindow w[])//比较四个窗口的最小用时,并返回窗口序号
{
    int i,k;
    int *temp;//用于排序查找的临时变量
    k=0;
    *temp=w[k].totaltime;
    for(i=1;i<3;i++)//计算前三个普通窗口的最小用时
    {

        if(*temp>w[i].totaltime)
        {
           *temp=w[i].totaltime;
           k=i;
        }

    }
    printf("最小窗口号%d\n",k);
    return k;
}

int Sortwindows(dealwindow w[],WaitQueue *Q,WaitQueue *SP)//区分窗口进行队列出队操作
{
   int i;
   int minum=0;//最小用时窗口序号
   //int mintime=0;//最小用时窗口的用时
   customer e;
  // void InitWindow(dealwindow *W);
   //int MinTimeWindow(dealwindow w[]);
   //void DeWaitQueue(WaitQueue *Q,customer *e);//出队
   //void EnWindow(dealwindow *Q,customer e);//进入窗口
   //int WaitQueueEmpty(WaitQueue *Q);//引用队列判空函数
   for(i=0;i<4;i++)
   {
       InitWindow(&w[i]);
   }
   printf("最小窗口号%d\n",minum);
   while((!WaitQueueEmpty(Q))&&(!WaitQueueEmpty(SP)))
   {   
	   printf("最小窗口号%d\n",minum);
       minum=MinTimeWindow(w);
       if((w[minum].totaltime< w[3].totaltime)||(w[minum].totaltime= w[3].totaltime)&&(Q->front->next->data.arrtime<SP->front->next->data.arrtime))
           {
               DeWaitQueue(Q,&e);   //普通业务出队，进窗
               EnWindow(&w[minum],e);
			   printf("最小窗口号%d\n",minum);
           }
        if( Q->front->next->data.arrtime>SP->front->next->data.arrtime )
           {
               DeWaitQueue(SP,&e);   //特殊业务出队，进窗
               EnWindow(&w[3],e);
           }
       if( w[minum].totaltime>w[3].totaltime&&w[3].totaltime<SP->front->next->data.arrtime
          &&Q->front->next->data.arrtime>SP->front->next->data.arrtime )//特殊窗口空闲，普通窗口忙碌
           {
               DeWaitQueue(Q,&e);
               EnWindow(&w[3],e);
           }

   }
   while (!WaitQueueEmpty(Q))//只剩普通业务
   {
       minum=MinTimeWindow(w);
       if((w[minum].totaltime< w[3].totaltime)||(w[minum].totaltime= w[3].totaltime))
           {
               DeWaitQueue(Q,&e);   //普通业务出队，进窗
               EnWindow(&w[minum],e);
			   printf("最小窗口号%d\n",minum);
           }
        if(w[minum].totaltime > w[3].totaltime)
        {
               DeWaitQueue(Q,&e);   //普通业务出队，进窗
               EnWindow(&w[3],e);
           }

   }
   while (!WaitQueueEmpty(SP))//只剩下特殊业务
   {
            DeWaitQueue(SP,&e);   //特殊业务出队，进窗
            EnWindow(&w[3],e);
   }printf("最小窗口号%d\n",minum);
   return 0;
}
void Search(dealwindow w[])
{
    int a;
    printf("请输入要查询的窗口");

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
    printf("运行x次%d\n",i);
    return 0;

}






