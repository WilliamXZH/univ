#include <iostream>
#include <fstream>

using namespace std;

double mid(double* a, double* b,int afrom,int ato,int bfrom,int bto);

int main()
{
    int num = 0;
    ifstream in("input.txt");
    ofstream out("output.txt");
    in>>num;
    double * a = new double[num];
    double * b = new double[num];

    for(int i=0 ; i < num ; i++){
        in>>a[i];
    }
    for(i=0 ; i < num ; i++){
        in>>b[i];
    }

    double aa = mid(a,b,0,num,0,num);
    out<<aa<<endl;
    return 0;
}

double mid(double* a, double* b,int afrom,int ato,int bfrom,int bto){
    if(ato == afrom){
        return (a[afrom]+b[bto])/2.0;}

    if(bto == bfrom){
        return (a[ato]+b[bfrom])/2.0;}

    if(a[(ato+afrom)/2] > b[(bto+bfrom)/2]){
        return mid( a, b,afrom,(ato+afrom)/2,(bto+bfrom)/2,bto);}

    else{
        return mid( a, b,(ato+afrom)/2,ato,bfrom,(bto+bfrom)/2);}
}
