#include <stdio.h>
#define abs(x) x>0?x:-x
main()
{
	int i,j;
	for (i=0;i<=6;i++)
	{

		for (j=0;j<2*i+1;j++ )
		{
			printf("*");
		}
		printf("\n");
	}
}