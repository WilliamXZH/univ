#include"fifo.h"
#include<fstream>
//using std::ofstream;

fifo::fifo(int seconds_per_page):simulator(seconds_per_page){
}
void fifo::simulate(string file){
	int Aggregate_latency=0;
	int total=0;
	int latency=0;
	int counter=0;
	event e;
	queue<event> waiting;
	
//	ofstream out;
//	for(int i=0;file[i]!='.';i++);
//	out.open((string(file.c_str(),file.c_str()+i)+".out").c_str());
//	if (!out) {
//    cerr << "Couldn't open input file, workload empty" << endl;
//    return;
// 	}

	loadworkload(file);
	cout<<"FIFO Simulation \n"<<endl;
// 	out<<"FIFO Simulation \n"<<endl;
	for(counter=0;!workload.empty()||!waiting.empty();counter++){
		if(!workload.empty())e=workload.front();		
		while(!workload.empty()&&!(counter-e.arrival_time())){
			cout<<"\tArriving: "<<e<<endl;
			// out<<"\tArriving: "<<e<<endl;
			latency=latency>e.arrival_time()?latency:e.arrival_time();
			waiting.push(event(e.getjob(),latency));
			Aggregate_latency+=latency-e.arrival_time();
			latency+=e.getjob().getnumpages()*seconds_per_page;
			workload.pop();
			total++;
			if(!workload.empty())e=workload.front();
		}
		if(!waiting.empty())e=waiting.front();
		while(!waiting.empty()&&e.arrival_time()==counter){
			cout<<"\tServicing: "<<e<<endl;
			// out<<"\tServicing: "<<e<<endl;
			waiting.pop();
			if(!waiting.empty())e=waiting.front();
		}
		
	}
	cout<<"\n\tTotal jobs: "<<total<<endl;
	cout<<"\tAggregate latency: "<<Aggregate_latency<<" seconds"<<endl;
	cout<<"\tMean latency: "<<(float)Aggregate_latency/total<<" seconds"<<endl;
	
//	out<<"\n\tTotal jobs: "<<total<<endl;
//	out<<"\tAggregate latency: "<<Aggregate_latency<<" seconds"<<endl;
//	out<<"\tMean latency: "<<(float)Aggregate_latency/total<<" seconds"<<endl;
// 	out.close();
}
fifo::~fifo(){
}