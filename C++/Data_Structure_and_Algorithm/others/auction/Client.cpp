#include "Client.h"

Client::Client(){

    this->fname = "";
    this->lname = "";
    this->email = "";
    this->passwd = "";

}

Client::Client( Client const &c ){

    this->fname = c.fname;
    this->lname = c.lname;
    this->email = c.email;
    this->passwd = c.passwd;

}

Client::Client( string &fname, string &lname, string &email, string &passwd ){

    this->fname = fname;
    this->lname = lname;
    this->email = email;
    this->passwd = passwd;

}

void Client::setFname(const string& Fname){

    this->fname = Fname;

}

void Client::setLname(const string& Lname){

    this->lname = Lname;

}

void Client::setEmail(const string& Email){

    this->email = Email;

}

void Client::setPasswd(const string& Passwd){

    this->passwd = Passwd;

}

string Client::getFname () const{

    return this->fname;

}

string Client::getLname () const{

    return this->lname;

}

string Client::getEmail () const{

    return this->email;

}

string Client::getPasswd () const{

    return this->passwd;

}

bool Client::verifyPasswd( string passwd ){

    if( this->getPasswd() == passwd ){

        return true;

    }
    return false;

}

istream &operator>>(istream &stream, Client &c){

    string fname,lname,email,passwd;
    stream >> fname >> lname >> email >> passwd;
    c = Client( fname,lname,email,passwd );
    return stream;

}

vector<int>::iterator Client::beginOfferings(){

    return this->offerings.begin();

}

vector<int>::iterator Client::endOfferings(){

    return this->offerings.end();

}

vector<int>::iterator Client::beginBids(){

    return this->bids.begin();

}

vector<int>::iterator Client::endBids(){

    return this->bids.end();

}

void Client::addBid(int item){

    this->bids.push_back( item );
}

void Client::addOffering(int item){

    this->bids.push_back( item );

}
