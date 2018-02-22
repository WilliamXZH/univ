#include "Group.h"
Client* Group::operator[]( const string& email ){

    for( iterator iter = this->begin();iter != this->end();iter++ ){

        if( ( *iter )->getEmail() == email ){

            return *iter;

        }

    }
    return NULL;

}

void Group::add( Client* ptr ){

    this->objects.push_back( ptr );

}

Group::iterator Group::begin(){

    return this->objects.begin();

}

Group::iterator Group::end(){

    return this->objects.end();

}
