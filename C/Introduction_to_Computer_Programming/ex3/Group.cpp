#include <iostream>
#include <vector>
#include <iterator>
#include <algorithm>
#include <functional>

#include "Client.h"
#include "Group.h"

     Client* Group::operator[](const string& email);
     {
         for(int i=0;i<this->objects.size();i++)
	   {
		if(this->objects.at(i)->getEmail()==email)
		{
			return this->objects.at(i);
		}
	   }

     }
	 void Group::add(Client* ptr);
     {
         this.objects.push_back(ptr);
     }
	 iterator Group::begin(){
	 return this->objects.begin();
	 }
	 iterator Group::end()
	 {
	 return this->objects.end();
	 }
