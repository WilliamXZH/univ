#include<iostream>
#include<iomanip>
using namespace std;

class Data
{
	private:
		int n;//����ʽ�Ĵ���
		double *x,*y;//�洢���x��yֵ������ĵ�ַ
		double *denominator;//���ڹ������ʽʱ�洢��ĸ��ʵ��δʹ��
		double *numerator;//���ڹ������ʽʱ�洢���ӣ�ʵ��δʹ��

	public:
		Data();//δ�����κβ����Ĺ��췽��
		Data(int tn);//ȷ�������Ĺ��췽��
		Data(int tn,double *tx,double *ty);//��׼�����ݹ��췽��
		int GetN();//��ö���ʽ�Ĵ�����ʵ��δ�����ʹ��
		void SetN(int tn);//���ô����ķ�����ʵ��δ�����ʹ��
		void SetXY(double *tx,double *ty);//�������ݵķ�����δ�����ʹ��
		double Lagrange_CountfX(double tx);//ʹ��Lagrange��ֵ����ʽ����f(tx)
		double Piecewise2_CountfX(double tx);//ʹ�ö���ֶ�2�β�ֵ����ʽ����f(tx)
		double Piecewise3_CountfX(double tx);//ʹ������ֶ�2�β�ֵ����ʽ����f(tx)
		void PrintData();//�������������
};

int main(){
	double xy[2][6]={0.4,0.55,0.65,0.80,0.95,1.05,0.41075,0.57815,0.69675,0.90,1.00,1.25382};
	double xy2[2][7]={1,2,3,4,5,6,7,0.368,0.135,0.050,0.018,0.007,0.002,0.001};
	Data *data=new Data(6,xy[0],xy[1]);
	data->PrintData();
	cout<<"Lagrange��ֵ����ʽf(0.596)="<<data->Lagrange_CountfX(0.596)<<endl;
	cout<<"Lagrange��ֵ����ʽf(0.99)="<<data->Lagrange_CountfX(0.99)<<endl;
	cout<<"����ֶ�2�β�ֵ����ʽf(0.596)="<<data->Piecewise2_CountfX(0.596)<<endl;
	cout<<"����ֶ�2�β�ֵ����ʽf(0.99)="<<data->Piecewise2_CountfX(0.99)<<endl;
	cout<<"����ֶ�2�β�ֵ����ʽf(0.596)="<<data->Piecewise3_CountfX(0.596)<<endl;
	cout<<"����ֶ�2�β�ֵ����ʽf(0.99)="<<data->Piecewise3_CountfX(0.99)<<endl;
	cout<<endl;
	Data data2(7,xy2[0],xy2[1]);
	data2.PrintData();
	cout<<"Lagrange��ֵ����ʽf(1.8)="<<data2.Lagrange_CountfX(1.8)<<endl;
	cout<<"����ֶ�2�β�ֵ����ʽf(1.8)="<<data2.Piecewise2_CountfX(1.8)<<endl;
	cout<<"����ֶ�2�β�ֵ����ʽf(1.8)="<<data2.Piecewise3_CountfX(1.8)<<endl;
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
	return tem.Lagrange_CountfX(tx);//ֱ������2��Lagrange��ֵ����ʽ��ʽ

	/*middlex=x[i-1]/2+x[i]/2;
	middley=Lagrange_CountfX(middlex);
	cout<<i<<" "<<middlex<<"\t"<<middley<<endl;
	return (tx-middlex)*(tx-x[i])*y[i-1]/((x[i]-x[i-1])*(x[i]-x[i-1])/2)
		-(tx-x[i-1])*(tx-x[i])*middley/((x[i]-x[i-1])*(x[i]-x[i-1])/4)
		+(tx-x[i-1])* (tx-middlex)* y[i]/((x[i]-x[i-1])* (x[i]-x[i-1])/2);
	*///�ֶ�2�β�ֵ����ʽ�ľ��幫ʽ��
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