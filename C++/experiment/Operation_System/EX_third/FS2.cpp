#include <iostream>
#include <fstream>
#include <cstdlib>
#include <cstring>
using namespace std;

typedef struct UNode
{ // UFD���
    char FileName[12]; // �ļ���
    char ProCode[4]; // ������
    int length; // �ļ�����
    int Open_RW; // �ļ��򿪹رն�дָ��
    struct UNode *next; // ����ָ��
    struct UNode *prior; // ǰ��ָ��
}* UFD;

typedef struct MNode
{ // MDF���
    char UserName[12]; // �û���
    char Password[12]; // ����
    struct UNode *FileMenu; // �ļ�Ŀ¼ָ��
    struct MNode *next; // ����ָ��
}* MDF;

MDF H=(MDF)malloc(sizeof(MNode)); // ȫ�ֱ���,ָ��MDFͷ���(������Ϊ��)
MDF CurrUser; // ȫ�ֱ���,��ǰ�����û�ָ��

//---------------------------��������------------------------------

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

void InitSystem() // ���ļ���Ĭ��MDF��UFD��֯���������ڴ�
{
    //"InitInfo.txt" ���г�ʼ����Ϣ����д����ļ�,����δʹ���ļ���
    H->FileMenu=NULL;
    H->next=NULL;
    MDF p=H;
    int UserNum; // ��ʼ��ʱ�û��������ļ�����
    cout<<"ϵͳ��ʼ����ʼ,�������û�������: ";
    cin>>UserNum;
    for (int i=1; i<=UserNum; i++)
    {
        p=p->next=(MDF)malloc(sizeof(MNode));
        cout<<"\n������� "<<i<<" ���û����û���������: ";
        cin>>p->UserName;
        cin>>p->Password; // ��ʼ��MDF���

        p->FileMenu=InitUFD(p);
        p->next=NULL;
    }
    cout<<"\n��ʼ�����,���������������ʼ�ļ�����!\n";
    system("pause");
    char c;
    cin.get(c);
    system("cls");
}

UFD InitUFD(MDF p) //�״δ����û����ļ�
{
    UFD s,r,L=(UFD)malloc(sizeof(UNode)); // ��ʼ����ǰ�û��������ļ�UFD
    L->next=NULL;
    r=L;
    int FileNum;
    cout<<"�������û� "<<p->UserName<<" ��Ҫ�������ļ�����: ";
    cin>>FileNum;
    cout<<"�������û� "<<p->UserName<<" �������ļ���,������ͳ���: ";
    for (int j=1; j<=FileNum; j++)
    {
        s=(UFD)malloc(sizeof(UNode));
        cin>>s->FileName; //��ȡ�ļ���
        cin>>s->ProCode; // ��ȡ������
        cin>>s->length; //�ļ�����
        s->Open_RW=0;
        r->next=s;
        s->prior=r;
        r=s;
    }
    r->next=NULL; // UFD��˫����������ɾ��
    return L->next;
}

void DispMDF() // ��ʾ�û����б�
{
    cout<<"�����û����б�: ";
    MDF p=H->next;
    while (p)
    {
        cout<<"\t"<<p->UserName;
        p=p->next;
    }
    cout<<endl;
}

