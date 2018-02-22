#include "Advertisement.h"
#include<iostream>
#include<cstring>
Advertisement::Advertisement(){

    this->number = 0;
    this->quantity = 0;
    this->title = "";
    this->seller_email = "";
    this->body = "";
    start = Date();
    close = Date();

}

Advertisement::Advertisement( const Advertisement &a ){

    this->number = a.getNumber();
    this->quantity = a.getQuantity();
    this->title = a.getTitle();
    this->seller_email = a.getEmail();
    this->body = a.getBody();
    this->start = a.getStart();
    this->close = a.getClose();

}

Advertisement::Advertisement( string title, string seller_email, string body,
                   Date start, Date close, int quantity){
    this->quantity = quantity;
    this->title = title;
    this->seller_email = seller_email;
    this->body = body;
    this->start = start;
    this->close = close;

}

void Advertisement::setStart( const Date &start ) {

    this->start = start;

}

void Advertisement::setClose (const Date &close){

    this->close = close;

}

void Advertisement::setTitle (const string title ){

    this->title = title;

}

void Advertisement::setBody(string body){

    this->body = body;

}

void Advertisement::setNumber(int number){

    this->number = number;

}

void Advertisement::setEmail(string email){

    this->seller_email = email;

}

void Advertisement::setQuantity( int quantity ){

    this->quantity = quantity;

}

Date Advertisement::getStart() const{

    return this->start;

}

Date Advertisement::getClose() const{

    return this->close;

}

string Advertisement::getTitle() const{

    return this->title;

}

string Advertisement::getBody() const{

    return this->body;

}

string Advertisement::getEmail() const{

    return this->seller_email;

}

int Advertisement::getNumber() const{

    return this->number;

}

int Advertisement::getQuantity() const{

    return this->quantity;

}

bool Advertisement::operator==( const Advertisement& ad ) const{

    if( this->getNumber() == ad.getNumber() ){

        return true;

    }
    return false;

}

istream &operator>>(istream &stream, Advertisement &a){

    string title,email,body;
    Date start_date,close_date;
    int quantity;
    stream >> title >> email >> quantity >> start_date >> close_date >> body;
    a = Advertisement( title,email,body,start_date,close_date,quantity );
    return stream;

}

priority_queue<Bid>& Advertisement::getBids( void ){

    return this->bids;

}

vector<Bid> Advertisement::getTopDutchBids( void )const{//返回获得竞标的人

    int comp = this->getQuantity();
    vector<Bid> the_winner;
    the_winner.clear();
    priority_queue<Bid> the_Bider = this->bids;

    while( comp != 0 && !the_Bider.empty() ){

        if( comp >= the_Bider.top().getQuantity() ){

            the_winner.push_back( the_Bider.top() );
            comp = comp - the_Bider.top().getQuantity();
            the_Bider.pop();

        }else if( !the_Bider.empty() ){

            the_Bider.pop();
        }
    }
    return the_winner;

}
