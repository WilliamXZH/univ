#include"Client.h"
#include<string.h>
#include <iostream>
Client::Client(void){
}
Client::Client(Client const &c)
{
    fname=c.fname;
    lname=c.lname;
    passwd=c.passwd;
    email=c.email;
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
	 void Client::setFname(const string&a){
	     fname=a;
	 }
	 void Client::setLname(const string&a){
	 lname=a;
	 }
	 void Client::setEmail(const string&a){
	 email=a;
         }
	void Client::setPasswd(const string&a){
	passwd=a;
	}
    bool Client::verifyPasswd(string passwd)
    {
        if(this->getPasswd()==passwd)
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
 return stream;
}
