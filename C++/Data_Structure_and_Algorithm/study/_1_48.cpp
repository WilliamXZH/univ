#include <iostream>
#include <cstdlib>
using namespace std;
class my_class {
private: 
     int x;
public:  
     my_class() : x(0) {}  
     my_class(int p) : x(p) {}
     int value() { return x;}
};
   
int main(int argc, char* argv[]) 
{    // Allocate a single object
    my_class* ptr1 = new my_class(4);  
   // Allocate an array of objects
    my_class* ptr2 = new my_class[10];
    cout << ptr1->value() << endl;
    cout << ptr2->value() << endl;
	cout << ptr2[2].value()<<endl;
    return EXIT_SUCCESS;} 
