#include <stdio.h>
#define abs(x) (x>0?x:-x)
main()
{
	int i,j;
	for (i=-3;i<=3;i++)
	{

		for (j=0;j<7-2*abs(i);j++ )
		{
			printf("*");
		}
		printf("\n");
	}
}