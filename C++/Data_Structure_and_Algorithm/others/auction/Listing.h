#ifndef Listing_h
#define Listing_h
		
		
void add_Ad( Advertisement* ad );
bool sort_email( Advertisement* ad1,Advertisement* ad2 );
bool sort_start( Advertisement* ad1,Advertisement* ad2 );
bool sort_close( Advertisement* ad1,Advertisement* ad2 );
bool sort_quantity( Advertisement* ad1,Advertisement* ad2 );
class Listing
{
	public:
		void add( Advertisement* ptr );
		iterator begin();
		iterator end();
		Advertisement* operator[]( const int& number );
		Listing sort( string field );
		Listing filter( string keyword );

};
#endif