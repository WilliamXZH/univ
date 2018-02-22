#ifndef CLIENT_H
#define CLIENT_H

#include <string>
#include <vector>
#include "Date.h"

using namespace std;

class Client;

istream &operator>>(istream &stream, Client &c);

class Client {

  private:

    string fname;
    string lname;
    string email;
    string passwd;

  public:
  
    Client(void);
    Client(Client const &c);
    Client (string &fname, string &lname, string &email, string &passwd);

	virtual void setFname(const string&);
	virtual void setLname(const string&);
	virtual void setEmail(const string&);
	virtual void setPasswd(const string&);

    virtual string getFname () const;
    virtual string getLname () const;
    virtual string getEmail () const;
	virtual string getPasswd () const;

    virtual bool verifyPasswd(string passwd);

};

#endif
