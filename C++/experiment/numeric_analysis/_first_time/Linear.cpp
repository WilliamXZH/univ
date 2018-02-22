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
		void PrintLinear();//����/����������
		void PrintLinear(int n,float *p,int m);
		void PrintLinear(int m,int n,float *p,int l);
		void LinearBuilder(float *origin,int l);//������
		void LinearCopy(float *origin,int l,float *target,int m);//���󿽱�
		void LinearCopy(float *origin,int k,int l,float *target,int m,int n);
		void GaussSeq(int order=0);//˳����ȥ��
		void GaussCol();//����Ԫ��ȥ��
		void SquRoot();//ƽ������
		void SquRootImp();//�Ľ�ƽ������
		void ChaMet();//׷�Ϸ�
		void UpperCal(int n,float *p);//�����Ǿ���ļ���
		void LowerCal(int n,float *p);//�����Ǿ���ļ���
		
		void LineGene(int n,float *p);//һ�㷽����Ľ���
		void LineSym(int n,float *p);//�Գ�����������Ľ���
		void LineThDia(int n,float *p);//���ԽǷ�����Ľ���
		void LinearBuilder_root();//�����齨���ĸ�Ŀ¼/�˵�
		void DirectMet_root();//������ֱ���㷨�ĸ�Ŀ¼/�˵�
		void ExSample();//ֱ�ӽ�����������ķ�����Ĳ˵�
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
		cout<<"*1.����/�������Է�����*"<<endl;
		cout<<"*2.ֱ�ӷ�����ⷽ���� *"<<endl;
		cout<<"*3.��ӡ���Է�����     *"<<endl;
		cout<<"*4.ʵ������           *"<<endl;
		cout<<"*0.�˳�               *"<<endl;
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
				break;//��Ч����
			default:
				cout<<"������Ч������������";
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
	cout<<"*1.��һ��            *"<<endl;
	cout<<"*2.�ڶ���            *"<<endl;
	cout<<"*3.������            *"<<endl;
	cout<<"*0.����              *"<<endl;
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
			cout<<"�����������������:"<<endl;
	}
}
void Linear::DirectMet_root(){
	while(1){
		char choose;
		cout<<"**********************"<<endl;
		cout<<"*1.��˹��ȥ��        *"<<endl;
		cout<<"*2.����Ԫ��˹��ȥ��  *"<<endl;
		cout<<"*3.ƽ������          *"<<endl;
		cout<<"*4.׷�Ϸ�            *"<<endl;
		cout<<"*0.����              *"<<endl;
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
				break;//��Ч����
			default:
				cout<<"������Ч������������";
				continue;
		}
	}
}
void Linear::LinearBuilder_root(){
	int i,n;
	float *p;
	cout<<"�������Է�����Ĵ�С(����):"<<endl;
	cin>>n;
	cout<<"�����ڴ濪ʼ:"<<endl;
	p=(float*)malloc(n*(n+1)*sizeof(float));
	memset(p,0,n*(n+1)*sizeof(float));
	char choose;
	cout<<"**********************"<<endl;
	cout<<"*1.һ�����Է�����    *"<<endl;
	cout<<"*2.�Գ��������Է�����*"<<endl;
	cout<<"*3.���Խ����Է�����  *"<<endl;
	cout<<"*0.����              *"<<endl;
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
	cout<<"һ�����Է�����:"<<endl;
	for(int j,i=0;i<n;i++)
	{
		cout<<"��"<<(i+1)<<"��"<<(n+1)<<"����"<<endl;
		for(j=0;j<n+1;j++)cin>>p[i*(n+1)+j];
	}
}
void Linear::LineSym(int n,float *p){
	cout<<"�Գ��������Է�����:"<<endl;
	for(int j,i=0;i<n;i++){
		cout<<"��"<<i+1<<"��"<<i+2<<"����"<<endl;
		for(j=0;j<i;j++){cin>>p[i*(n+1)+j];p[j*(n+1)+i]=p[i*(n+1)+j];}
		cin>>p[i*(n+1)+n];
	}
}
void Linear::LineThDia(int n,float *p){
	/*int temp,flag;
	cout<<"���Խ����Է�����"<<endl;
	for(int j,i=0;i<n;i++){
		if(i==0||i==n-1)temp=2;
		else temp=3;
		if(i==1)flag=1;
		else flag=0;
		for(j=0;j<temp;j++)cin>>p[i*(n+1)+i+j-flag];
	}*/
	cout<<"����a1~an:"<<endl;
	for(int i=0;i<n;i++)cin>>p[i*(n+1)+i];
	cout<<"����b1~bn:"<<endl;
	for(i=0;i<n;i++)cin>>p[i*(n+1)+n];
	cout<<"����c1~cn-1:"<<endl;
	for(i=0;i<n-1;i++)cin>>p[i*(n+1)+(i+1)];
	cout<<"����d1~dn:"<<endl;
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
	cout<<"Ҫ��������Է�����"<<endl;
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
				cout<<"����Ԫ��"<<endl;
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
		cout<<"��"<<(i+1)<<"�ε�һ����Ԫ���:"<<endl;
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
		cout<<"��"<<(n-i)<<"�εڶ�����Ԫ���:"<<endl;
		PrintLine;
		PrintLinear(n,tem,n);
		PrintLine;
	}
	PrintLine;
	cout<<"����L:"<<endl;
	PrintLine;
	PrintLinear(n,n,tem2,n);
	PrintLine;
	cout<<"����U:"<<endl;
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
	cout<<"Ҫ��������Է�����:"<<endl;
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
		cout<<"error:�����Է����鲻�ǶԳ�����������"<<endl;
		return;
	}

	PrintLine;
	cout<<"����ľ���Gy=b:"<<endl;
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
		cout<<"��"<<i+1<<"�ε�һ����Ԫ���:"<<endl;
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
		cout<<"��"<<(n-i)<<"�εڶ�����Ԫ���:"<<endl;
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
	LinearCopy(GetP(),N,tem,GetN());//������ע�ʹ���Ĺ���һ��
	PrintLine;
	cout<<"Ҫ��������Է�����:"<<endl;
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
		cout<<"error:�˷��̲������ԽǷ�����:"<<endl;
		return;
	}


	PrintLine;
	cout<<"Ҫ��������Է�����:"<<endl;
	PrintLinear(n,tem2,n);
	PrintLine;
	LowerCal(n,tem2);
	PrintLinear(n,tem2,n);
	PrintLine;
	for(i=0;i<n;i++)tem3[i*(n+1)+n]=tem2[i*(n+1)+n]/tem2[i*(n+1)+i];
	PrintLine;
	cout<<"Ҫ��������Է�����:"<<endl;
	PrintLinear(n,tem3,n);
	PrintLine;
	UpperCal(n,tem3);
	PrintLinear(n,tem3,n);
	PrintLine;
	for(i=0;i<n;i++)cout<<"X"<<i+1<<"="<<tem3[i*(n+1)+n]/tem3[i*(n+1)+i]<<endl;
}

void Linear::UpperCal(int n,float *p){
	int i,j,k;
	cout<<"�����϶ԽǾ���:"<<endl;
	for(i=n-1;i>=1;i--){
		for(j=i-1;j>=0;j--){
			if(!p[j*(n+1)+i])continue;
			for(k=n;k>=i;k--)
				p[j*(n+1)+k]-=p[j*(n+1)+i]*p[i*(n+1)+k]/p[i*(n+1)+i];
		}
		/*PrintLine;
		cout<<"��"<<(n-i)<<"�εڶ�����Ԫ���:"<<endl;
		PrintLine;
		PrintLinear(n,p,n);
		PrintLine;*/
	}
}
void Linear::LowerCal(int n,float *p){
	int i,j,k;
	cout<<"�����¶ԽǾ���:"<<endl;
	for(i=0;i<n-1;i++){
		for(j=i+1;j<n;j++)
		{
			if(!p[j*(n+1)+i])continue;
			for(k=n;k>=i;k--)
				p[j*(n+1)+k]-=p[i*(n+1)+k]*p[j*(n+1)+i]/p[i*(n+1)+i];
		}
		/*PrintLine;
		cout<<"��"<<i+1<<"�εڶ�����Ԫ���:"<<endl;
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