#include "RailSystem.h"
#include<stack>

void RailSystem::reset(void) {

    // TODO: reset the data objects of the
    // ���ø�����
	map<string, City*>::iterator ite = cities.begin();
	for(;ite!= cities.end();ite++)
	{
		ite->second->from_city ="";
		ite->second->total_distance = 0;
		ite->second->total_fee = 0 ;
		ite->second->visited = false ;
	}

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

            
			
			// �����в�����ʱ �½�����
			if( !is_valid_city(from) )
			{
				City *c = new City(from);
				cities[from]=c;
				cities.insert(  map<string, City*>::value_type( from ,c ) );
			}
			if( !is_valid_city(to) )
			{
				City *c = new City(to);
				cities.insert(  map<string, City*>::value_type( to ,c ) );
			}
			//�ڽӱ�Ľ���
			Service * s = new Service( to, fee, distance );
			if( outgoing_services.count(from)!=1)
			{
				list<Service*>  ls;
				ls.push_back( s );
				outgoing_services.insert (pair<string, list<Service*> >(from,ls));
			}
			else
				outgoing_services[from].push_back( s );

        }
    }

    inf.close();
}

RailSystem::~RailSystem(void) {

    // TODO: release all the City* and Service*
    // from cities and outgoing_services


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

	//candidates ��vector<City*> �洢 ��City* ���е������������    
	priority_queue<City*, vector<City*>, Cheapest> candidates;

    // TODO: Implement Dijkstra's shortest path algorithm to
    // find the cheapest route between the cities


	map<string, City*>::iterator ite;
	for(ite= cities.begin();ite!=cities.end();ite++)
	{
	 //��ʹÿһ��city �� from ����  ���ҳ�ʼ��Ϊ ������� �� �շ�   
		ite->second->total_fee=INT_MAX;
		ite->second->total_distance=INT_MAX;
		ite->second->from_city=from;
	}
	//��from������ʼ����ѹ��  ������Ϊ�ѷ���
	candidates.push (cities[from]);
	cities[from]->visited=1;
	cities[from]->total_fee =0;
	cities[from]->total_distance =0;
	cities[from]->from_city =from;

	list<Service*>::iterator it;
	for ( it=outgoing_services[from].begin();it!=outgoing_services[from].end();it++)
	{
	  // ��ÿһ����from ����ֱ�ӵִ�� city �ľ�����շ� ���и�ֵ
	  cities[(*it)->destination]->total_fee=(*it)->fee;
	  cities[(*it)->destination]->total_distance=(*it)->distance;
	} 


//��cities.size()������ ���ϱ��Ѿ�ѹ����from ���� ���г��ж�ѹ������ ����Ҫ����cities.size()-1��ѭ��
  for (int i=0;i< cities.size()-1;i++)
  {
		// min Ϊ��С����
	   int min=INT_MAX;
	   string current=from;
	   //Ѱ�ҵ������� �� ��С��
	   for( ite= cities.begin();ite!=cities.end();ite++ )
	   {
			if( ite->second->visited==0&&ite->second->total_fee<min )
			{
			 current=ite->second->name;
			 min=ite->second->total_fee;
			}
	   }
	   candidates.push(cities[current]);
	   cities[current]->visited=true;
	   //����Ƿ� ��ѹ��ĳ�����ָ�� ʣ�µĸ���û��δ����еĳ��е�·��
	    for(it= outgoing_services[current].begin();it!=outgoing_services[current].end();it++) 
		{
			for(ite= cities.begin();ite!=cities.end();ite++)
				if((*it)->destination == ite->second->name&& ite->second->visited == 0)
					//������ʱ ��� from ������ѹ��ĳ��е����³��еĻ��ѻ᲻���С
					if(  ( cities[current]->total_fee + (*it)->fee )< cities[(*it)->destination]->total_fee  )
					{
						 cities[(*it)->destination]->total_fee = cities[current]->total_fee + (*it)->fee;
					     cities[(*it)->destination]->total_distance = cities[current]->total_distance + (*it)->distance;
					     cities[(*it)->destination]->from_city=current;
					}
		}
  }
 




    // Return the total fee and total distance.
    // Return (INT_MAX, INT_MAX) if not path is found.
    if (cities[to]->visited) {
        return pair<int,int>(cities[to]->total_fee, cities[to]->total_distance);
    } else {
        return pair<int,int>(INT_MAX, INT_MAX);
    }

}

string RailSystem::recover_route(const string& city) {

    // ��������Ϊ string  Ҫ����ȫ������ ����֮��� to
    // container to recover the route we found
	stack< string > route_city;
	string s;
	string front_city = city;
	route_city.push(front_city);
	//ʵ�ֵ������
	while(front_city!=cities[front_city]->from_city)
	{
		front_city = cities[front_city]->from_city;
		route_city.push(front_city);
	}

	//��string �Ĵ���
	while(route_city.size()>1)
	{
		s=s+route_city.top()+" to ";
		route_city.pop();
	}
	s= s+ route_city.top();
	route_city.pop();
    return s;
}
