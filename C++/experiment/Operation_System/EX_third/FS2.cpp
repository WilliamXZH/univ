#include <iostream>
#include <fstream>
#include <cstdlib>
#include <cstring>
using namespace std;

typedef struct UNode
{ // UFD结点
    char FileName[12]; // 文件名
    char ProCode[4]; // 保护码
    int length; // 文件长度
    int Open_RW; // 文件打开关闭读写指针
    struct UNode *next; // 后向指针
    struct UNode *prior; // 前向指针
}* UFD;

typedef struct MNode
{ // MDF结点
    char UserName[12]; // 用户名
    char Password[12]; // 密码
    struct UNode *FileMenu; // 文件目录指针
    struct MNode *next; // 后向指针
}* MDF;

MDF H=(MDF)malloc(sizeof(MNode)); // 全局变量,指向MDF头结点(数据项为空)
MDF CurrUser; // 全局变量,当前操作用户指针

//---------------------------函数声明------------------------------

void Welcome(); 
void InitSystem(); 
UFD InitUFD(MDF p); 
void DispMDF(); 
void DispMDF(); 
void DispUFD(MDF L);
int LoginCheck(); 
void Create(); 
void Delete(); 
void Open();   
void Close(); 
void Read();  
void Write();
void Bye(); 

//-----------------------------------------------------------------

void InitSystem() // 从文件将默认MDF和UFD组织起来进入内存
{
    //"InitInfo.txt" 所有初始化信息都已写入该文件,这里未使用文件流
    H->FileMenu=NULL;
    H->next=NULL;
    MDF p=H;
    int UserNum; // 初始化时用户个数和文件个数
    cout<<"系统初始化开始,请输入用户名个数: ";
    cin>>UserNum;
    for (int i=1; i<=UserNum; i++)
    {
        p=p->next=(MDF)malloc(sizeof(MNode));
        cout<<"\n请输入第 "<<i<<" 个用户的用户名和密码: ";
        cin>>p->UserName;
        cin>>p->Password; // 初始化MDF结点

        p->FileMenu=InitUFD(p);
        p->next=NULL;
    }
    cout<<"\n初始化完毕,按任意键清屏并开始文件管理!\n";
    system("pause");
    char c;
    cin.get(c);
    system("cls");
}

UFD InitUFD(MDF p) //首次创建用户的文件
{
    UFD s,r,L=(UFD)malloc(sizeof(UNode)); // 初始化当前用户的所有文件UFD
    L->next=NULL;
    r=L;
    int FileNum;
    cout<<"请输入用户 "<<p->UserName<<" 将要创建的文件个数: ";
    cin>>FileNum;
    cout<<"请输入用户 "<<p->UserName<<" 的所有文件名,保护码和长度: ";
    for (int j=1; j<=FileNum; j++)
    {
        s=(UFD)malloc(sizeof(UNode));
        cin>>s->FileName; //读取文件名
        cin>>s->ProCode; // 读取保护码
        cin>>s->length; //文件长度
        s->Open_RW=0;
        r->next=s;
        s->prior=r;
        r=s;
    }
    r->next=NULL; // UFD是双向链表，便于删除
    return L->next;
}

void DispMDF() // 显示用户名列表
{
    cout<<"现有用户名列表: ";
    MDF p=H->next;
    while (p)
    {
        cout<<"\t"<<p->UserName;
        p=p->next;
    }
    cout<<endl;
}

void DispUFD(MDF L) // 显示UFD里的各个文件名
{
    cout<<endl<<"当前文件的UFD为:\n"
        <<"   "<<L->UserName<<endl
        <<"---------\n";
    UFD p=L->FileMenu;
    if (!p)
    {
        cout<<L->UserName<<" 用户无文件,现在创建文件吗? (y/n)";
        char c; cin.get(c); // 为无文件用户第一次创建文件
        if (c=='y') L->FileMenu=InitUFD(L);
        else return;
    }
    while (p)
    {
        cout<<"   "<<p->FileName<<endl;
        p=p->next;
    }
    cout<<"---------\n";
}

