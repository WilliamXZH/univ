#include <iostream>
#include <cstdlib>
#include <stdexcept>
#include <string>

using namespace std;

#include "simulator.h"
#include "fifo.h"


int main (int argc, char *argv[]) {
	//cout<<argc<<endl;
    if (argc != 2) {
        cerr << "Usage: " << argv[0] << " data-file\n";
        return EXIT_FAILURE;
    }

    try {
        string file = argv[1];
        simulator *s = new fifo (2);
        s->simulate(file);
        delete s;
    }
    catch(exception& e) {
        cerr << e.what() << endl;
    }
    catch(...) {
        cerr << "Unknown exception caught!" << endl;
    }
    
    return EXIT_FAILURE;
}
