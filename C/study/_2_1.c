#include<stdio.h>
void print(struct record[3]);
struct record
{
	int num;
	char name[10];
	int score;
}student[3];
int main()
{
	int i;
	for(i=0;i<3;i++)
	{
		printf("请输入第%d个学生的学号，名字和成绩\n",i+1);
		scanf("%d%s%d",&student[i].num,&student[i].name,&student[i].score);
	}
	print(student);
	getchar;
}
void print(struct record a[])
{
	int i;
	printf("学号	名字	成绩\n");
	for( i=0;i<3;i++)
	{
		printf("%d\t%s\t%d\n",a[i].num,(&a[i])->name,a[i].score);
	}
}