#include"fifo.h"

fifo::fifo(int seconds_per_page):simulator(seconds_per_page){
}
void fifo::simulate(string file){
	int Aggregate_latency=0;
	int total=0;
	int nexttime=0;
	int time=0;
	event e;
	queue<event> waiting;

	loadworkload(file);
	cout<<"FIFO Simulation \n"<<endl;
	for(time=0;!workload.empty()||!waiting.empty();time++){
		if(!workload.empty())e=workload.front();
		
		while(!workload.empty()&&!(time-e.arrival_time())){
			cout<<"\tArriving: "<<e<<endl;
			nexttime=nexttime>e.arrival_time()?nexttime:e.arrival_time();
			waiting.push(event(e.getjob(),nexttime));
			Aggregate_latency+=nexttime-e.arrival_time();
			nexttime+=e.getjob().getnumpages()*seconds_per_page;
			workload.pop();
			if(!workload.empty())e=workload.front();
		}
		if(!waiting.empty())e=waiting.front();
		while(!waiting.empty()&&e.arrival_time()==time){
			cout<<"\tServicing: "<<e<<endl;
			waiting.pop();
			total++;
			if(!waiting.empty())e=waiting.front();
		}
		
	}
	cout<<"\n\tTotal jobs: "<<total<<endl;
	cout<<"\tAggregate latency: "<<Aggregate_latency<<" seconds"<<endl;
	cout<<"\tMean latency: "<<(float)Aggregate_latency/total<<" seconds"<<endl;
}
//fifo::~fifo(){}