int LoginCheck() // 搜索用户名是否存在
{
    char UserName[12],PassWord[12];
    while(1)
    {
        cout<<"请输入用户名: ";
        cin>>UserName;
        MDF p=H->next;
        while (p)
        {
            if (strcmp(UserName,p->UserName) == 0)
            {
                cout<<"用户查找成功! 请输入密码: ";
                cin>>PassWord;
                if (strcmp(PassWord,p->Password) == 0)
                    cout<<"登录成功!\n";
                else {
                    cout<<"密码错误请重新登录!\n";
                    return 0;
                }
                CurrUser=p;
                return 1;
            }
            p=p->next;
        }
        cout<<"无此用户文件!\n";
        return 0;
    }
}

void Create() // 创建新文件 F
{
    char CreateName[12];
    UFD p=CurrUser->FileMenu,s;
    cout<<"请输入要创建的文件名: ";
    cin>>CreateName;
    while (p)
    {
        if (strcmp(CreateName,p->FileName)==0)
        {
            cout<<"此文件已经存在,创建失败!\n";
            return;
        }
        p=p->next;
    }
    s=(UFD)malloc(sizeof(UNode));
    strcpy(s->FileName,CreateName);
    cout<<"请输入 "<<CreateName<<" 文件的保护码和长度: ";
    cin>>s->ProCode;
    cin>>s->length;
    s->Open_RW=0;
    s->prior=NULL;
    UFD r=CurrUser->FileMenu;
    CurrUser->FileMenu=s;
    s->next=r;
    r->prior=s; // 创建的新文件采用头插法置于UFD最前端

    DispUFD(CurrUser); // 显示当前UFD
}

void Delete() // 删除文件
{
    char FileName[12];
    cout<<"请输入要删除的文件名: ";
    cin>>FileName;
    UFD p=CurrUser->FileMenu,temp;
    if (strcmp(FileName,p->FileName)==0) // 头结点文件时要删除的文件
    {
        CurrUser->FileMenu=CurrUser->FileMenu->next;
        free(p);
        cout<<"文件删除成功!\n";
        DispUFD(CurrUser); // 显示当前UFD
        return;
    }
    while (p->next)
    {
        if (strcmp(FileName,p->next->FileName)==0)
        {
            temp=p->next;
            p->next=p->next->next;
            free(temp);
            cout<<"文件删除成功!\n";
            DispUFD(CurrUser); // 显示当前UFD
            return;
        }
        p=p->next;
    }
    cout<<"您要删除的文件不存在!\n";
    DispUFD(CurrUser); // 显示当前UFD
}

void Open() // 打开文件
{
    char FileName[12];
    UFD p=CurrUser->FileMenu;
    cout<<"请输入要打开的文件名: ";
    cin>>FileName;
    
    while (p)
    {
        if (strcmp(FileName,p->FileName)==0)
        {
            if (!p->Open_RW)
            {
                cout<<"文件打开成功!\n";
                p->Open_RW=1;
            }
            else cout<<"文件已打开,重复打开失败!\n";
            return;
        }
        p=p->next;
    }
    cout<<"您要打开的文件不存在!\n";
    DispUFD(CurrUser); // 显示当前UFD
}

void Close() //关闭文件
{
    char FileName[12];
    UFD p=CurrUser->FileMenu;
    cout<<"已打开的文件有:\n"
        <<"-----------\n";
    while (p)
    {
        if (p->Open_RW) cout<<"    "<<p->FileName<<endl;
        p=p->next;
    }
    cout<<"-----------\n";
    p=CurrUser->FileMenu;
    cout<<"请输入要关闭的文件名: ";
    cin>>FileName;
    
    while (p)
    {
        if (strcmp(FileName,p->FileName)==0)
        {
            if (p->Open_RW)
            {
                cout<<"文件关闭成功!\n";
                p->Open_RW=0;
            }
            else cout<<"文件未被打开,关闭失败!";
            return;
        }
        p=p->next;
    }
    cout<<"您要关闭的文件不存在!\n";
    DispUFD(CurrUser); // 显示当前UFD
}

