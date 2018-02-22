#include "Category.h"
#include "Categories.h"
Category::Category(){

    this->number = 0;
    this->parent = 0;
    this->name = "";

}

Category::Category( int parent,string name ){

    this->parent = parent;
    this->name = name;

}

int Category::getNumber() const{

    return this->number;

}

int Category::getParent() const{

    return this->parent;

}

string Category::getName() const{

    return this->name;

}

void Category::setNumber(int Number){

    this->number = Number;

}

void Category::setParent(int Parent){

    this->parent = Parent;

}

void Category::setName(string Name){

    this->name = Name;

}

void Category::addSubCategory(Category* cate){

    this->sub_categories.push_back( cate );

}

void Category::addItem(int AdNumber){

    this->items.push_back( AdNumber );

}

void Category::findOfferings (Listing::iterator start,
					Listing::iterator finish, Listing &matches){//这是两个Listing对象

    int number;

    for( Listing::iterator iter = start; iter != finish; iter++ ){

        number = ( *iter )->getNumber();
        //ItemSize = this->items.size();

        for( int i = 0; i < ( int )this->items.size(); i++ ){

            if( number == this->items[i] ){

                matches.add( *iter );
                break;

            }
        }
    }

}

void Category::findOfferingsRecursive ( Listing::iterator start,
					Listing::iterator finish, Listing &matches ){
    int number = 0, Items_Size = 0;

    for( Listing::iterator it = start; it != finish; it++ ){

        number = (*it)->getNumber();
        Items_Size = this->items.size();

        for( int i = 0; i < Items_Size; i++ ){
            if( number == items[i] ) {
                matches.add(*it);
                break;
            }
        }
    }

    int sub_categories_size = 0;
    sub_categories_size = this->sub_categories.size();

    for( int i = 0; i < sub_categories_size; i++ ){

        this->sub_categories[i]->findOfferingsRecursive(start, finish, matches);
        //递归的显示子类
    }

}

vector<int>::iterator Category::itemsBegin(){

    return this->items.begin();

}

vector<int>::iterator Category::itemsEnd(){

    return this->items.end();

}

vector<Category*>::iterator Category::subCategoriesBegin(){

    return this->sub_categories.begin();

}

vector<Category*>::iterator Category::subCategoriesEnd(){

    return this->sub_categories.end();

}

bool Category::operator==(const Category& rhs){

    if( this->getNumber() == rhs.getNumber() && this->getParent() == rhs.getParent()
        && this->getName() == rhs.getName() && this->items == rhs.items
        && this->sub_categories == rhs.sub_categories ){

            return true;

    }
    return false;

}

istream &operator>>(istream &stream, Category &c){

    int parent_id;
    string name;
    stream >> parent_id >> name;
    c = Category( parent_id,name );
    return stream;

}
