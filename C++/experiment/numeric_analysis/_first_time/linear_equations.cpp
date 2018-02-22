#include<windows.h>
#define PERR(bSuccess, api) {if(!(bSuccess)) printf("%s:Error %d from %s \on line %d\n", __FILE__, GetLastError(), api, __LINE__);}
void clrscr();
void LineGene(int n,float *p);
void LineSym(int n,float *p);
void LineThDia(int n,float *p);
int LinearBuilder_root(Linear line);

int main(){
	Linear line;
	while(1){
		char choose,flag=0;
		cout<<"***********************"<<endl;
		cout<<"*1.建立/更改线性方程组*"<<endl;
		cout<<"*2.直接方法求解方程组 *"<<endl;
		cout<<"*3.打印线性方程组     *"<<endl;
		cout<<"*0.退出               *"<<endl;
		cout<<"***********************"<<endl;
		cin>>choose;
		switch(choose){
			case '1':
			//	LinearBuilder_root(line);
				break;
			case '2':
				break;
			case '3':
			//	line.PrintLinear();
				break;
			case '0':
				flag=1;
				return 0;
				break;//无效代码
			default:
				cout<<"输入无效，请重新输入";
				continue;
		}
	}
}
int LinearBuilder_root(Linear line){
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
			return 0;
			break;
		default:
			break;
	}
	return n;
}
void LineGene(int n,float *p){
	cout<<"一般线性方程组:"<<endl;
	for(int j,i=0;i<n;i++)
	{
		cout<<"第"<<(i+1)<<"行"<<(n+1)<<"个数"<<endl;
		for(j=0;j<n+1;j++)cin>>p[i*(n+1)+j];
	}
}
void LineSym(int n,float *p){
	cout<<"对称正定线性方程组:"<<endl;
	for(int j,i=0;i<n;i++){
		cout<<"第"<<i+1<<"行"<<i+2<<"个数"<<endl;
		for(j=0;j<i;j++)cin>>p[i*(n+1)+j];
		cin>>p[i*(n+1)+n];
	}
}
void LineThDia(int n,float *p){
	int temp,flag;
	cout<<"三对角线性方程组"<<endl;
	for(int j,i=0;i<n;i++){
		if(i==0||i==n-1)temp=2;
		else temp=3;
		if(i==1)flag=1;
		else flag=0;
		for(j=0;j<temp;j++)cin>>p[i*(n+1)+i+j-flag];
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