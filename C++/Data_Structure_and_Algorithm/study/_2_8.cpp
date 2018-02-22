#include <iostream.h>
 #include <stdlib.h>
 template <class Type>
 class Array {
      Type *elements;        
      int ArraySize;            //current size
      void getArray ( );    // dynamic allocate memory for array
 public:
      Array( int Size=DefaultSize );
      Array( const Array<Type>& x );

       ~Array( ) { delete [ ]elements;}		
       Array<Type> & operator =           //copy array
 	         ( const Array<Type> & A );  
       Type& operator [ ] ( int i );	   //get the ith element
       Type* operator *( ) const                //* operator
                 { return elements; }
       int Length ( ) const                         //get the length 
                 { return ArraySize; }		
       void ReSize ( int sz );	            //resize the array

 };
   template <class Type>
  void Array<Type>::getArray ( ) {
  //private function, create the space to store the elements
       elements = new Type[ArraySize];
       if ( elements == 0 ) { 
          ArraySize = 0; 
          cerr << "Memory Allocation Error" << endl;
          return;
  }
 template <class Type>
 Array<Type>::Array ( int sz ) {
     //constructor
     if ( sz <= 0 ) {
        ArraySize = 0;
        cerr << "非法数组大小" << endl;
        return; 
     }		
     ArraySize = sz;
     getArray ( );	
 }
 template <class Type>  Array<Type>::
 Array ( const Array<Type> & x ) {  
 //copy constructor
     int n = ArraySize = x.ArraySize;		
     elements = new Type[n];			
     if ( elements == 0 ) {	
         ArraySize = 0;
         cerr << "存储分配错" << endl;
         return;
     }		
     Type *srcptr = x.elements;			
     Type *destptr = elements;		
     while ( n-- ) * destptr++ = * srcptr++;
 }
template <class Type>
Type & Array<Type>::operator [ ] ( int i ) {
 //get the element by index
      if ( i < 0  ||  i > ArraySize-1 ) {
          cerr << "数组下标超界" << endl;
          return NULL;  
      return element[i];					
 }

Pos = Position[i -1] + Number[i -1]
}
 template <class Type>
 void Array<Type>::Resize (int sz) {
    if ( sz >= 0 && sz != ArraySize ) {
       Type * newarray = new Type[sz];	
       if ( newarray == 0 ) {
           cerr << "存储分配错" << endl;
           return;  }
       int n = ( sz <= ArraySize ) ? sz : ArraySize;	
       Type *srcptr = elements;				
       Type *destptr = newarray;			
       while ( n-- ) * destptr++ = * srcptr++;
       delete [ ] elements;				
        elements = newarray;
        ArraySize = sz;		
    }
 }	
       


       
