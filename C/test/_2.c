#include<stdio.h>
#include<stdlib.h>
int main()
{
	FILE *fp;
	char ch,filename[10];
	printf("���������õ��ļ���\n");
	scanf("%s",filename);
	fp=fopen(filename,"w");
	if(fp==NULL)
	{	
		printf("���ļ�ʧ��\n");
		exit(0);
	}
	ch=getchar();
	printf("������һ��׼�����浽���̵��ַ������Կո������:\n");
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