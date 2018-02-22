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
	printf("按1进货，按2销售，按3查看");
	printf("请输入功能");
	scanf("%d",&fuction);
	if(fuction==1)
	{
		struct store thing;
		printf("情输入进货的种类");
		scanf("%d",&type1);
		for(i=0;i<type1;i++)
		printf("名称   价格   数量   代码");
		{
			scanf("%s  %f  %d  %d",
			thing.name,
			&thing.money,
			&thing.number,
			&thing.code);
			printf("按9返回");
			scanf("%d",&fuction);
		}
	}
	return 0;
}