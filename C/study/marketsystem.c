#include<string.h>
#include<stdio.h>
	struct store
	{
		char name[10];
		float money;
		int number;
		int code;
	};
main()
{
    int type1,i,type2,code1,number1,fuction;
	float money1,money2;
	char vip;
	printf("��1��������2���ۣ���3�鿴");
	printf("�����빦��");
	scanf("%d",&fuction);
	if(fuction==1)
	{
		struct store thing;
		printf("���������������");
		scanf("%d",&type1);
		for(i=0;i<type1;i++)
		printf("����   �۸�   ����   ����");
		{
			scanf("%s  %f  %d  %d",
			thing.name,
			&thing.money,
			&thing.number,
			&thing.code);
			printf("��9����");
			scanf("%d",&fuction);
		}
	}
	return 0;
}