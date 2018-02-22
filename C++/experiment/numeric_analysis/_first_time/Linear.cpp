#include<iostream>
#include<iomanip>
#include<cmath>
#include<windows.h>
#define N 10
#define PrintLine {for(int l=0;l<70;l++)cout<<"-";cout<<endl;}
#define PERR(bSuccess, api) {if(!(bSuccess)) printf("%s:Error %d from %s \on line %d\n", __FILE__, GetLastError(), api, __LINE__);}
using namespace std;
float num1[]={4,2,-3,-1,2,1,0,0,0,0,5,
	8,6,-5,-3,6,5,0,1,0,0,12,
	4,2,-2,-1,3,2,-1,0,3,1,3,
	0,-2,1,5,-1,3,-1,1,9,4,2,
	-4,2,6,-1,6,7,-3,3,2,3,3,
	8,6,-8,5,7,17,2,6,-3,5,46,
	0,2,-1,3,-4,2,5,3,0,1,13,
	16,10,-11,-9,17,34,2,-1,2,2,38,
	4,6,2,-7,13,9,2,0,12,4,19,
	0,0,-1,8,-3,-24,-8,6,3,-1,-21
};
float num2[]={4,2,-4,0,2,4,0,0,0,
	2,2,-1,-2,1,3,2,0,-6,
	-4,-1,14,1,-8,-3,5,6,6,
	0,-2,1,6,-1,-4,-3,3,23,
	2,1,-8,-1,22,4,-10,-3,11,
	4,3,-3,-4,4,11,1,-4,-22,
	0,2,5,-3,-10,1,14,2,-15,
	0,0,6,3,-3,-4,2,19,45
};
float num3[]={4,-1,0,0,0,0,0,0,0,0,7,
	-1,4,-1,0,0,0,0,0,0,0,5,
	0,-1,4,-1,0,0,0,0,0,0,-13,
	0,0,-1,4,-1,0,0,0,0,0,2,
	0,0,0,-1,4,-1,0,0,0,0,6,
	0,0,0,0,-1,4,-1,0,0,0,-12,
	0,0,0,0,0,-1,4,-1,0,0,14,
	0,0,0,0,0,0,-1,4,-1,0,-4,
	0,0,0,0,0,0,0,-1,4,-1,5,
	0,0,0,0,0,0,0,0,-1,4,-5
};
void clrscr();
class Linear
{
	private:
		int n;
		float p[N][N+1],*q;//=(float*)p;
	public:
		Linear();
		int GetN(){return n;}
		float *GetP(){return q;}
		void PrintLinear();//矩阵/方程组的输出
		void PrintLinear(int n,float *p,int m);
		void PrintLinear(int m,int n,float *p,int l);
		void LinearBuilder(float *origin,int l);//矩阵建立
		void LinearCopy(float *origin,int l,float *target,int m);//矩阵拷贝
		void LinearCopy(float *origin,int k,int l,float *target,int m,int n);
		void GaussSeq(int order=0);//顺序消去法
		void GaussCol();//列主元消去法
		void SquRoot();//平方根法
		void SquRootImp();//改进平方根法
		void ChaMet();//追赶法
		void UpperCal(int n,float *p);//上三角矩阵的计算
		void LowerCal(int n,float *p);//下三角矩阵的计算
		
