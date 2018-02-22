#include <iostream>
#include <vector>
#include <iterator>
#include <algorithm>
#include <functional>

#include "Advertisement.h"
#include "Listing.h"
      Advertisement* Lisiting::operator[](const int& number);
      {
          for(int i=0;i<int(this->objects.size());i++)
			{if(this->objects.at(i)->getNumber()==number)
			{
				return this->objects.at(i);
			}
			}
      }

	  void Listing::add(Advertisement* ptr)
     {
        this->objects.push_back(ptr);
     }

	   iterator Listing::end()
	  {
	      return objects.end();
	  }
	  iterator Listing::begin()
	  {
	      return objects.begin();
	  }
