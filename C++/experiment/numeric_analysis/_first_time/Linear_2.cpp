//解线性方程组
#include<iostream>
#include<iomanip>
#include<cstdlib>
using namespace std;
//----------------------------------------------全局变量定义区;
const int Number=15; //方程最大个数;
double a[Number][Number],b[Number],copy_a[Number][Number],copy_b[Number]; //系数行列式;
int lenth,copy_lenth; //方程的个数;
char * x; //未知量a,b,c的载体;


//----------------------------------------------函数声明区;
void input(); //输入方程组;
void print_menu(); //打印主菜单;
void gauss_row(); //Gauss列主元解方程组;
void exchange_hang(int m,int n); //分别交换a[][]和b[]中的m与n两行;
void gauss_row_xiaoqu(); //Gauss列主元消去法;
void gauss_calculate(); //根据Gauss消去法结果计算未知量的值;

//主函数;
void main()
{  
	input(); //输入方程  ;
	print_menu(); //打印主菜单;

	gauss_row();; //选择解答方式;

}


//函数定义区;
void print_menu()
{  
	system("cls");
	cout<<"------------方程系数和常数矩阵表示如下:\n";
	for(int j=0;j<lenth;j++)
		cout<<"系数"<<j+1<<" ";
	cout<<"\t常数";
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
	cout<<"方程的个数:";
	cin>>lenth;
	if(lenth>Number)
	{  
		cout<<"It is too big.\n";
		return;  
	}
	x=new char[lenth];  
	for(i=0;i<lenth;i++)
		x[i]='a'+i;

	//输入方程矩阵;
	//提示如何输入;
	cout<<"====================================================\n";
	cout<<"请在每个方程里输入"<<lenth<<"系数和一个常数:\n";
	cout<<"例：\n方程:a";
	for(i=1;i<lenth;i++)
	{
		cout<<"+"<<i+1<<x[i];
	}
	cout<<"=10\n";
	cout<<"应输入:";
	for(i=0;i<lenth;i++)
		cout<<i+1<<" ";
	cout<<"10\n";
	cout<<"==============================\n";


	//输入每个方程;
	for(i=0;i<lenth;i++)
	{  
		cout<<"输入方程"<<i+1<<":";
		for(j=0;j<lenth;j++)
			cin>>a[i][j];
		cin>>b[i];
	}

	//备份数据;
	for(i=0;i<lenth;i++)
		for(j=0;j<lenth;j++)
			copy_a[i][j]=a[i][j];
	for(i=0;i<lenth;i++)
		copy_b[i]=b[i];
	copy_lenth=lenth;
}


//高斯列主元排列求解方程;
void gauss_row()
{
	int i,j;
	//用高斯列主元消区法将系数矩阵变成一个上三角矩阵;
	gauss_row_xiaoqu(); 

	//打印高斯消去法产生的上三角矩阵;
	for(i=0;i<lenth;i++)
	{
		for(j=0;j<lenth;j++)
		{
			cout<<setw(10)<<setprecision(5)<<a[i][j];
		}
		cout<<setw(10)<<b[i]<<endl;
	}
	//通过判断主元位置上的元素是否为零来确定是否有唯一解;
	if(a[lenth-1][lenth-1]!=0)
	{
		cout<<"系数行列式不为零,方程有唯一的解：\n" << endl;
		gauss_calculate();
		for(i=0;i<lenth;i++) //输出结果;
		{  
			cout<<x[i]<<"="<<b[i]<<"\n";
		}
	}
	else
	{
		cout<<"系数行列式等于零,方程没有唯一的解.\n";
	}
}

/************************************************************************/
/* 使用高斯消去法，使得系数矩阵变成一个上三角矩阵;
/************************************************************************/
void gauss_row_xiaoqu() 
{
	int i,j,k,maxi;double lik;
	cout<<"用Gauss列主元消去法结果如下:\n";
	for(k=0;k<lenth-1;k++)
	{  
		maxi = k;
		//寻找主元这一列上最大的元素的行，并与主元所在的行进行交换;
		for(i=k;i<lenth;i++)
		{
			if(a[i][k]>a[maxi][k]) 
			{
				maxi=i;
			}
		}
		//交换两行数据;
		if(maxi!=k)  
		{
			exchange_hang(k,maxi);//
		}

		//消去主元所在这一列剩余的元素;
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

void gauss_calculate() //高斯消去法以后计算未知量的结果;
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

void exchange_hang(int m,int n) //交换a[][]中和b[]两行;
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
