#include<string>
#include<VECTOR>
using namespace std;

class adver;
ostream & operator<<(ostream &os,const adver &ad);
istream & operator>>(istream &is,const adver &ad);
class adver{
private:
	int amount;
	string name;
	string mail;
public:

	int getAmount(){return this->amount;}
	string getName(){return this->name;}
	string getMail(){return this->mail;}
	void setAmount(int a){this->amount=a;}
	void setName(string nm){this->name=nm;}
	void setMail(string ml){this->mail=ml;}

	adver(int a,string nm,string ml);
	adver(adver &ad);

	friend ostream & operator<<(ostream &os,const adver &ad);
	friend istream & operator>>(istream &is,adver &ad);

	adver *next;
};

ostream & operator<<(ostream &os,const adver &ad){
	os<<ad.name<<"\n";
	os<<ad.amount<<"\n";
	os<<ad.mail;

	return os;
}
istream & operator>>(istream &is,adver &ad){
	
	char *n=new char[20];
	char *m=new char[20];
	int a;
	is>>n>>a>>m;
	ad.setName(n);
	ad.setAmount(a);
	ad.setMail(m);
	//cin>>ad.name>>ad.amount>>ad.mail;

	return is;
}

adver::adver(int a,string nm,string ml):
amount(a),name(nm),mail(ml){
/*	this->setAmount(a);
	this->setName(nm);
	this->setMail(ml);*/
}
adver::adver(adver &ad):
amount(ad.amount),name(ad.name),mail(ad.mail){
	//adver(ad.getAmount(),ad.getName(),ad.getMail());
}

class merge{
private:
	vector<adver> ads;
public:
	void readFile(string filename);
	void writeFile(string filename);

	void sortByMerger();
};

void merge::readFile(string filename){

	ifstream fin(filename.c_str());

	while(!fin.eof()){
		int a;
		string nm,ml;
		fin>>nm>>a>>ml;
		adver ad=adver(a,nm,ml);
		ads.push_back(ad);
		cout<<ads[ads.size()-1]<<endl;
	}
}
void merge::writeFile(string filename){

}