#include<iostream>
#include<iomanip>
using namespace std;

class Data
{
	private:
		int n;//多项式的次数
		double *x,*y;//存储多个x和y值的数组的地址
		double *denominator;//用于构造多项式时存储分母，实际未使用
		double *numerator;//用于构造多项式时存储分子，实际未使用

	public:
		Data();//未传递任何参数的构造方法
		Data(int tn);//确定次数的构造方法
		Data(int tn,double *tx,double *ty);//标准的数据构造方法
		int GetN();//获得多项式的次数，实际未定义和使用
		void SetN(int tn);//设置次数的方法，实际未定义和使用
		void SetXY(double *tx,double *ty);//设置数据的方法，未定义和使用
		double Lagrange_CountfX(double tx);//使用Lagrange插值多项式计算f(tx)
		double Piecewise2_CountfX(double tx);//使用二点分段2次插值多项式计算f(tx)
		double Piecewise3_CountfX(double tx);//使用三点分段2次插值多项式计算f(tx)
		void PrintData();//输出给定的数据
};

int main(){
	double xy[2][6]={0.4,0.55,0.65,0.80,0.95,1.05,0.41075,0.57815,0.69675,0.90,1.00,1.25382};
	double xy2[2][7]={1,2,3,4,5,6,7,0.368,0.135,0.050,0.018,0.007,0.002,0.001};
	Data *data=new Data(6,xy[0],xy[1]);
	data->PrintData();
	cout<<"Lagrange插值多项式f(0.596)="<<data->Lagrange_CountfX(0.596)<<endl;
	cout<<"Lagrange插值多项式f(0.99)="<<data->Lagrange_CountfX(0.99)<<endl;
	cout<<"两点分段2次插值多项式f(0.596)="<<data->Piecewise2_CountfX(0.596)<<endl;
	cout<<"两点分段2次插值多项式f(0.99)="<<data->Piecewise2_CountfX(0.99)<<endl;
	cout<<"三点分段2次插值多项式f(0.596)="<<data->Piecewise3_CountfX(0.596)<<endl;
	cout<<"三点分段2次插值多项式f(0.99)="<<data->Piecewise3_CountfX(0.99)<<endl;
	cout<<endl;
	Data data2(7,xy2[0],xy2[1]);
	data2.PrintData();
	cout<<"Lagrange插值多项式f(1.8)="<<data2.Lagrange_CountfX(1.8)<<endl;
	cout<<"两点分段2次插值多项式f(1.8)="<<data2.Piecewise2_CountfX(1.8)<<endl;
	cout<<"三点分段2次插值多项式f(1.8)="<<data2.Piecewise3_CountfX(1.8)<<endl;
}

Data::Data(){}
Data::Data(int tn):n(tn-1){}
Data::Data(int tn,double *tx,double *ty):n(tn-1),x(tx),y(ty){}
double Data::Lagrange_CountfX(double tx){
	int i,j,k;
	double sum=0,tnum,tden;
	for(i=0;i<=n;i++)if(tx==x[i])return y[i];
	for(k=0;k<=n;k++){
		for(i=0,tnum=1;i<=n;i++){
			if(i==k)continue;
			else tnum*=tx-x[i];
		}
		for(i=0,tden=1;i<=n;i++){
			if(i==k)continue;
			else tden*=x[k]-x[i];
		}
		sum+=y[k]*tnum/tden;
	}  
	return sum;
}
double Data::Piecewise2_CountfX(double tx){
	int i;
	//double middlex,middley;
	double xy[2][3];
	for(i=0;i<=n;i++){
		if(x[i]>tx)break;
		else if(x[i]==tx)return y[i];
	}
	xy[0][0]=x[i-1];
	xy[0][1]=x[i-1]/2+x[i]/2;
	xy[0][2]=x[i];
	xy[1][0]=y[i-1];
	xy[1][1]=Lagrange_CountfX(xy[0][1]);
	xy[1][2]=y[i];
	Data tem(3,xy[0],xy[1]);
	return tem.Lagrange_CountfX(tx);//直接套用2次Lagrange插值多项式公式

	/*middlex=x[i-1]/2+x[i]/2;
	middley=Lagrange_CountfX(middlex);
	cout<<i<<" "<<middlex<<"\t"<<middley<<endl;
	return (tx-middlex)*(tx-x[i])*y[i-1]/((x[i]-x[i-1])*(x[i]-x[i-1])/2)
		-(tx-x[i-1])*(tx-x[i])*middley/((x[i]-x[i-1])*(x[i]-x[i-1])/4)
		+(tx-x[i-1])* (tx-middlex)* y[i]/((x[i]-x[i-1])* (x[i]-x[i-1])/2);
	*///分段2次插值多项式的具体公式，
}
double Data::Piecewise3_CountfX(double tx){
	int i;
	for(i=0;i<n;i++){
		if(x[i]>tx)break;
		else if(x[i]==tx)return y[i];
	}
	if(x[i]-tx>tx-x[i-1])i--;
	Data tem(3,&x[i-1],&y[i-1]);
	return tem.Lagrange_CountfX(tx);
}
void Data::PrintData(){
	int i;
	for(cout<<"x:",i=0;i<=n;i++)cout<<setiosflags(ios_base::left)<<setw(10)<<x[i]<<"\t";
	cout<<endl;
	for(cout<<"y:",i=0;i<=n;i++)cout<<setiosflags(ios_base::left)<<setw(10)<<y[i]<<"\t";
	cout<<endl<<endl;
}