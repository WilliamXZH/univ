#pragma warning(disable:4786)

#include <sstream>
#include <set>
#include <string>
#include <winsock2.h>
#include <ws2tcpip.h>
#include <fcntl.h>
#include <errno.h>

#include "processrequest.h"
#include "main.h"
#include "Advertisement.h"
#include "Listing.h"
#include "Client.h"
#include "Categories.h"

using namespace std;

void displayListing(int connfd, int port, 
					Listing::iterator begin, Listing::iterator end) {

	ostringstream oss ("");
    buildpage (oss, port, begin, end);
    send (connfd, oss.str().c_str(), strlen (oss.str().c_str()), 0);
}




void processrequest(istringstream &iss, int connfd, int port) {

  char request[80];
  memset (request, 0, 80);
  iss.getline (request, 80);
  string req(request); 
  
  // instead of the above, we could have
  // just as easily done
  // getline(iss, req)
  // but there is a bug in MSVC++ getline, so
  // using the C-style string here is more portable
  
  if (req == "LOGIN") {

    string email;
    string passwd;

    iss >> email;
    iss >> passwd;

    /*
     * Find the client's record in the set
     */
    Client* search_results = users[email];
   
    if (search_results != NULL) {
		
		if (search_results->verifyPasswd(passwd)) {
			active_user = email;
			login_failed = false;
		}
		else {
			login_failed = true;
		}
    }
    else {
		login_failed = true;
    }

    displayListing(connfd, port, advertisements.begin(), advertisements.end());
  }

  else if (req == "LOGOUT") {
    active_user = "";
    displayListing(connfd, port, advertisements.begin(), advertisements.end());
  }

  else if (req == "CREATE") {

	string verify;
	Client client;
	iss >> client;
	iss >> verify;

    /*
     * Check for existing user
     */
    Client* search_results = users[client.getEmail()];

    if ( (client.verifyPasswd (verify)) && (search_results == NULL) ){

	  active_user = client.getEmail();
      Client* new_client = new Client(client);
	  
	  users.add (new_client);
	  create_verified = true;
    }
    else {
      create_verified = false;
	}
    
    displayListing(connfd, port, advertisements.begin(), advertisements.end());
  }

  else if (req == "ADD") {

	int category;
	iss.getline(request, 80);
	category = atoi(request);

	Advertisement ad;
	iss >> ad;
	ad.setNumber(advertisement_counter);
	advertisement_counter++;

	advertisements.add(new Advertisement(ad));
	
	Category* cat = categories[category];
	cat->addItem(ad.getNumber());

	displayListing(connfd, port, advertisements.begin(), advertisements.end());
  }

   else if (req == "CATEGORY_ADD") {

	Category cat;
	iss >> cat;

	Category* p = categories[cat.getParent()];
	cat.setName(p->getName() + " / " + cat.getName());
	cat.setNumber(category_counter);
	category_counter++;	

	Category* c = new Category(cat);
	categories.add(c);
	p->addSubCategory(c);

	displayListing(connfd, port, advertisements.begin(), advertisements.end());
  }

  else if (req == "TOP_ONLY") {
    	
	int category;
	iss.getline(request, 80);
	category = atoi(request);

	Listing filteredByCategory;
	Category* c = categories[category];
	
	c->findOfferings (advertisements.begin(), advertisements.end(), 
                      filteredByCategory );
	displayListing(connfd, port, filteredByCategory.begin(), filteredByCategory.end());
	
  }
  else if (req == "RECURSIVE") {
    	
	int category;
	iss.getline(request, 80);
	category = atoi(request);


	Listing filteredByCategory;
	Category* c = categories[category];
 	
	c->findOfferingsRecursive (advertisements.begin(),
						advertisements.end(), filteredByCategory );
	displayListing(connfd, port, filteredByCategory.begin(), filteredByCategory.end());
	
  }

  else if (req == "" || req == "LIST") {
	displayListing(connfd, port, advertisements.begin(), advertisements.end());
  }

  else {
	// unknown command! Let's just list to play it safe...
	displayListing(connfd, port, advertisements.begin(), advertisements.end());
  }

}

