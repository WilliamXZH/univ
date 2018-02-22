#include<stdio.h>
main()
{
	int i=0;
	int j;
	for (i=0;i<100 ;i++ )
	{
		for (j=0;j<i ;j++ )
		{
			printf(" ");
		}
		printf("ÐìÔö»Ô´óÉµ±Æ\n");
		_sleep(1000);
	}
}