void DispUFD(MDF L) // ��ʾUFD��ĸ����ļ���
{
    cout<<endl<<"��ǰ�ļ���UFDΪ:\n"
        <<"   "<<L->UserName<<endl
        <<"---------\n";
    UFD p=L->FileMenu;
    if (!p)
    {
        cout<<L->UserName<<" �û����ļ�,���ڴ����ļ���? (y/n)";
        char c; cin.get(c); // Ϊ���ļ��û���һ�δ����ļ�
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

int LoginCheck() // �����û����Ƿ����
{
    char UserName[12],PassWord[12];
    while(1)
    {
        cout<<"�������û���: ";
        cin>>UserName;
        MDF p=H->next;
        while (p)
        {
            if (strcmp(UserName,p->UserName) == 0)
            {
                cout<<"�û����ҳɹ�! ����������: ";
                cin>>PassWord;
                if (strcmp(PassWord,p->Password) == 0)
                    cout<<"��¼�ɹ�!\n";
                else {
                    cout<<"������������µ�¼!\n";
                    return 0;
                }
                CurrUser=p;
                return 1;
            }
            p=p->next;
        }
        cout<<"�޴��û��ļ�!\n";
        return 0;
    }
}

void Create() // �������ļ� F
{
    char CreateName[12];
    UFD p=CurrUser->FileMenu,s;
    cout<<"������Ҫ�������ļ���: ";
    cin>>CreateName;
    while (p)
    {
        if (strcmp(CreateName,p->FileName)==0)
        {
            cout<<"���ļ��Ѿ�����,����ʧ��!\n";
            return;
        }
        p=p->next;
    }
    s=(UFD)malloc(sizeof(UNode));
    strcpy(s->FileName,CreateName);
    cout<<"������ "<<CreateName<<" �ļ��ı�����ͳ���: ";
    cin>>s->ProCode;
    cin>>s->length;
    s->Open_RW=0;
    s->prior=NULL;
    UFD r=CurrUser->FileMenu;
    CurrUser->FileMenu=s;
    s->next=r;
    r->prior=s; // ���������ļ�����ͷ�巨����UFD��ǰ��

    DispUFD(CurrUser); // ��ʾ��ǰUFD
}

void Delete() // ɾ���ļ�
{
    char FileName[12];
    cout<<"������Ҫɾ�����ļ���: ";
    cin>>FileName;
    UFD p=CurrUser->FileMenu,temp;
    if (strcmp(FileName,p->FileName)==0) // ͷ����ļ�ʱҪɾ�����ļ�
    {
        CurrUser->FileMenu=CurrUser->FileMenu->next;
        free(p);
        cout<<"�ļ�ɾ���ɹ�!\n";
        DispUFD(CurrUser); // ��ʾ��ǰUFD
        return;
    }
    while (p->next)
    {
        if (strcmp(FileName,p->next->FileName)==0)
        {
            temp=p->next;
            p->next=p->next->next;
            free(temp);
            cout<<"�ļ�ɾ���ɹ�!\n";
            DispUFD(CurrUser); // ��ʾ��ǰUFD
            return;
        }
        p=p->next;
    }
    cout<<"��Ҫɾ�����ļ�������!\n";
    DispUFD(CurrUser); // ��ʾ��ǰUFD
}

void Open() // ���ļ�
{
    char FileName[12];
    UFD p=CurrUser->FileMenu;
    cout<<"������Ҫ�򿪵��ļ���: ";
    cin>>FileName;
    
    while (p)
    {
        if (strcmp(FileName,p->FileName)==0)
        {
            if (!p->Open_RW)
            {
                cout<<"�ļ��򿪳ɹ�!\n";
                p->Open_RW=1;
            }
            else cout<<"�ļ��Ѵ�,�ظ���ʧ��!\n";
            return;
        }
        p=p->next;
    }
    cout<<"��Ҫ�򿪵��ļ�������!\n";
    DispUFD(CurrUser); // ��ʾ��ǰUFD
}

void Close() //�ر��ļ�
{
    char FileName[12];
    UFD p=CurrUser->FileMenu;
    cout<<"�Ѵ򿪵��ļ���:\n"
        <<"-----------\n";
    while (p)
    {
        if (p->Open_RW) cout<<"    "<<p->FileName<<endl;
        p=p->next;
    }
    cout<<"-----------\n";
    p=CurrUser->FileMenu;
    cout<<"������Ҫ�رյ��ļ���: ";
    cin>>FileName;
    
    while (p)
    {
        if (strcmp(FileName,p->FileName)==0)
        {
            if (p->Open_RW)
            {
                cout<<"�ļ��رճɹ�!\n";
                p->Open_RW=0;
            }
            else cout<<"�ļ�δ����,�ر�ʧ��!";
            return;
        }
        p=p->next;
    }
    cout<<"��Ҫ�رյ��ļ�������!\n";
    DispUFD(CurrUser); // ��ʾ��ǰUFD
}

void Read() // ���ļ�
{
    char FileName[12];
    UFD p=CurrUser->FileMenu;
    cout<<"�Ѵ򿪵��ļ���:\n"
        <<"-----------\n";
    while (p)
    {
        if (p->Open_RW) cout<<"    "<<p->FileName<<endl;
        p=p->next;
    }
    cout<<"-----------\n";
    p=CurrUser->FileMenu;
    cout<<"������Ҫ�����ļ���: ";
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
                    cout<<"�ļ����ɹ�!\n";
                else cout<<"�ļ��������Ͳ�������ļ�\n";    
            }
            else cout<<"���ļ�δ����,���Ƚ��д򿪲���!";
            return;
        }
        p=p->next;
    }
    cout<<"���ļ��ļ�������!\n";
    DispUFD(CurrUser); // ��ʾ��ǰUFD
}

void Write() // д�ļ�
{
    char FileName[12];
    UFD p=CurrUser->FileMenu;
    cout<<"�Ѵ򿪵��ļ���:\n"
        <<"-----------\n";
    while (p)
    {
        if (p->Open_RW) cout<<"    "<<p->FileName<<endl;
        p=p->next;
    }
    cout<<"-----------\n";
    p=CurrUser->FileMenu;
    cout<<"������Ҫд���ļ���: ";
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
                    cout<<"�ļ�д�ɹ�!\n";
                else cout<<"�ļ��������Ͳ�����д�ļ�\n";    
            }
            else cout<<"���ļ�δ����,���Ƚ��д򿪲���!";
            return;
        }
        p=p->next;
    }
    cout<<"���ļ��ļ�������!\n";
    DispUFD(CurrUser); // ��ʾ��ǰUFD
}

void Bye() // �˳�ϵͳ
{
    DispMDF();
    DispUFD(CurrUser); // ��ʾ��ǰUFD        
}

void Welcome() // ��������
{
    cout<<"\n------------File Management------------\n"
        <<"     1. Create 2. Delete 3. Open\n"
        <<"     4. Close  5. Read   6. Write\n"
        <<"          7. Bye    8. ReLogin \n"
        <<"          9. MDF    10. UFD    \n"
        <<"--------------------------------------\n"
        <<"��ѡ���������: ";
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
				Welcome(); // ��������
				cin>>choice;
				switch (choice)
				{
				case 1: Create(); break; // �������ļ�
				case 2: Delete(); break; // ɾ���ļ�
				case 3: Open(); break;   // ���ļ�
				case 4: Close(); break; // �ر��ļ�
				case 5: Read(); break;  // ���ļ�
				case 6: Write(); break; // д�ļ�
				case 7: 
					Bye(); 
					cout<<"�ѳɹ��˳�ϵͳ!\n";
					system("pause");// ��ӡMDF��UFD���˳�
				case 8:
				case 9: DispMDF(); break;
				case 10: DispUFD(CurrUser); break;
				}
			}
		}
	}
} 