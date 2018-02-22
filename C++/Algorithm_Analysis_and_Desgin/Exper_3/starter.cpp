#include<iostream>
#include "capacity.h"
#include "knapsack.h"
using namespace std;
int main(){

	load<int> ld;
	ld.readFile("input.txt");
	ld.writeFile("output.txt");
	
	cout<<endl;
	knap<int,int> knp;
	knp.readFile("input_2.txt");
	knp.writeFile("write_2.txt");

	return 0;
}