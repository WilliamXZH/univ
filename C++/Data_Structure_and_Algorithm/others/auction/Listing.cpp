#include "Listing.h"

Advertisement* Listing::operator[]( const int& number ){

     for( iterator iter = this->begin();iter != this->end();iter++ ){

        if( ( *iter )->getNumber() == number ){

            return *iter;//指向指针的指针

        }

     }
     return NULL;

}

void Listing::add( Advertisement* ptr ){

    this->objects.push_back( ptr );

}

Listing::iterator Listing::begin(){

    return this->objects.begin();

}

Listing::iterator Listing::end(){

    return this->objects.end();

}

bool sort_email( Advertisement* ad1,Advertisement* ad2 ){

    return ad1->getEmail() < ad2->getEmail();

}

bool sort_start( Advertisement* ad1,Advertisement* ad2 ){

    return ad1->getStart() < ad2->getClose();

}

bool sort_close( Advertisement* ad1,Advertisement* ad2 ){

    return ad1->getClose() < ad2->getClose();

}

bool sort_quantity( Advertisement* ad1,Advertisement* ad2 ){

    return ad1->getQuantity() < ad2->getQuantity();

}

Listing Listing::sort( string field ){

    Listing the_sorted_copy;
    the_sorted_copy.objects = this->objects;

    if( field == "email" ){

        std::sort( the_sorted_copy.begin(),the_sorted_copy.end(),sort_email );
        //这里有两个sort，不指定命名空间的话容易混淆
        return the_sorted_copy;

    }

    if( field == "start" ){

        std::sort( the_sorted_copy.begin(),the_sorted_copy.end(),sort_start );
        return the_sorted_copy;

    }

    if( field == "close" ){

        std::sort( the_sorted_copy.begin(),the_sorted_copy.end(),sort_close );
        //明白了，这里的begin()函数被重写了，等同于this->object.begin()
        return the_sorted_copy;

    }

    if( field == "quantity" ){

        std::sort( the_sorted_copy.begin(),the_sorted_copy.end(),sort_quantity );
        return the_sorted_copy;

    }
    return the_sorted_copy;
}

Listing filter_obj;
string key;
void add_Ad( Advertisement* ad ){

    string title = ad->getTitle();
    string body = ad->getBody();
    if( title.find( key,0 ) != string::npos || body.find( key,0 ) != string::npos ){

        filter_obj.add( ad );
    }
}
Listing Listing::filter( string keyword ){

    key = keyword;
    filter_obj.objects.clear();
    for_each( this->begin(), this->end(), add_Ad );
    return filter_obj;

}
