#include<iostream>
#include<fstream>
using namespace std;
int iaary[2]={99,10};
int main()
{
	ofstream os("test.dat",ios_base::binary);
	os.write((char*)iaary,sizeof(iaary));
	os.close();
	ofstream ofs;
	ofs.open("test.dat",ios_base::binary);
	ofs.write((char*)iaary,4);
	ofs.close();

	/*
	ifstream myFile;
	myFile.open("filename",iosmode);
	or
	ifstream *pmyFile=new ifstream;
	pmyFile->open("filename",iosmode);
	ifstream myFile("filename",iosmode);
	
	*/
}