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
		cout<<"*1.����/�������Է�����*"<<endl;
		cout<<"*2.ֱ�ӷ�����ⷽ���� *"<<endl;
		cout<<"*3.��ӡ���Է�����     *"<<endl;
		cout<<"*0.�˳�               *"<<endl;
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
				break;//��Ч����
			default:
				cout<<"������Ч������������";
				continue;
		}
	}
}
int LinearBuilder_root(Linear line){
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
			return 0;
			break;
		default:
			break;
	}
	return n;
}
void LineGene(int n,float *p){
	cout<<"һ�����Է�����:"<<endl;
	for(int j,i=0;i<n;i++)
	{
		cout<<"��"<<(i+1)<<"��"<<(n+1)<<"����"<<endl;
		for(j=0;j<n+1;j++)cin>>p[i*(n+1)+j];
	}
}
void LineSym(int n,float *p){
	cout<<"�Գ��������Է�����:"<<endl;
	for(int j,i=0;i<n;i++){
		cout<<"��"<<i+1<<"��"<<i+2<<"����"<<endl;
		for(j=0;j<i;j++)cin>>p[i*(n+1)+j];
		cin>>p[i*(n+1)+n];
	}
}
void LineThDia(int n,float *p){
	int temp,flag;
	cout<<"���Խ����Է�����"<<endl;
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