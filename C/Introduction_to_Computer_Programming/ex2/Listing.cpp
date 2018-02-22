#include <iostream>
#include <vector>
#include <iterator>
#include <algorithm>
#include <functional>

#include "Advertisement.h"
#include "Listing.h"
      Advertisement* Listing::operator[](const int& number)
      {
          Advertisement* ptr_ad = NULL;
          for(int i=0;i<int(this->objects.size());i++)
			{if(this->objects.at(i)->getNumber()==number)
			{
				ptr_ad = this->objects.at(i);
			}
			}
			return ptr_ad;
      }

	  void Listing::add(Advertisement* ptr)
     {
        this->objects.push_back(ptr);
     }

	   vector<Advertisement*>::iterator Listing::end()
	  {
	      return objects.end();
	  }
	  vector<Advertisement*>::iterator Listing::begin()
	  {
	      return objects.begin();
	  }
