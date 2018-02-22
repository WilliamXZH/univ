#include <iostream>
#include <fstream>

using namespace std;
#include "simulator.h"
#include "fifo.h"

fifo::fifo(int seconds_per_page) :simulator(seconds_per_page){}

void fifo::simulate(string file){
	loadworkload(file);

	queue<event> waiting;
	queue<event> working;

	int time_counter = 0;
	int service_time = workload.front().arrival_time();
	int sz = workload.size();
	int done_job = 0;
	float aggre_latency = 0;

	cout << "FIFO Simulation" << endl << endl;

	while (!workload.empty()){
		for (; done_job < sz; time_counter++){
			event te;
			while (1){
				if (!workload.empty()){
					te = workload.front();
					if (time_counter == te.arrival_time()){
						waiting.push(te);
						cout << "\tArriving: " << te.getjob().getnumpages()
							<< " pages from " << te.getjob().getuser() << " at " << time_counter
							<< " seconds" << endl;
						if (working.empty()){
							working.push(te);
							cout << "\tServicing: " << working.front().getjob().getnumpages()
								<< " pages from " << working.front().getjob().getuser() << " at " << time_counter
								<< " seconds" << endl;
						}workload.pop();
					}
					else break;
				}
				else break;
				
			}
			if (waiting.empty()){
				continue;
			}
			if (time_counter == working.front().getjob().getnumpages()*seconds_per_page + service_time - 1){
				service_time = time_counter + 1;
				working.pop();
				done_job++;
			}
			if (working.empty()){
				waiting.pop();
				te = waiting.front();
				working.push(te);
				cout << "\tServicing: " << working.front().getjob().getnumpages()
					<< " pages from " << working.front().getjob().getuser() << " at " << time_counter
					<< " seconds" << endl;
				aggre_latency += service_time - waiting.front().arrival_time();
			}


		}
	}
	cout << endl << "\tTotal jobs: " << done_job << endl;
	cout << "\tAggregete latency: " << aggre_latency << " seconds" << endl;
	cout << "/tMean latency: " << aggre_latency / done_job << " seconds" << endl;


}