		void LineGene(int n,float *p);//一般方程组的建立
		void LineSym(int n,float *p);//对称正定方程组的建立
		void LineThDia(int n,float *p);//三对角方程组的建立
		void LinearBuilder_root();//方程组建立的根目录/菜单
		void DirectMet_root();//方程组直接算法的根目录/菜单
		void ExSample();//直接建立试验例题的方程组的菜单
};
int main(){
	Linear line;
	/*float num[]={4,-2,4,2,
		-2,5,0,1,
		4,0,6,0
	};*/
	/*float num[]={2,-1,0,0,1,
				-1,2,-1,0,0,
				0,-1,2,-1,0,
				0,0,-1,2,1};*/
	while(1){
		char choose,flag=0;
		cout<<"***********************"<<endl;
		cout<<"*1.建立/更改线性方程组*"<<endl;
		cout<<"*2.直接方法求解方程组 *"<<endl;
		cout<<"*3.打印线性方程组     *"<<endl;
		cout<<"*4.实验例题           *"<<endl;
		cout<<"*0.退出               *"<<endl;
		cout<<"***********************"<<endl;
		cin>>choose;
		switch(choose){
			case '1':
				line.LinearBuilder_root();
				break;
			case '2':
				line.DirectMet_root();
				break;
			case '3':
				line.PrintLinear();
				break;
			case '4':
				line.ExSample();
				break;
			case '0':
				flag=1;
				return 0;
				break;//无效代码
			default:
				cout<<"输入无效，请重新输入";
				continue;
		}
		clrscr();
	}
	//line.LinearBuilder(num,10);
	//line.PrintLinear();
	//line.GaussSeq();
	//line.GaussCol();
	//line.SquRoot();
	//line.ChaMet();
}
void Linear::ExSample(){
	char choose;
	cout<<"**********************"<<endl;
	cout<<"*1.第一题            *"<<endl;
	cout<<"*2.第二题            *"<<endl;
	cout<<"*3.第三题            *"<<endl;
	cout<<"*0.返回              *"<<endl;
	cout<<"**********************"<<endl;
	cin>>choose;
	switch(choose){
		case '1':
			LinearBuilder(num1,10);
			break;
		case '2':
			LinearBuilder(num2,8);
			break;
		case '3':
			LinearBuilder(num3,10);
			break;
		case '0':
			return;
			break;
		default:
			cout<<"输入错误，请重新输入:"<<endl;
	}
}
void Linear::DirectMet_root(){
	while(1){
		char choose;
		cout<<"**********************"<<endl;
		cout<<"*1.高斯消去法        *"<<endl;
		cout<<"*2.列主元高斯消去法  *"<<endl;
		cout<<"*3.平方根法          *"<<endl;
		cout<<"*4.追赶法            *"<<endl;
		cout<<"*0.返回              *"<<endl;
		cout<<"**********************"<<endl;
		cin>>choose;
		switch(choose){
			case '1':
				GaussSeq();
				break;
			case '2':
				GaussCol();
				break;
			case '3':
				SquRoot();
				break;
			case '4':
				ChaMet();
				break;
			case '0':
				return;
				break;//无效代码
			default:
				cout<<"输入无效，请重新输入";
				continue;
		}
	}
}
void Linear::LinearBuilder_root(){
	int i,n;
	float *p;
	cout<<"输入线性方程组的大小(行数):"<<endl;
	cin>>n;
	cout<<"分配内存开始:"<<endl;
	p=(float*)malloc(n*(n+1)*sizeof(float));
	memset(p,0,n*(n+1)*sizeof(float));
	char choose;
	cout<<"**********************"<<endl;
	cout<<"*1.一般线性方程组    *"<<endl;
	cout<<"*2.对称正定线性方程组*"<<endl;
	cout<<"*3.三对角线性方程组  *"<<endl;
	cout<<"*0.返回              *"<<endl;
	cout<<"**********************"<<endl;
	cin>>choose;
	switch(choose){
		case '1':
			LineGene(n,p);
			break;
		case '2':
			LineSym(n,p);
			break;
		case '3':
			LineThDia(n,p);
			break;
		case '0':
			return;
			break;
		default:
			break;
	}
	LinearBuilder(p,n);
}
void Linear::LineGene(int n,float *p){
	cout<<"一般线性方程组:"<<endl;
	for(int j,i=0;i<n;i++)
	{
		cout<<"第"<<(i+1)<<"行"<<(n+1)<<"个数"<<endl;
		for(j=0;j<n+1;j++)cin>>p[i*(n+1)+j];
	}
}
void Linear::LineSym(int n,float *p){
	cout<<"对称正定线性方程组:"<<endl;
	for(int j,i=0;i<n;i++){
		cout<<"第"<<i+1<<"行"<<i+2<<"个数"<<endl;
		for(j=0;j<i;j++){cin>>p[i*(n+1)+j];p[j*(n+1)+i]=p[i*(n+1)+j];}
		cin>>p[i*(n+1)+n];
	}
}
void Linear::LineThDia(int n,float *p){
	/*int temp,flag;
	cout<<"三对角线性方程组"<<endl;
	for(int j,i=0;i<n;i++){
		if(i==0||i==n-1)temp=2;
		else temp=3;
		if(i==1)flag=1;
		else flag=0;
		for(j=0;j<temp;j++)cin>>p[i*(n+1)+i+j-flag];
	}*/
	cout<<"输入a1~an:"<<endl;
	for(int i=0;i<n;i++)cin>>p[i*(n+1)+i];
	cout<<"输入b1~bn:"<<endl;
	for(i=0;i<n;i++)cin>>p[i*(n+1)+n];
	cout<<"输入c1~cn-1:"<<endl;
	for(i=0;i<n-1;i++)cin>>p[i*(n+1)+(i+1)];
	cout<<"输入d1~dn:"<<endl;
	for(i=1;i<n;i++)cin>>p[i*(n+1)+(i-1)];
}





