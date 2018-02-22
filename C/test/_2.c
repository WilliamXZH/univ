#include<stdio.h>
#include<stdlib.h>
int main()
{
	FILE *fp;
	char ch,filename[10];
	printf("请输入所用的文件名\n");
	scanf("%s",filename);
	fp=fopen(filename,"w");
	if(fp==NULL)
	{	
		printf("打开文件失败\n");
		exit(0);
	}
	ch=getchar();
	printf("请输入一个准备储存到磁盘的字符串（以空格结束）:\n");
	ch=getchar();
	while(ch!=' ')
	{
		fputc(ch,fp);
		putchar(ch);
		ch=getchar();
	}
	fclose(fp);
	putchar('\n');
}