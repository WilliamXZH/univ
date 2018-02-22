#pragma warning (disable:4786)
#pragma warning (disable:4503)

#include<stack>

#include "RailSystem.h"

void RailSystem::reset(void) {
		map<string, City*>::iterator ite = cities.begin();
	for(;ite!= cities.end();ite++)
	{
		ite->second->from_city ="";
		ite->second->total_distance = 0;
		ite->second->total_fee = 0 ;
		ite->second->visited = false ;
	}
    // TODO: reset the data objects of the 
    // City objects' contained in cities
    
}

RailSystem::RailSystem(string const &filename) {
    
    load_services(filename);
}

void RailSystem::load_services(string const &filename) {

	ifstream inf(filename.c_str());
	string from, to;
	int fee, distance;

	while ( inf.good() ) {
		// Read in the from city, to city, the fee, and distance.
		inf >> from >> to >> fee >> distance;

		if ( inf.good() ) {
			if(!is_valid_city(from)){
				//cities[from]=new City(from); 
				//cities.insert(map<string,City*>::value_type(from,new City(from))); 
				//cities.insert(pair<string,City*>(from,new City(from))); 
				
				//City *c=new City(from);
				//cities.insert(make_pair(from,c)); 
				cities.insert(make_pair(from,new City(from))); 
			}
			//if(!is_valid_city(to)){City c=new City(to);cities.insert(pair<string,City*>(to,c));}
			if(!is_valid_city(to))cities.insert(pair<string,City*>(to,new City(to)));
			/*Service *ser=new Service(to,fee,distance);
			if(outgoing_services.find(from)==outgoing_services.end()){
				list<Service*> li;
				li.push_back(ser);
				//li.push_back(new Service(to,fee,distance));
				outgoing_services.insert(make_pair(from,li));
				
			}
			else outgoing_services[from].push_back(ser);*/
			//else outgoing_services[from].push_back(new Service(to,fee,distance));
			outgoing_services[from].push_back(new Service(to,fee,distance));
			
			// TODO: Add entries in the cities container and
			// and services in the rail system for the new 
            // cities we read in.	
		}
	}
//Print the finished reading information.	
//	map<string, list<Service*> >::iterator ite1 = outgoing_services.begin();
//	for(;ite1!= outgoing_services.end();ite1++ )
//	{	
//		list<Service*>::iterator ite2 = ite1->second.begin();
//		for( ; ite2!= ite1->second.end() ; ite2++){
//			cout<<ite1->first<<"  "<<((*ite2)->destination)<<"  "<<(*ite2)->fee<<"  "<<(*ite2)->distance<<endl;
//		}
// 	}
//	map<string,City*>::iterator ite=cities.begin();
//	for(;ite!=cities.end();ite++)cout<<ite->second->name <<endl;

	inf.close();
}

RailSystem::~RailSystem(void) {
	map<string, City*>::iterator ite = cities.begin();
	for(;ite!= cities.end();ite++)
		delete ite->second;

	map<string, list<Service*> >::iterator ite1 = outgoing_services.begin();
	for(;ite1!= outgoing_services.end();ite1++ )
	{
		list<Service*>::iterator ite2 = ite1->second.begin();
		for( ; ite2!= ite1->second.end() ; ite2++)
			delete *ite2;
	}
    // TODO: release all the City* and Service*
    // from cities and outgoing_services
}

void RailSystem::output_cheapest_route(const string& from,
                const string& to, ostream& out) {

	reset();
	pair<int, int> totals = calc_route(from, to);

	if (totals.first == INT_MAX) {
		out << "There is no route from " << from << " to " << to << "\n";
	} else {
		out << "The cheapest route from " << from << " to " << to << "\n";
		out << "costs " << totals.first << " euros and spans " << totals.second
			<< " kilometers\n";
        cout << recover_route(to) << "\n\n";
	}
}

bool RailSystem::is_valid_city(const string& name) {

	return cities.count(name) == 1;
}

pair<int, int> RailSystem::calc_route(string from, string to) {

	priority_queue<City*, vector<City*>, Cheapest> candidates;
    // TODO: Implement Dijkstra's shortest path algorithm to
    // find the cheapest route between the cities
    
	// Return the total fee and total distance.
	// Return (INT_MAX, INT_MAX) if not path is found.
	
//	for(map<string, City*>::iterator ite= cities.begin();ite!=cities.end();ite++){
//		ite->second->total_fee=INT_MAX;
//		ite->second->total_distance=INT_MAX;
//		//ite->second->from_city=from;
//	}

	City* city=cities[from];  
	city->total_fee=0;  
	city->total_distance=0;  
	city->from_city=from;
	candidates.push(city);  
	while(!candidates.empty()){
		City* visitingCity=candidates.top();
		candidates.pop();
		if(!visitingCity->visited)//mark the cities visited.
			visitingCity->visited=true;
		list<Service*>::iterator it=outgoing_services[visitingCity->name].begin();
		for(;it!=outgoing_services[visitingCity->name].end();++it){
			City* nextCity=cities[(*it)->destination];
			int nextFee=(*it)->fee+visitingCity->total_fee;
			//Dijkstra's algorithm change toke
			if((!(nextCity->total_fee)||(nextFee<nextCity->total_fee))&&nextCity->name!=from){
				nextCity->total_fee=nextFee;
				nextCity->total_distance=(*it)->distance+visitingCity->total_distance;
				nextCity->from_city=visitingCity->name;
				candidates.push(nextCity);
			}
		}	
	}
	//return the total fee and total distance 
	if (cities[to]->visited) {
		return pair<int,int>(cities[to]->total_fee, cities[to]->total_distance);
	} else {
		return pair<int,int>(INT_MAX, INT_MAX);
 	}
}

string RailSystem::recover_route(const string& city) {
	
	// TODO: walk backwards through the cities
	// container to recover the route we found
	stack< string > route_city;
	string s;
	string front_city = city;
	route_city.push(front_city);
	//push cities into stack container
	while(front_city!=cities[front_city]->from_city)
	{
		front_city = cities[front_city]->from_city;
		route_city.push(front_city);
	}
	//string connect
	while(route_city.size()>1)
	{
		s=s+route_city.top()+" to ";
		route_city.pop();
	}
	s= s+ route_city.top();
	route_city.pop();
    return s;
	
//	string back=city;  
//	string all=city;  
//	while((back = cities.find(back)->second->from_city)!=""){   
//		all = back+" to "+all;  
//	}   
//	return all;
}
