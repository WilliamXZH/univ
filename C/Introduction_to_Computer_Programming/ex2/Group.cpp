#include <iostream>
#include <vector>
#include <iterator>
#include <algorithm>
#include <functional>

#include "Client.h"
#include "Group.h"

     Client* Group::operator[](const string& email)
     {
         Client* temp = NULL;
         for(int i=0;i<this->objects.size();i++)
	   {
		if(this->objects.at(i)->getEmail()==email)
		{
			temp = this->objects.at(i);
		}
	   }
	   return temp;

     }
	 void Group::add(Client* ptr)
     {
         this->objects.push_back(ptr);
     }
	 vector<Client*>::iterator Group::begin(){
	 return this->objects.begin();
	 }
	 vector<Client*>::iterator Group::end()
	 {
	 return this->objects.end();
	 }
