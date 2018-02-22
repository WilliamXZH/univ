#include<iostream>
using namespace std;

private static void rec_quickSort(int[] a, int start, int end) {
        int index = 0;
        if(start < end) {
            index = partition(a,start,end);
            rec_quickSort(a,start,index-1);
            rec_quickSort(a,index+1,end);
        }
    }

private static int partition(int[] a, int start, int end) {
	int pivot = a[start];
	while(start < end) {
		while(start < end && a[end] >= pivot)
			end--;
		a[start] = a[end];
		while(start < end && a[start] <= pivot)
			start++;
		a[end] = a[start];
	}
	a[start] = pivot;
	return start;
}