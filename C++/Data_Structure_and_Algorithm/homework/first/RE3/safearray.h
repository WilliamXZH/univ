#ifndef SAFEARRAY_H
#define SAFEARRAY_H

template <class T> 
class safearray {

  private:
    T *storage;
    int capacity;
  
  public:
    safearray() : storage(NULL), capacity(0) {} // default constructor
    safearray(const int); // single param constructor
    ~safearray(void); // destructor
    T& operator[] (const int&) throw(out_of_range); 
};

#endif
