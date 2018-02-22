#include<iostream>
#include<cmath>
using namespace std;
#define len(a) (sizeof a/sizeof a[0])
void print(int a[],int n,const char *sortName);

//time complexity:O(n^2)
void straightInsertSort(int a[],int n){
	//cout<<n<<endl;
	for(int i=1;i<n;i++){
		if(a[i]<a[i-1]){
			int j = i-1;
			int x = a[i];
			//a[i] = a[i-1];
			while(j>=0&&x < a[j]){
				a[j+1] = a[j];
				j--;
			}
			a[j+1] = x;
		}
	}
	//cout<<n<<endl;
	print(a,n,"StraightInsertSort");
}

/*
 * or name as reduce increment.
 */
void shellInsertSort(int a[],int n,int factor){
	int dk = n/factor;
	cout<<n<<endl;
	while(dk){
		//cout<<dk<<endl;
		for(int i=dk;i<n;i++){
			if(a[i]<a[i-dk]){
				int j = i-dk;
				int x = a[i];
				while(j>=0&&x<a[j]){
					a[j+dk] = a[j];
					j -= dk;
				}
				a[j+dk] = x;
			}
		}
		dk /= factor;
		//cout<<dk<<endl;
	}
	print(a,n,"ShellInsertSort");
}

void simpleSelectionSort(int a[],int n){
	int min,tmp;
	for(int i=0;i<n-1;i++){
		min = i;
		for(int j=i+1;j<n;j++){
			if(a[j]<a[min]){
				min = j;
			}
		}
		if(min!=i){
			tmp = a[i];
			a[i] = a[min];
			a[min] = tmp;
		}
	}
	print(a,n,"SimpleSelectionSort");
}

void binarySelectSort(int a[],int n){
	int min,max,tmp;
	for(int i=0;i<n/2;i++){
		min = i;
		max = i;
		for(int j=i+1;j<n-i;j++){
			if(a[j]<a[min]){
				min = j;
			}else if(a[j]>a[max]){
				max = j;
			}
		}
		if(min!=i){
			tmp = a[i];
			a[i] = a[min];
			a[min] = tmp;
		}
		if(max!=i){
			tmp = a[n-1-i];
			a[n-1-i] = a[max];
			a[max] = tmp;
		}
	}
	print(a,n,"BinarySelectSort");
}

void heapAdjust(int a[],int s,int n){
	int tmp = a[s];
	int child = 2*s+1;
	while(child<n){
		if(child+1<n&&a[child]<a[child+1]){
			++child;
		}
		if(a[s]<a[child]){
			a[s] = a[child];
			s = child;
			child = 2*s+1;
		}else{
			break;
		}
		a[s] = tmp;
	}
	print(a,9,"HeapAdjust");
}

void heapSort(int a[],int n){
	for(int i=(n-1)/2;i>=0;i--){
		heapAdjust(a,i,n);
	}
	cout<<"build finished!"<<endl;
	for(int j=n-1;j>0;j--){
		int tmp = a[j];
		a[j] = a[0];
		a[0] = tmp;
		heapAdjust(a,0,j);
	}
	print(a,n,"HeapSort");
}

void bubbleSort(int a[],int n){
	for(int i=0;i<n-1;i++){
		for(int j=0;j<n-1;j++){
			if(a[j]>a[j+1]){
				int tmp = a[j];
				a[j] = a[j+1];
				a[j+1] = tmp;
			}
		}
	}
}
void bubble_1(int a[], int n){
	
	int i = n-1;
	while(i>0){
		int pos = 0;
		for(int j=0;j<i;j++){
			if(a[j]>a[j+1]){
				pos = j;
				int tmp = a[j];
				a[j] = a[j+1];
				a[j+1] = tmp;
			}
		}
		i = pos;
	}
	print(a,n,"BubbleSort---optimize");
}

void bubble_2(int a[],int n){
	int low = 0;
	int high = n-1;
	int tmp,j;
	while(low < high){
		for(j=low;j<high;j++){
			if(a[j]>a[j+1]){
				tmp = a[j];
				a[j] = a[j+1];
				a[j+1] = tmp;
			}
		}
		high--;
		for(j=high;j>low;--j){
			if(a[j]<a[j-1]){
				tmp = a[j];
				a[j] = a[j-1];
				a[j-1] = tmp;
			}
		}
		low++;
	}
	
	print(a,n,"BubbleSort---optimize");
}

void swap(int &a, int &b){
	if(a!=b){
		a = a^b;
		b = a^b;
		a = a^b;
	}
}

void quickSort(int a[],int low,int high){
	if(low < high){
		int p = low;
		int q = high;
		int pk = a[low];//privotKey
		while(p<q){
			while(p<q&&a[q]>=pk)q--;
			swap(a[p],a[q]);
			
			while(p<q&&a[p]<=pk)p++;
			swap(a[p],a[q]);
			//print(a,9,"tmpSort");
		}
		//swap(a[low],a[p]);
		print(a,9,"quickSort");
		
		quickSort(a,low,p-1);
		quickSort(a,p+1,high);
	}
}

/*
 * qsort_improve
 * 首先进行快速排序,high>low+k (k为精度)
 * 再使用插入排序
 */


/*
 * Radix Sort:基数排序/桶排序
 * MSD: Most Significant Digit first
 * LSD: Least Significant Digit first
 */
void radixSort(int a[],int l,int radix){
	int m,n,k,lsp;
	k = 1;
	m = 1;
	int tmp[10][8];//l-1
	//clear array
	while(k<radix){
		for(int i=0;i<l;i++){
			if(a[i]<m){
				tmp[0][n] = a[i];
			}else{
				lsp = (a[i]/m)%10;
			}
			tmp[lsp][n] = a[i];
			n++;
		}
		//collectElement(a,tmp);
		n = 0;
		m *= 10;
		k++;
	}
}

int main(){
	int a[] = {3,6,9,8,5,2,1,4,7};
	print(a,len(a),"OriginalSequence");
	//straightInsertSort(a,len(a));
	//shellInsertSort(a,len(a),2);
	//simpleSelectionSort(a,len(a));
	//binarySelectSort(a,len(a));
	//heapSort(a,len(a));
	//bubble_1(a,len(a));
	quickSort(a,0,len(a)-1);
}



void print(int a[],int n,const char *sortName){
	cout<<sortName<<":";
	for(int i=0;i<n;i++){
		cout<<a[i]<<" ";
	}
	cout<<endl;
}