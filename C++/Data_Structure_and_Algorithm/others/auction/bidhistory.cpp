#include <sstream>
#include <winsock2.h>
#include <ws2tcpip.h>
#include <signal.h>
#include <cstdio>

#include "main.h"
#include "buildpage.h"
#include "buildbidpage.h"
#include "bidhistory.h"
#include "Client.h"
#include "Advertisement.h"
#include "Listing.h"
#include "Group.h"

using namespace std;


void displayBidHistory( ostringstream &oss, Advertisement* ad ){

    int total_quantity=ad->getQuantity();
    Date start=ad->getStart();
    Date close=ad->getClose();
    priority_queue<Bid> bids=ad->getBids();
    int num_bids=bids.size();
    string bid_email="";
    float bid_amount=0;
    int bid_quantity=0;
    int currentwin_quantity=0;
    int notbidon_quantity=0;
    Client* client=users[ad->getEmail()];
    string fname=client->getFname();
    string lname=client->getLname();

    oss<<"<br>"<<"Seller'name :"<<fname<<" "<< lname<<endl;
    oss<<"<br>"<<"Posting date:"<<start<<endl;
    oss<<"<br>"<<"Closing date:"<<close<<endl;
    oss<<"<br>"<<"The quantity:"<<total_quantity<<endl;
    oss<<"<br>"<<"Bids number :"<<num_bids<<endl;
    oss<<"<br>"<<"---------------------------------------------"<<endl;

    if ( total_quantity == 1 && !bids.empty() ) {

        //数量只有1且不为空
        Bid top_bid = (Bid) bids.top();
        float amount = top_bid.getAmount();
        string email = top_bid.getEmail();
        oss<<"<br>"<<"The highest bid(dollar):"<<amount<<"$"<<endl;
        oss<<"<br>"<<"Bidder's email:"<<email<<endl;

    } else if( total_quantity > 1 ) {

        int quantity = 0;
        vector<Bid> win_bids = ad->getTopDutchBids();//返回成功竞标的人
        vector<Bid>::iterator itr_bids;

        for ( itr_bids = win_bids.begin(); itr_bids != win_bids.end(); itr_bids++ ){

            bid_email = itr_bids->getEmail();
            bid_amount = itr_bids->getAmount();
            bid_quantity = itr_bids->getQuantity();
            quantity = quantity + bid_quantity;

            if ( quantity <= total_quantity ) {

                currentwin_quantity = bid_quantity;

            }else if ( quantity > total_quantity ){

                quantity = quantity - bid_quantity;
                currentwin_quantity = total_quantity - quantity;//当前正在进行竞标的
                quantity += bid_quantity;

            }

            oss<<"<br>"<<"Bidder's  email:<A HREF=mailto:"<<bid_email<<">";
            oss<<bid_email<<"</a>"<< endl;
                  oss<<"<br>"<<"Bidder's  price :"<<bid_amount<<"$"<<endl;
                  oss<<"<br>"<<"Bidding quantity:"<<bid_quantity<<endl;
                  oss<<"<br>"<<"Winning quantity:"<<currentwin_quantity<<endl;
                  oss<<"<br>"<<"---------------------------------------------"<<endl;
            }
            if ( quantity < total_quantity )  notbidon_quantity = total_quantity - quantity;
            else if ( quantity >= total_quantity ) notbidon_quantity=0;
            oss<<"<br>"<<"The number is not bid on:"<<notbidon_quantity<<endl;
      }
}
