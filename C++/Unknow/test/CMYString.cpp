#include<iostream>
using namespace std;

class CMYString
{
	public:
		CMYString(char *pData = NULL):m_pData(pData){};
		CMYString(const CMYString &str):m_pData(str.m_pData){};
		//CMYString(const CMYString &str):this(&str){}
		~CMYString(void){};
		CMYString& operator  = (const CMYString &str);
		void display(){cout<<m_pData<<endl;}
	private:
		char *m_pData;
};

//CMYString& CMYString::operator  = (const CMYString &str){
//	
//	if(this == &str){
//		return *this;
//	}
//
//	delete []m_pData;
//	m_pData = NULL;
//	m_pData = new char[strlen(str.m_pData) + 1];
//	strcpy(m_pData, str.m_pData);
//
//	return *this;
//
//}

CMYString& CMYString::operator = (const CMYString &str){
	if(this!=&str){
		CMYString strTemp(str);

		char *pTemp = strTemp.m_pData;
		strTemp.m_pData = m_pData;
		m_pData = pTemp;
	}
	return *this;
}

int main(){
	CMYString s("asd");
	CMYString t="123";
	CMYString r = t;
	r.display();
}