#include "Date.h"
#include <iostream>
#include <string.h>
#include <stdlib.h>
Date::Date()
{
year=0;
month=0;
day=0;
hour=0;
minute=0;
second=0;
}
Date::Date(int m, int d, int y, int h, int min, int s)
{
    month=m;
    day=d;
    year=y;
    hour=h;
    minute=min;
    second=s;
}
void Date::setMonth(int& a){
    month=a;
}
void Date::setDay(int&a){
    day=a;
}
void Date::setYear(int&a){
year=a;
}
void Date::setHour(int&a){
hour=a;}
void Date::setMinute(int&a){
minute=a;}
void Date::setSecond(int&a){
second=a;}
int Date::getYear() const
{
 return year;
}
int Date::getDay() const{
return day;
}
int Date::getMonth() const{
return month;
}
int Date::getMinute() const{
return minute;
}
int Date::getHour() const{
return hour;
}
int Date::getSecond() const{
return second;
}
bool Date::operator == (const Date &rhs){
if(year==rhs.getYear()&&month==rhs.getMonth()&&day==rhs.getDay()&&hour==rhs.getHour()&&minute==rhs.getMinute()&&second==rhs.getSecond())
    return true;
}
bool Date::operator< (const Date &rhs){
if(year>rhs.getYear())
    return false;
else if(year<rhs.getYear())
    return true;
else{
     if(month>rhs.getMonth())
            return false;
     else if (month<rhs.getMonth())
        return true;
     else{
        if(day>rhs.getDay())
            return false;
        else if(day<rhs.getDay())
            return true;
        else{
            if(hour>rhs.getHour())
                return false;
            else if (hour<rhs.getHour())
                return true;
            else{
                if(minute>rhs.getMinute())
                    return false;
                else if (minute<rhs.getMinute())
                    return true;
                else{
                    if(second>rhs.getSecond())
                        return false;
                    else
                        return true;
                }
            }
        }
     }
    }
}
ostream &operator<<(ostream& out, const Date&date)
{
    out<<date.getDay()<<"/"<<date.getMonth()<<"/"<<date.getYear()<<" "<<date.getHour()<<":"<<date.getMinute()<<":"<<date.getSecond();
    return out;
}
istream &operator>>(istream& in, Date&date)
{
    char temp[10];
    in.getline(temp,6,'/');
    int month=atoi(temp);
    date.setMonth(month);
    in.getline(temp,6,'/');
    int day=atoi(temp);
    date.setDay(day);
    in.getline(temp,6,' ');
    int year=atoi(temp);
    date.setYear(year);
    in.getline(temp,6,':');
    int hour=atoi(temp);
    date.setHour(hour);
    in.getline(temp,6,':');
    int minute=atoi(temp);
    date.setMinute(minute);
    in.getline(temp,6,'\n');
    int second=atoi(temp);
    date.setSecond(second);
    return in;
}
