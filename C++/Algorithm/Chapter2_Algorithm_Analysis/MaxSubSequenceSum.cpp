#include<iostream>
using namespace std;

int MaxSubsequenceSum_1(const int a[],int n){
	int thisSum, maxSum, i, j, k;
	maxSum = 0;
	for(i=0;i<n;i++){
		for(j=i;j<n;j++){
			thisSum = 0;
			for(k=i;k<=j;k++){
				thisSum += a[k];
			}

			if(thisSum > maxSum){
				maxSum = thisSum;
			}
		}
	}
	return maxSum;
}

int MaxSubSequenceSum_2(const int a[],int n){
	int thisSum, maxSum, i, j;
	maxSum = 0;
	for(i = 0;i<n;i++){
		thisSum = 0;
		for(j=i;j<n;j++){
			thisSum += a[j];
			if(thisSum>maxSum){
				maxSum = thisSum;
			}
		}
	}
	return maxSum;
}

static int max3(int a,int b,int c){
	return a>b?(a>c?a:c):(b>c?b:c);
}

static int MaxSubSum(const int a[],int left, int right){

	int maxLeftSum,maxRightSum;
	int maxLeftBorderSum,maxRightBorderSum;
	int leftBorderSum,rightBorderSum;
	int center, i ;
	
	//cout<<left<<':'<<right<<endl;

	if(left==right){
		if(a[left]>0){
			return a[left];
		}else
			return 0;
	}

	center = (left+right)/2;
	maxLeftSum = MaxSubSum(a,left,center);
	maxRightSum = MaxSubSum(a,center+1,right);
	
	//cout<<"maxLeftSum="<<maxLeftSum<<":maxRightSum="<<maxRightSum<<endl;

	maxLeftBorderSum = 0;
	leftBorderSum = 0;
	for(i=center;i>=left;i--){
		leftBorderSum += a[i];
		if(leftBorderSum>maxLeftBorderSum){
			maxLeftBorderSum = leftBorderSum;
		}
	}

	//cout<<"maxLeftBorderSum="<<maxLeftBorderSum<<endl;

	maxRightBorderSum = 0;
	rightBorderSum = 0;
	for(i=center+1;i<=right;i++){
		rightBorderSum += a[i];
		if(rightBorderSum>maxRightBorderSum){
			maxRightBorderSum = rightBorderSum;
		}
	}
	//cout<<"maxRightBorderSum="<<maxRightBorderSum<<endl;

	return max3(maxLeftSum,maxRightSum,
		maxLeftBorderSum+maxRightBorderSum);
}

int MaxSubSequenceSum_3(const int a[],int n){
	return MaxSubSum(a,0,n-1);
}

int MaxSubSequenceSum_4(const int a[], int n){
	int thisSum, maxSum, j;
	thisSum = maxSum = 0;
	for(j=0;j<n;j++){
		thisSum += a[j];
		if(thisSum > maxSum){
			maxSum = thisSum;
		}else if(thisSum<0){
			thisSum = 0;
		}
	}
	return maxSum;
}

int main(){
	int a[] = {4,-3,5,-2,-1,2,6,-2};
	int b[] = {-2,11,-4,13,-5,-2};

	cout<<MaxSubsequenceSum_1(a,8)<<endl;
	cout<<MaxSubsequenceSum_1(b,6)<<endl;
	cout<<MaxSubSequenceSum_2(a,8)<<endl;
	cout<<MaxSubSequenceSum_3(a,8)<<endl;
	cout<<MaxSubSequenceSum_4(a,8)<<endl;
}