#include<iostream>
#include<vector>
using namespace std;
class fives
{
	private:
		int n,count;
	public:
		vector<int> squ;
		fives();
		fives(int N,int c);
		void SetN(int N);
		void SetCount(int c);
		int check();
		void print();
};
fives::fives(int N,int c)
{
	SetN(N);SetCount(c%2);
	squ=new vector<int>(n*n);
}
void fives::SetN(int N){n=N;}
void fives::SetCount(int c){count=c;}

int main()
{
}