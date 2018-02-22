#include<stdio.h>

#define ElementType int
#define NotFound -1
#define n 5

int BinarySearch(const ElementType A[], ElementType X, int N)
{
	int Low, Mid, High;
	Low = 0;High = N-1;
	while (Low <= High)
	{
		Mid = (Low + High)/2;
		if (A[Mid] < X)
		{
			Low = Mid +1;
		}else if (A[Mid] > X)
		{
			High = Mid -1;
		}else
		{
			return Mid;/* Found */
		}
	}
	return NotFound;/* NotFound is defined as -1 */
}

void main()
{
	int i;
	int nums[n]={9,7,6,4,1};
	int loc = BinarySearch(nums, 4, n);

	for(i=0;i<n;i++)printf("%d ",nums[i]);
	printf("\n");
	printf("%d\n", loc);
}
