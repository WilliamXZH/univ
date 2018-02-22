#include <iostream>
#include "Categories.h"

Category* Categories::operator[]( const int& number ){

    for( iterator iter = this->begin(); iter != this->end(); iter++ ){

        if( ( *iter )->getNumber() == number ){

            return *iter;

        }
    }
    return NULL;
}

void Categories::add(Category* ptr){

    this->objects.push_back( ptr );

}

Categories::iterator Categories::begin(){

    return this->objects.begin();

}

Categories::iterator Categories::end(){

    return this->objects.end();

}