Linear::Linear():n(N){
	memset(p,0,sizeof(p));
	q=(float *)p;
}
void Linear::PrintLinear(){
	//PrintLinear(GetN(),GetP(),N);
	PrintLinear(n,(float *)p,N);
}
void Linear::PrintLinear(int n,float *p,int m){
	PrintLinear(n,n+1,p,m+1);
}
void Linear::PrintLinear(int m,int n,float *p,int l){
	for(int i=0;i<m;i++,cout<<"|"<<endl)
	{
		cout<<"|";
		for(int j=0;j<n;j++){
			//cout.width(6);
			cout<<setiosflags(ios_base::left)<<setw(80/(N+2))<<setprecision(3)<<p[i*l+j];
		}
	}
}

void Linear::LinearBuilder(float *origin,int l){
	n=l;
	LinearCopy(origin,l,q,N);
}
void Linear::LinearCopy(float *origin,int l,float *target,int m){
	LinearCopy(origin,l,l+1,target,m,m+1);
}
void Linear::LinearCopy(float *origin,int k,int l,float *target,int m,int n){
	memset(target,0,sizeof(target));
	for(int i=0;i<m;i++){
		for(int j=0;j<n;j++)
			target[i*n+j]=origin[i*l+j];
	}
}

void Linear::GaussCol(){
	GaussSeq(1);
}
void Linear::GaussSeq(int order){
	float *tem=(float*)malloc(n*(n+1)*sizeof(float));
	float *tem2=(float*)malloc(n*n*sizeof(float));
	float *tem3=(float*)malloc(n*n*sizeof(float));
	memset(tem2,0,n*n*sizeof(float));
	memset(tem3,0,n*n*sizeof(float));
	for(int i=0;i<n;i++){
		for(int j=0;j<n+1;j++)tem[i*(n+1)+j]=p[i][j];
		tem2[i*n+i]=1;
	}
	PrintLine;
	cout<<"要计算的线性方程组"<<endl;
	PrintLinear(n,tem,n);
	for(i=0;i<n-1;i++){
		if(order){
			int t=i;
			for(int j=i+1;j<n;j++){
				if(fabs(tem[t*(n+1)+i])<fabs(tem[j*(n+1)+i]))t=j;
			}
			if(t-i){
				float temp;
				for(j=i;j<n+1;j++){
					temp=tem[i*(n+1)+j];
					tem[i*(n+1)+j]=tem[t*(n+1)+j];
					tem[t*(n+1)+j]=temp;
				}
				PrintLine;
				cout<<"列主元得"<<endl;
				PrintLine;
				PrintLinear(n,tem,n);
				PrintLine;
			}
		}
		for(int j=i+1;j<n;j++)
		{
			if(!tem[j*(n+1)+i])continue;
			tem2[j*n+i]=tem[j*(n+1)+i]/tem[i*(n+1)+i];
			for(int k=n;k>=i;k--)
				tem[j*(n+1)+k]-=tem[i*(n+1)+k]*tem[j*(n+1)+i]/tem[i*(n+1)+i];
		}
		PrintLine;
		cout<<"第"<<(i+1)<<"次第一种消元后得:"<<endl;
		PrintLine;
		PrintLinear(n,tem,n);
		PrintLine;
	}
	LinearCopy(tem,n,n+1,tem3,n,n);
	for(i=n-1;i>=1;i--){
		for(int j=i-1;j>=0;j--){
			if(!tem[j*(n+1)+i])continue;
			for(int k=n;k>=i;k--)
				tem[j*(n+1)+k]-=tem[j*(n+1)+i]*tem[i*(n+1)+k]/tem[i*(n+1)+i];
		}
		PrintLine;
		cout<<"第"<<(n-i)<<"次第二种消元后得:"<<endl;
		PrintLine;
		PrintLinear(n,tem,n);
		PrintLine;
	}
	PrintLine;
	cout<<"矩阵L:"<<endl;
	PrintLine;
	PrintLinear(n,n,tem2,n);
	PrintLine;
	cout<<"矩阵U:"<<endl;
	PrintLine;
	PrintLinear(n,n,tem3,n);
	PrintLine;
	for(i=0;i<n;i++)cout<<"X"<<i+1<<"="<<tem[i*(n+1)+n]/tem[i*(n+1)+i]<<endl;
	delete tem,tem2,tem3;
}

