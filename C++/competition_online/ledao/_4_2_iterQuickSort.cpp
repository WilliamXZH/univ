#include<iostream>
using namespace std;

private static void nonRec_quickSort(int[] a,int start,int end) {
        LinkedList<Integer> stack = new LinkedList<Integer>();  //ÓÃÕ»Ä£Äâ
        if(start < end) {
            stack.push(end);
            stack.push(start);
            while(!stack.isEmpty()) {
                int l = stack.pop();
                int r = stack.pop();
                int index = partition(a, l, r);
                if(l < index - 1) {
                    stack.push(index-1);
                    stack.push(l);
                }
                if(r > index + 1) {
                    stack.push(r);
                    stack.push(index+1);
                }
            }
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

int main()
{
}