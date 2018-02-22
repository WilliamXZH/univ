#include<iostream>
#include<vector>
using namespace std;
template <class comparable>
void insertionSort(vector <comparable> & a)
{
    for(int p = 1;p<a.size();p++)
       {
         comparable tmp = a[p];
         int j;
         for(j = p;j> 0 && tmp < a[j-1];j--)
               a[j] = a[j-1];
        a[j] = tmp;
        }
}
int main()
  {
   vector<int> array;
   int x;
   cout<< "Enter items to sort:"<<endl;
   while(cin >> x){
      array.push_back(x);}
   insertionSort(array);
   cout<<"Sorted items are:"<<endl;
   for(int i = 0;i<array.size();i++)
        cout<<array[i]<<endl;
   return 0;
}