void Linear::SquRoot(){
	float *tem=(float*)malloc(n*(n+1)*sizeof(float));
	float *tem2=(float*)malloc(n*(n+1)*sizeof(float));
	float *tem3=(float*)malloc(n*(n+1)*sizeof(float));
	memset(tem2,0,n*(n+1)*sizeof(float));
	memset(tem3,0,n*(n+1)*sizeof(float));
	/*for(int i=0;i<n;i++){
		for(int j=0;j<n+1;j++)tem[i*(n+1)+j]=p[i][j];
	}*/
	LinearCopy(GetP(),N,tem,GetN());
	PrintLine;
	cout<<"要计算的线性方程组:"<<endl;
	PrintLinear(n,tem,n);
	PrintLine;
	for(int i=0;i<n-1;i++){
		for(int j=i+1;j<n;j++)
		{
			if(!tem[j*(n+1)+i])continue;
			tem3[j*(n+1)+i]=tem[j*(n+1)+i]/sqrt(tem[i*(n+1)+i]);
			for(int k=n;k>=i;k--)
				tem[j*(n+1)+k]-=tem[i*(n+1)+k]*tem[j*(n+1)+i]/tem[i*(n+1)+i];
		}
	}
	//LinearCopy(tem,n,n+1,tem2,n,n+1);
	for(i=0;i<n;i++){
		for(int j=i+1;j<n;j++)tem2[i*(n+1)+j]=tem[i*(n+1)+j]/sqrt(tem[i*(n+1)+i]);
		tem3[i*(n+1)+i]=sqrt(tem[i*(n+1)+i]);
		tem2[i*(n+1)+i]=sqrt(tem[i*(n+1)+i]);
		tem3[i*(n+1)+n]=p[i][n];
	}
	
	int flag=0;
	for(i=0;i<n;i++){
		for(int j=i;j<n;j++){
			if(tem2[i*(n+1)+j]!=tem3[j*(n+1)+i]){
				flag=1;
				break;
			}
		}
		if(flag)break;
	}
	if(flag){
		cout<<"error:此线性方程组不是对称正定方程组"<<endl;
		return;
	}

	PrintLine;
	cout<<"计算的矩阵Gy=b:"<<endl;
	PrintLinear(n,tem3,n);
	PrintLine;
	/*for(i=0;i<n-1;i++){
		for(int j=i+1;j<n;j++)
		{
			if(!tem3[j*(n+1)+i])continue;
			for(int k=n;k>=i;k--)
				tem3[j*(n+1)+k]-=tem3[i*(n+1)+k]*tem3[j*(n+1)+i]/tem3[i*(n+1)+i];
		}
		PrintLine;
		cout<<"第"<<i+1<<"次第一种消元后得:"<<endl;
		PrintLine;
		PrintLinear(n,tem3,n);
		PrintLine;
	}*/
	PrintLine;
	LowerCal(n,tem3);
	PrintLinear(n,tem2,n);
	PrintLine;

	for(i=0;i<n;i++)tem2[i*(n+1)+n]=tem3[i*(n+1)+n]/tem3[i*(n+1)+i];
	PrintLine;
	PrintLinear(n,n+1,tem2,n+1);
	PrintLine;
	UpperCal(n,tem2);
	PrintLinear(n,tem2,n);
	PrintLine;
	/*for(i=n-1;i>=1;i--){
		for(int j=i-1;j>=0;j--)
			for(int k=n;k>=i;k--)
				tem2[j*(n+1)+k]-=tem2[j*(n+1)+i]*tem2[i*(n+1)+k]/tem2[i*(n+1)+i];
		PrintLine;
		cout<<"第"<<(n-i)<<"次第二种消元后得:"<<endl;
		PrintLine;
		PrintLinear(n,tem2,n);
		PrintLine;
	}*/

	for(i=0;i<n;i++)cout<<"X"<<i+1<<"="<<tem2[i*(n+1)+n]/tem2[i*(n+1)+i]<<endl;
}

