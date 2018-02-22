#include<stdio.h>
#include<string.h>
#include<stdlib.h>
typedef struct pb
{
      char pname[5];
   char status[8];
   int time;
      int pri;
      int cputime;
   struct pb *p;
 
}pbc,*pbcp;
 
 
pbcp creatListHead();
void sort(pbcp pbca);
void attemper(pbcp pbca);
void mallocPbc(pbcp pbca,int num);
void printPbc(pbcp pbca);
int main()
{
      int i,j;
      pbcp pbcph;
   pbcph=creatListHead();
      printf("----------初始化进程数据块-------\n\n\n");
      printf("   请输入进程块的数目： ");
      scanf("%d",&i);
      printf("\n");
   mallocPbc(pbcph,i);
   printf("----sort----:\n\n\n");
      sort(pbcph);
    printPbc( pbcph);
       for(j=0;j<11;j++)
       {
        printf("------------------------------------------------------\n");
        attemper(pbcph);
        _sleep(1000);
       }
  return 1;
}
pbcp creatListHead()
{  
      pbcp pbcph;
    if(NULL==(pbcph=(struct pb *)malloc(sizeof(pbc) )))
      {
             printf("pbc head malloc error\n");
   }
   else
      {
             strcpy(pbcph->pname,"head");
             pbcph->p=NULL;
        pbcph->time=0;
       pbcph->pri=0;
             pbcph->cputime=0;
       strcpy(pbcph->status,"head");
   }
      return pbcph;
}
 
 
 
 
void mallocPbc(pbcp pbca,int num)
{
      pbcp pbcptem;
      
   int i;
  for(i=0;i<num;i++)
  {
       if(NULL==(pbcptem=( pbcp )malloc(sizeof(pbc))))
         {
                   printf("pbc malloc error\n");
          }
       printf("--请输入进程名优先级运行时间 \n ");
       scanf("         %s%d%d",pbcptem->pname,&pbcptem->pri,&pbcptem->time);
    pbcptem->p=NULL;
       strcpy(pbcptem->status,"ready");
       
       pbcptem->cputime=0;
       pbca->p=pbcptem;
       pbca=pbca->p;
  }
  
 
}
void printPbc(pbcp pbca)
{ 
   pbcp pbcptem;
      pbcptem=pbca->p;
      while(pbcptem!=NULL)
      {
             printf("\n---进程名优先级运行时间 cpu时间状态 \n");
      
       printf("---%s       %d      %d       %d       %s\n",pbcptem->pname,pbcptem->pri,pbcptem->time, pbcptem->cputime,pbcptem->status);
        pbcptem=pbcptem->p;
      }
}
 
 
void sort(pbcp pbca)
{
 
pbcp p1,p2,p3,p4 ;
 p4=NULL;
 while(p4!=pbca->p->p)
 {
        for(p1=pbca;p1->p->p!=p4;p1=p1->p)
        {
               if((p1->p->pri)<(p1->p->p->pri))
               {
                      p2=p1->p;
                      p3=p1->p->p;
                      p1->p=p3;
                      p2->p=p3->p;
                      p3->p=p2;
               }
        }
        p4=p1->p;
 }
}
 
  
void attemper(pbcp pbca)
{
      pbcp p1,p2;
 
      p1=pbca->p;
      while(p1->time==0)
             p1=p1->p;
      if((p1->time-=1)==0)
       {
           p1->cputime+=1;
              p1->pri-=1;
           strcpy(p1->status,"finish");
           sort( pbca);
      }
 else
 {
      strcpy(p1->status,"run");
   p1->cputime+=1;
      p1->pri-=1;
 
      strcpy(p1->status,"run");
 }
   p2=p1->p;
      
      while(p2!=NULL)
      { 
             if(p2->cputime!=0)
             {
                    (p2->cputime)+=1;
             }
       p2=p2->p;
   }
   printPbc( pbca) ;
 
 
}