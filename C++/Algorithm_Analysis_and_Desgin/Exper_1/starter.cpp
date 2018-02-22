#include<iostream>
#include "median.h"
#include "graycode.h"
#include "MergeSort.h"
using namespace std;

string infile="input.txt";
string infile3="input3.txt";
string outfile="output.txt";
string outfile2="output2.txt";
string outfile3="output3.txt";

int main(){


	median<int> med;
	med.ReadFile(infile);
	med.PrintFile();
	med.WriteFile(outfile);


	gray g;
	g.readFile(infile);
	g.writeFile(outfile2);

	return 0;

	//merge mer;
	//mer.readFile(infile3);
	//mer.writeFile(outfile3);

}
