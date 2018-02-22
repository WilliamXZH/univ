#include <fstream>
#include <iostream>
using namespace std;
union IODWord{
	int sint;
	unsigned uint;
	float ffloat;
	char ch[5];
};
void main(int argc,char *argv[]){
	if(argc!=2){
		cout<<"USAGE: "<<argv[0]<<endl<<"filename"<<endl;
		argv[0]="a.bin";
		argv[1]="b.bin";
	}
	cout<<"program name:"<<argv[0]<<endl;
	cout<<"io file name:"<<argv[1]<<endl;
	ofstream out;
	out.open(argv[0],ios::binary|ios::out);
	cout<<sizeof(int)<<"_";
	cout<<sizeof(unsigned int)<<"_";
	cout<<sizeof(float )<<"_";
	cout<<sizeof(char )<<"_";
	cout<<sizeof(long int)<<"_";
	cout<<sizeof(double)<<"_";
	IODWord outbuf[20];
	for(int i=0;i<5;i++){
		outbuf[i*4].sint = - i;
		outbuf[i*4+1].uint= i;
		outbuf[i*4+2].ffloat= (float) i*3.14;
		outbuf[i*4+3].ch[0]='a'+i;
		outbuf[i*4+3].ch[1]='A'+i;
		outbuf[i*4+3].ch[2]='0'+i;
		outbuf[i*4+3].ch[3]='9'-i;
		outbuf[i*4+3].ch[4]=' ';
	}
	for(int j=0;j<10;j++){
		out.write((char *)outbuf,sizeof(outbuf));
	}
	out.close();
	ifstream in;
	in.open(argv[0],ios::in|ios::binary);
	IODWord ibuf[4];
	while(in.good()){
		in.read((char *)ibuf,sizeof(ibuf));
	}
	cout<<endl<<"sint="<<ibuf[0].sint<<endl;
	cout<<"uint="<<ibuf[1].uint<<endl;
	cout<<"float="<<ibuf[2].ffloat<<endl;
	cout<<"char="<<ibuf[3].ch<<endl;
}