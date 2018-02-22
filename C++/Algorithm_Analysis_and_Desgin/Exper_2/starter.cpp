#include<IOSTREAM>
#include "Coin.h"
#include "yacht.h"
using namespace std;

int main(){
	coin c;
	c.readFile(string("input.txt"));
	c.writeFile(string("output.txt"));


	yacht y;
	y.readFile(string("input2.txt"));
	y.writeFile(string("output2.txt"));

	return 0;
}