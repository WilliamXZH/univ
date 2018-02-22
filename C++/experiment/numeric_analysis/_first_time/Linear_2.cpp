//�����Է�����
#include<iostream>
#include<iomanip>
#include<cstdlib>
using namespace std;
//----------------------------------------------ȫ�ֱ���������;
const int Number=15; //����������;
double a[Number][Number],b[Number],copy_a[Number][Number],copy_b[Number]; //ϵ������ʽ;
int lenth,copy_lenth; //���̵ĸ���;
char * x; //δ֪��a,b,c������;


//----------------------------------------------����������;
void input(); //���뷽����;
void print_menu(); //��ӡ���˵�;
void gauss_row(); //Gauss����Ԫ�ⷽ����;
void exchange_hang(int m,int n); //�ֱ𽻻�a[][]��b[]�е�m��n����;
void gauss_row_xiaoqu(); //Gauss����Ԫ��ȥ��;
void gauss_calculate(); //����Gauss��ȥ���������δ֪����ֵ;

//������;
void main()
{  
	input(); //���뷽��  ;
	print_menu(); //��ӡ���˵�;

	gauss_row();; //ѡ����ʽ;

}


//����������;
void print_menu()
{  
	system("cls");
	cout<<"------------����ϵ���ͳ��������ʾ����:\n";
	for(int j=0;j<lenth;j++)
		cout<<"ϵ��"<<j+1<<" ";
	cout<<"\t����";
	cout<<endl;
	for(int i=0;i<lenth;i++)
	{
		for(int j=0;j<lenth;j++)
			cout<<setw(8)<<setiosflags(ios::left)<<a[i][j];
		cout<<"\t"<<b[i]<<endl;
	}
}

void input()
{ 
	int i,j;
	cout<<"���̵ĸ���:";
	cin>>lenth;
	if(lenth>Number)
	{  
		cout<<"It is too big.\n";
		return;  
	}
	x=new char[lenth];  
	for(i=0;i<lenth;i++)
		x[i]='a'+i;

	//���뷽�̾���;
	//��ʾ�������;
	cout<<"====================================================\n";
	cout<<"����ÿ������������"<<lenth<<"ϵ����һ������:\n";
	cout<<"����\n����:a";
	for(i=1;i<lenth;i++)
	{
		cout<<"+"<<i+1<<x[i];
	}
	cout<<"=10\n";
	cout<<"Ӧ����:";
	for(i=0;i<lenth;i++)
		cout<<i+1<<" ";
	cout<<"10\n";
	cout<<"==============================\n";


	//����ÿ������;
	for(i=0;i<lenth;i++)
	{  
		cout<<"���뷽��"<<i+1<<":";
		for(j=0;j<lenth;j++)
			cin>>a[i][j];
		cin>>b[i];
	}

	//��������;
	for(i=0;i<lenth;i++)
		for(j=0;j<lenth;j++)
			copy_a[i][j]=a[i][j];
	for(i=0;i<lenth;i++)
		copy_b[i]=b[i];
	copy_lenth=lenth;
}


//��˹����Ԫ������ⷽ��;
void gauss_row()
{
	int i,j;
	//�ø�˹����Ԫ��������ϵ��������һ�������Ǿ���;
	gauss_row_xiaoqu(); 

	//��ӡ��˹��ȥ�������������Ǿ���;
	for(i=0;i<lenth;i++)
	{
		for(j=0;j<lenth;j++)
		{
			cout<<setw(10)<<setprecision(5)<<a[i][j];
		}
		cout<<setw(10)<<b[i]<<endl;
	}
	//ͨ���ж���Ԫλ���ϵ�Ԫ���Ƿ�Ϊ����ȷ���Ƿ���Ψһ��;
	if(a[lenth-1][lenth-1]!=0)
	{
		cout<<"ϵ������ʽ��Ϊ��,������Ψһ�Ľ⣺\n" << endl;
		gauss_calculate();
		for(i=0;i<lenth;i++) //������;
		{  
			cout<<x[i]<<"="<<b[i]<<"\n";
		}
	}
	else
	{
		cout<<"ϵ������ʽ������,����û��Ψһ�Ľ�.\n";
	}
}

/************************************************************************/
/* ʹ�ø�˹��ȥ����ʹ��ϵ��������һ�������Ǿ���;
/************************************************************************/
void gauss_row_xiaoqu() 
{
	int i,j,k,maxi;double lik;
	cout<<"��Gauss����Ԫ��ȥ���������:\n";
	for(k=0;k<lenth-1;k++)
	{  
		maxi = k;
		//Ѱ����Ԫ��һ��������Ԫ�ص��У�������Ԫ���ڵ��н��н���;
		for(i=k;i<lenth;i++)
		{
			if(a[i][k]>a[maxi][k]) 
			{
				maxi=i;
			}
		}
		//������������;
		if(maxi!=k)  
		{
			exchange_hang(k,maxi);//
		}

		//��ȥ��Ԫ������һ��ʣ���Ԫ��;
		for(i=k+1;i<lenth;i++)
		{  
			lik=a[i][k]/a[k][k];
			for(j=k;j<lenth;j++)
			{
				a[i][j]=a[i][j]-a[k][j]*lik;
			}
			b[i]=b[i]-b[k]*lik;
		}
	}
}

void gauss_calculate() //��˹��ȥ���Ժ����δ֪���Ľ��;
{  
	int i,j;double sum_ax;
	b[lenth-1]=b[lenth-1]/a[lenth-1][lenth-1];
	for(i=lenth-2;i>=0;i--)
	{  
		for(j=i+1,sum_ax=0;j<lenth;j++)
		{
			sum_ax+=a[i][j]*b[j];
		}
		b[i]=(b[i]-sum_ax)/a[i][i];
	}
}

void exchange_hang(int m,int n) //����a[][]�к�b[]����;
{  
	int j; double temp;
	for(j=0;j<lenth;j++)
	{
		temp=a[m][j];
		a[m][j]=a[n][j];
		a[n][j]=temp;

	}
	temp=b[m];
	b[m]=b[n];
	b[n]=temp;
}
