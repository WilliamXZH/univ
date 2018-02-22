//selection problem

#include<stdio.h>

int kthNumber(int nums[], int n, int k)
{
	int i, j, tmp;
	for(i=0; i<n-1; i++)
	{
		for(j=i; j<n; j++)
		{
			if(nums[i]<nums[j])
			{
				tmp = nums[i];
				nums[i] = nums[j];
				nums[j] = tmp;
			}
		}
	}
	return nums[k-1];
}

void main()
{
	int liv_x;
	int array[10]={1,2,3,4,5,6,7,8,9,10};
	for(liv_x = 0; liv_x < 10; liv_x++)
	{
		printf("%d ",array[liv_x]);
	}
	printf("\n");

	printf("The k-th number in the array is %d.\n",kthNumber(array, 10, 7));
}

