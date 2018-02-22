#include <iostream> 
#include <string> 
#include <cstdlib> 
#include <stack>
 using namespace std;
 int main(int argc, char* argv[]) 
{     stack<int> s; 
      s.push(1); s.pop();    
      s.push(10); s.push(11); 
      cout << s.top() << endl; 
      cout << s.size() << endl;
      cout << s.empty() << endl; 
      return EXIT_SUCCESS; } 
