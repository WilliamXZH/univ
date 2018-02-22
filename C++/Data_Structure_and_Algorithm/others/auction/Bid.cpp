#include "Bid.h"
#include<iostream>
Bid::Bid(){ //竞标的人的信息

    this->email = "";
    this->amount = 0;
    this->quantity = 0;
    this->date = Date();

}

Bid::Bid( const Bid &b ){

    this->email = b.email;
    this->amount = b.amount;
    this->quantity = b.quantity;
    this->date = b.date;

}

Bid::Bid( string email,float amount,int quantity,Date date ){

    this->email = email;
    this->quantity = quantity;
    this->amount = amount;
    this->date = date;

}

string Bid::getEmail()const{

    return this->email;

}

float Bid::getAmount()const{

    return this->amount;

}

int Bid::getQuantity()const{

    return this->quantity;

}

Date Bid::getDate()const{

    return this->date;

}

void Bid::setEmail(const string &Email ){

    this->email = Email;

}

void Bid::setAmount( const float &Amount ){

    this->amount = Amount;

}

void Bid::setQuantity( const int &Quantity ){

    this->quantity = Quantity;

}

void Bid::setDate( const Date &date ){

    this->date = date;

}

bool Bid::operator<( const Bid &rhs ) const{

    if( this->amount < rhs.amount ){

        return true;

    }
    return false;

}

bool Bid::operator==( const Bid &rhs ) const{

    if( this->amount == rhs.amount ){

        return true;

    }
    return false;

}

istream &operator>>(istream &stream, Bid &b){

    string email;
    float amount;
    int quantity;
    Date date;
    stream >> email >> amount >> quantity >> date;
    b = Bid( email,amount,quantity,date );
    return stream;

}
