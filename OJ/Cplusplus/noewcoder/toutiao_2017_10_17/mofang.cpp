#include<iostream>
using namespace std;

void swap(int &a,int &b,int &c,int &d){
	int tmp = a;
	a = b;
	b = c;
	c = d;
	d = tmp;
}

int getNum(int *p){
	int res = 0;
	res += p[0]*p[1]*p[2]*p[3];
	res += p[4]*p[5]*p[10]*p[11];
	res += p[6]*p[7]*p[12]*p[13];
	res += p[8]*p[9]*p[14]*p[15];
	res += p[16]*p[17]*p[18]*p[19];
	res += p[20]*p[21]*p[22]*p[23];
	return res;
}

//前面顺时针
void fw(int *p){
	swap(p[16],p[18],p[19],p[17]);
	swap(p[12],p[10],p[21],p[14]);
	swap(p[13],p[11],p[20],p[15]);
//	int tmp = p[16];
//	p[16] = p[18];
//	p[18] = p[19];
//	p[19] = p[17];
//	p[17] = tmp;
//
//	tmp = p[12];
//	p[12] = p[10];
//	p[10] = p[21];
//	p[21] = p[14];
//	p[14] = tmp;
//
//	tmp = p[13];
//	p[13] = p[11];
//	p[11] = p[22];
//	p[22] = p[15];
//	p[15] = tmp;
}

//前面逆时针
void fc(int *p){
	swap(p[16],p[17],p[19],p[18]);
	swap(p[12],p[14],p[21],p[10]);
	swap(p[13],p[15],p[20],p[11]);
//	int tmp = p[16];
//	p[16] = p[17];
//	p[17] = p[19];
//	p[19] = p[18];
//	p[18] = tmp;
//
//	tmp = p[12];
//	p[12] = p[14];
//	p[14] = p[21];
//	p[21] = p[10];
//	p[10] = tmp;
//
//	tmp = p[13];
//	p[13] = p[15];
//	p[15] = p[20];
//	p[20] = p[11];
//	p[11] = tmp;
}

void bw(int *p){
	swap(p[]);
}