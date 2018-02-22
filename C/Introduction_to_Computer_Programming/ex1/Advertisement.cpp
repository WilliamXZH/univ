#include "Date.h"
#include <iostream>
#include <string.h>
#include "Advertisement.h"
Advertisement::Advertisement(){
number=1;
quantity=1;
title="defalut";
seller_email="defalt@**.com";
body="nothing";
close=Date();
start=Date();
}
Advertisement::Advertisement(const Advertisement &a)
{
    number=a.getNumber();
    quantity=a.getQuantity();
    title=a.getTitle();
    seller_email=a.getEmail();
    body=a.getBody();
    close=a.getClose();
    start=a.getStart();
}
Advertisement::Advertisement(string t, string email, string b,Date s, Date c, int q)
{
    title=t;
    seller_email=email;
    body=b;
    start=s;
    close=c;
    quantity=q;
}
void Advertisement::setStart (const Date &s){
    start=s;
}
void Advertisement::setClose (const Date &cl)
{
    close=cl;
}
void Advertisement::setTitle (string t)
{
    title=t;
}
void Advertisement::setBody (string b)
{
    body=b;
}
void Advertisement::setNumber (int n)
{
    number=n;
}
Date Advertisement::getStart () const
{
    return start;
}
void Advertisement::setEmail (string e)
{
    seller_email=e;
}
void Advertisement::setQuantity (int q)
{
    quantity=q;
}
Date Advertisement::getClose () const
{
    return close;
}
string Advertisement:: getTitle() const //title;string seller_email; string body
{
    return title;
}
 string Advertisement::getBody() const
 {
     return body;
 }
 string Advertisement::getEmail() const
 {
     return seller_email;
 }
 int Advertisement::getNumber () const
 {
     return number;
 }
 int Advertisement::getQuantity() const
 {
     return quantity;
 }
 bool Advertisement::operator==(const Advertisement&a) const
 {
     return number==a.getNumber();
 }
 istream &operator>>(istream &stream, Advertisement &a)
 {

    char t[10],e[10],b[10];
    int quantity;
    Date start_date,close_date;
    stream>>t>>e>>quantity>>start_date>>close_date>>b;
    a.setEmail(e);
    a.setTitle(t);
    a.setQuantity(quantity);
    a.setBody(b);
    a.setStart(start_date);
    a.setClose(close_date);
    return stream;
 }
