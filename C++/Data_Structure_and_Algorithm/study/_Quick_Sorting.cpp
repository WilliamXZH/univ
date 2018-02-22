template <class Type>
void QuickSort ( datalist<Type> &list, const int left, const int right ) {
//�ڴ��������� left?right �еݹ�ؽ��п�������
    if ( left < right) {					
       int pivotpos = Partition ( list, left, right ); //����
       QuickSort ( list, left, pivotpos-1);	    
        //����������ݹ���п�������
       QuickSort ( list, pivotpos+1, right );
        //����������ݹ���п�������		
    }
}
template <class Type>
int Partition ( datalist<Type> &list, const int low, 
		const int high ) {
int pivotpos = low;     //��׼λ��
Swap(List.Vector[low],List.Vextor[(low+high)/2]);
Element<Type> pivot = list.Vector[low];	
    for ( int i = low+1; i <= high; i++ )
       if ( list.Vector[i].getKey ( ) < pivot.getKey( ) 
           && ++pivotpos != i  )
          Swap ( list.Vector[pivotpos], list.Vector[i] );
          //С�ڻ�׼����Ľ�������������ȥ
    Swap ( list.Vector[low], list.Vector[pivotpos] );
    return pivotpos;
}
