#include"Client.h"
#include<string.h>
#include <iostream.h>
Client::Client(){
    fname="A";
    lname"B";
    email="***@**.com";
    passwd="nopass";
}
Client::Client(Client const &c)
{
    fname=a.
}
 Client::Client(string &f, string &l, string &e, string &p)
 {
     fname=f;
     lname=l;
     email=e;
     passwd=p;
 }
 string Client::getFname () const{
 return fname;
 }
    string Client::getLname () const{
    return lname;
    }
    string Client::getEmail () const{
        return email;
    }
	string Client::getPasswd () const{
	return passwd;
	}
	 void Clien::setFname(const string&a){
	 strcpy(fname,a);
	 }
	 void Client::setLname(const string&a){
	 strcpy(lname,a);
	 }
	 void setEmail(const string&a){
	 strcpy(email,a);
         }
	void setPasswd(const string&a){
	strcpy(passwd,a);
	}
    bool Client::verifyPasswd(string passwd)
    {
        if(strcmp(this.getPasswd,passwd)==0)
        return true;
        else
        return false;
    }
istream &operator>>(istream &stream, Client &c){
 char f[10],l[10],p[10],e[10];
 stream>>f>>l>>e>>p;
 c.setEmail(e);
 c.setFname(f);
 c.setLname(l);
 c.setPasswd(p);
 return istream;
}
