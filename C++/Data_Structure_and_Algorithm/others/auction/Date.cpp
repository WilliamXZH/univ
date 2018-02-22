#include "Date.h"
#include <cstring>
Date::Date() {

    this->month = 0;
    this->day = 0;
    this->year = 0;
    this->hour = 0;
    this->minute = 0;
    this->second = 0;

}

Date::Date( int month, int day, int year, int hour, int minute, int second ) {

    this->month = month;
    this->day = day;
    this->year = year;
    this->hour = hour;
    this->minute = minute;
    this->second = second;

}

void Date::setMonth( int& Month ) {

    this->month = Month;

}

void Date::setDay( int& Day ) {

    this->day = Day;

}

void Date::setYear( int& Year ) {

    this->year = Year;

}

void Date::setHour( int& Hour ) {

    this->hour = Hour;

}

void Date::setMinute( int& Minute ) {

    this->minute = Minute;

}

void Date::setSecond( int& Second ) {
    this->second = Second;
}

int Date::getMonth() const {

    return this->month;

}

int Date::getDay() const {

    return this->day;

}

int Date::getYear() const {

    return this->year;

}

int Date::getHour() const {

    return this->hour;

}

int Date::getMinute() const {

    return this->minute;

}

int Date::getSecond() const {
    return this->second;
}

bool Date::operator==( const Date &rhs ) {

    if( this->getMonth() == rhs.getMonth() && this->getDay() == rhs.getDay()
        && this->getYear() == rhs.getYear() && this->getMinute() == rhs.getMinute()
        && this->getHour() == rhs.getHour() && this->getSecond() == rhs.getSecond() ) {

            return true;

    }
    return false;//this是指针，而rhs是对象
}

bool Date::operator<( const Date &rhs ) {
    if( this->getYear() < rhs.getYear() ) {

        return true;

    }else if( rhs.getYear() == this->getYear() ) {

        if( this->getMonth() < rhs.getMonth() ) {

            return true;

        }else if( rhs.getMonth() == this->getMonth() ) {

            if( this->getDay() < rhs.getDay() ) {

                return true;

            }else if( rhs.getDay() == this->getDay() ) {

                if( this->getHour() < rhs.getHour() ) {

                    return true;

                }else if( rhs.getHour() == this->getHour() ) {

                    if( this->getMinute() < rhs.getMinute() ) {

                        return true;

                    }else if( rhs.getMinute() == this->getMinute() ) {

                        if( this->getSecond() < rhs.getSecond() ) {

                            return true;

                        }
                    }
                }
            }
        }
    }
    return false;
}

ostream &operator<<( ostream& os,const Date &date ) {
    //输出数据的重载操作
    os << date.getMonth() << "/" << date.getDay() << "/" << date.getYear()
       << " " << date.getHour() << ":" << date.getMinute() << ":" << date.getSecond();
    return os;
}

istream &operator>>( istream& in,Date& date ) {

     string a1,a2;
     int month,day,year,hour,minute,second;
     in >> a1 >> a2;//输入是以空格为结束
     sscanf( a1.c_str(),"%d/%d/%d",&month,&day,&year );//c_str()返回一个指向字符串的指针，const char *c_str()
     sscanf( a2.c_str(),"%d:%d:%d",&hour,&minute,&second );//如果一函数要求返回char*参数，则可以用c_str()参数
     date = Date( month,day,year,hour,minute,second );
     return in;

}