void Read() // 读文件
{
    char FileName[12];
    UFD p=CurrUser->FileMenu;
    cout<<"已打开的文件有:\n"
        <<"-----------\n";
    while (p)
    {
        if (p->Open_RW) cout<<"    "<<p->FileName<<endl;
        p=p->next;
    }
    cout<<"-----------\n";
    p=CurrUser->FileMenu;
    cout<<"请输入要读的文件名: ";
    cin>>FileName;
    
    while (p)
    {
        if (strcmp(FileName,p->FileName) == 0)
        {
            if (p->Open_RW)
            {
                if (strcmp("111",p->ProCode)==0 ||
                    strcmp("110",p->ProCode)==0 ||
                    strcmp("101",p->ProCode)==0 ||
                    strcmp("100",p->ProCode)==0 )
                    cout<<"文件读成功!\n";
                else cout<<"文件保护类型不允许读文件\n";    
            }
            else cout<<"该文件未被打开,请先进行打开操作!";
            return;
        }
        p=p->next;
    }
    cout<<"该文件文件不存在!\n";
    DispUFD(CurrUser); // 显示当前UFD
}

void Write() // 写文件
{
    char FileName[12];
    UFD p=CurrUser->FileMenu;
    cout<<"已打开的文件有:\n"
        <<"-----------\n";
    while (p)
    {
        if (p->Open_RW) cout<<"    "<<p->FileName<<endl;
        p=p->next;
    }
    cout<<"-----------\n";
    p=CurrUser->FileMenu;
    cout<<"请输入要写的文件名: ";
    cin>>FileName;
    
    while (p)
    {
        if (strcmp(FileName,p->FileName) == 0)
        {
            if (p->Open_RW)
            {
                if (strcmp("010",p->ProCode)==0 ||
                    strcmp("110",p->ProCode)==0 ||
                    strcmp("111",p->ProCode)==0 ||
                    strcmp("011",p->ProCode)==0 )
                    cout<<"文件写成功!\n";
                else cout<<"文件保护类型不允许写文件\n";    
            }
            else cout<<"该文件未被打开,请先进行打开操作!";
            return;
        }
        p=p->next;
    }
    cout<<"该文件文件不存在!\n";
    DispUFD(CurrUser); // 显示当前UFD
}

void Bye() // 退出系统
{
    DispMDF();
    DispUFD(CurrUser); // 显示当前UFD        
}

void Welcome() // 操作界面
{
    cout<<"\n------------File Management------------\n"
        <<"     1. Create 2. Delete 3. Open\n"
        <<"     4. Close  5. Read   6. Write\n"
        <<"          7. Bye    8. ReLogin \n"
        <<"          9. MDF    10. UFD    \n"
        <<"--------------------------------------\n"
        <<"请选择操作命令: ";
}

void main()
{
    InitSystem();
    int choice;
	while(1){
		if (LoginCheck())
		{
			while (1)
			{
				Welcome(); // 操作界面
				cin>>choice;
				switch (choice)
				{
				case 1: Create(); break; // 创建新文件
				case 2: Delete(); break; // 删除文件
				case 3: Open(); break;   // 打开文件
				case 4: Close(); break; // 关闭文件
				case 5: Read(); break;  // 读文件
				case 6: Write(); break; // 写文件
				case 7: 
					Bye(); 
					cout<<"已成功退出系统!\n";
					system("pause");// 打印MDF和UFD表并退出
				case 8:
				case 9: DispMDF(); break;
				case 10: DispUFD(CurrUser); break;
				}
			}
		}
	}
} 