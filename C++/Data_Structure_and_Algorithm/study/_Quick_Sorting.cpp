template <class Type>
void QuickSort ( datalist<Type> &list, const int left, const int right ) {
//在待排序区间 left?right 中递归地进行快速排序
    if ( left < right) {					
       int pivotpos = Partition ( list, left, right ); //划分
       QuickSort ( list, left, pivotpos-1);	    
        //在左子区间递归进行快速排序
       QuickSort ( list, pivotpos+1, right );
        //在左子区间递归进行快速排序		
    }
}
template <class Type>
int Partition ( datalist<Type> &list, const int low, 
		const int high ) {
int pivotpos = low;     //基准位置
Swap(List.Vector[low],List.Vextor[(low+high)/2]);
Element<Type> pivot = list.Vector[low];	
    for ( int i = low+1; i <= high; i++ )
       if ( list.Vector[i].getKey ( ) < pivot.getKey( ) 
           && ++pivotpos != i  )
          Swap ( list.Vector[pivotpos], list.Vector[i] );
          //小于基准对象的交换到区间的左侧去
    Swap ( list.Vector[low], list.Vector[pivotpos] );
    return pivotpos;
}
