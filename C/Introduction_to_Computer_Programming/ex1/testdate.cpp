// testdate.cpp

#include <iostream>
#include <string>
#include <cstdlib>
#include <sstream>

#include "Date.h"

bool testConstructors(void);
bool testLessThan(void);
bool testInsertion(void);

int main(int argc, char* argv[]) {

    if (!testConstructors()) {
       cerr << "Constructor and\\or accessors failed check\n";
       return EXIT_FAILURE;
    }

    if (!testLessThan()) {
       cerr << "Operator < failed check\n";
       return EXIT_FAILURE;
    }

    if (!testInsertion()) {
       cerr << "Operator >> failed check\n";
       return EXIT_FAILURE;
    }

    cout << "All tests passed\n";

    return EXIT_SUCCESS;
}

bool testInsertion(void) {

    stringstream s;
    s << "8/17/1976 1:2:3\n";

    Date d;
    s >> d;

    if (d.getMonth() == 8 &&
        d.getDay() == 17 &&
        d.getYear() == 1976 &&
        d.getHour() == 1 &&
        d.getMinute() == 2 &&
        d.getSecond() == 3) {

        return true;
    }
    else {
        return false;
    }
}

bool testConstructors(void) {

    Date d(8, 17,1976, 1, 2, 3);
    Date e;
    if (d.getMonth() == 8 &&
        d.getDay() == 17 &&
        d.getYear() == 1976 &&
        d.getHour() == 1 &&
        d.getMinute() == 2 &&
        d.getSecond() == 3 &&
        e.getMonth() == 0 &&
        e.getDay() == 0 &&
        e.getYear() == 0 &&
        e.getHour() == 0 &&
        e.getMinute() == 0 &&
        e.getSecond() == 0) {

        return true;
    }
    else {
        return false;
    }
}


bool testLessThan(void) {

    Date d1(1, 1, 2004, 1, 1, 1);
    Date d2(2, 1, 2004, 1, 1, 1);
    Date d3(1, 2, 2004, 1, 1, 1);
    Date d4(1, 1, 2005, 1, 1, 1);
    Date d5(1, 1, 2004, 2, 1, 1);
    Date d6(1, 1, 2004, 1, 2, 1);
    Date d7(1, 1, 2004, 1, 1, 2);

    if ((d1 < d2) &&
        (d1 < d3) &&
        (d1 < d4) &&
        (d1 < d5) &&
        (d1 < d6) &&
        (d1 < d7) &&
        !(d2 < d1) &&
        !(d3 < d1) &&
        !(d4 < d1) &&
        !(d5 < d1) &&
        !(d6 < d1) &&
        !(d7 < d1) &&
        (d3 < d2) &&
        (d2 < d4) &&
        !(d4 < d2) &&
        (d7 < d6) &&
        (d6 < d5) &&
        !(d5 < d7)) {
        return true;
    }
    else {
        return false;
    }
}