void Linear::ChaMet(){
	float *tem=(float*)malloc(n*(n+1)*sizeof(float));
	float *tem2=(float*)malloc(n*(n+1)*sizeof(float));
	float *tem3=(float*)malloc(n*(n+1)*sizeof(float));
	memset(tem2,0,n*(n+1)*sizeof(float));
	memset(tem3,0,n*(n+1)*sizeof(float));
	/*for(int i=0;i<n;i++){
		for(int j=0;j<n+1;j++)tem[i*(n+1)+j]=p[i][j];
	}*/
	LinearCopy(GetP(),N,tem,GetN());//和上面注释代码的功能一样
	PrintLine;
	cout<<"要计算的线性方程组:"<<endl;
	PrintLinear(n,tem,n);
	PrintLine;
	for(int i=0;i<n;i++){
		if(!i){
			tem2[0]=tem[0];
			tem3[0]=1;
			tem3[1]=tem[1]/tem[0];
			tem2[n]=tem[n];
		}else{
			tem2[i*(n+1)+n]=tem[i*(n+1)+n];
			tem2[i*(n+1)+(i-1)]=tem[i*(n+1)+(i-1)];
			tem2[i*(n+1)+i]=tem[(i-1)*(n+1)+(i-1)]-tem[i*(n+1)+(i-1)]*tem3[(i-1)*(n+1)+i];
			tem3[i*(n+1)+i]=1;
			if(i<n-1)tem3[i*(n+1)+i+1]=tem[i*(n+1)+i+1]/tem2[i*(n+1)+i];
		}
	}

	int flag=0;
	for(i=0;i<n-2;i++){
		for(int j=i+2;j<n;j++){
			if(tem[i*(n+1)+j]||tem[j*(n+1)+i]){
				flag=1;
				break;
			}
		}
		if(flag)break;
	}
	if(flag){
		cout<<"error:此方程不是三对角方程组:"<<endl;
		return;
	}


	PrintLine;
	cout<<"要计算的线性方程组:"<<endl;
	PrintLinear(n,tem2,n);
	PrintLine;
	LowerCal(n,tem2);
	PrintLinear(n,tem2,n);
	PrintLine;
	for(i=0;i<n;i++)tem3[i*(n+1)+n]=tem2[i*(n+1)+n]/tem2[i*(n+1)+i];
	PrintLine;
	cout<<"要计算的线性方程组:"<<endl;
	PrintLinear(n,tem3,n);
	PrintLine;
	UpperCal(n,tem3);
	PrintLinear(n,tem3,n);
	PrintLine;
	for(i=0;i<n;i++)cout<<"X"<<i+1<<"="<<tem3[i*(n+1)+n]/tem3[i*(n+1)+i]<<endl;
}

void Linear::UpperCal(int n,float *p){
	int i,j,k;
	cout<<"计算上对角矩阵:"<<endl;
	for(i=n-1;i>=1;i--){
		for(j=i-1;j>=0;j--){
			if(!p[j*(n+1)+i])continue;
			for(k=n;k>=i;k--)
				p[j*(n+1)+k]-=p[j*(n+1)+i]*p[i*(n+1)+k]/p[i*(n+1)+i];
		}
		/*PrintLine;
		cout<<"第"<<(n-i)<<"次第二种消元后得:"<<endl;
		PrintLine;
		PrintLinear(n,p,n);
		PrintLine;*/
	}
}
void Linear::LowerCal(int n,float *p){
	int i,j,k;
	cout<<"计算下对角矩阵:"<<endl;
	for(i=0;i<n-1;i++){
		for(j=i+1;j<n;j++)
		{
			if(!p[j*(n+1)+i])continue;
			for(k=n;k>=i;k--)
				p[j*(n+1)+k]-=p[i*(n+1)+k]*p[j*(n+1)+i]/p[i*(n+1)+i];
		}
		/*PrintLine;
		cout<<"第"<<i+1<<"次第二种消元后得:"<<endl;
		PrintLine;
		PrintLinear(n,p,n);
		PrintLine;*/
	}
}
void clrscr()
{
	COORD coordScreen = {0, 0}; //here's where we'll home the cursor 
	BOOL bSuccess;
	HANDLE hConsole=GetStdHandle(STD_OUTPUT_HANDLE);
	DWORD cCharsWritten;
	CONSOLE_SCREEN_BUFFER_INFO csbi;//to get buffer info 
	DWORD dwConSize; // number of character cells in the current buffer 
	// get the number of character cells in the current buffer 
	bSuccess = GetConsoleScreenBufferInfo(hConsole, &csbi);
	PERR(bSuccess,"GetConsoleScreenBufferInfo");
	dwConSize = csbi.dwSize.X * csbi.dwSize.Y;
	// fill the entire screen with blanks 
	bSuccess = FillConsoleOutputCharacter(hConsole, (TCHAR) ' ',dwConSize, coordScreen, &cCharsWritten);
	PERR(bSuccess,"FillConsoleOutputCharacter");
	// get the current text attribute 
	bSuccess = GetConsoleScreenBufferInfo(hConsole, &csbi);
	PERR(bSuccess, "ConsoleScreenBufferInfo");
	// now set the buffer's attributes accordingly 
	bSuccess = FillConsoleOutputAttribute(hConsole, csbi.wAttributes,dwConSize, coordScreen, &cCharsWritten);
	PERR(bSuccess, "FillConsoleOutputAttribute");
	// put the cursor at (0, 0) 
	bSuccess = SetConsoleCursorPosition(hConsole, coordScreen);
	PERR(bSuccess, "SetConsoleCursorPosition");
	return;
}