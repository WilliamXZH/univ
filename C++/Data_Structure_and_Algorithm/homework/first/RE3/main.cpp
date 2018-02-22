#include <iostream>
#include <fstream>
#include <string>
#include <cstdlib>

using namespace std;

#include "course.h"

void init_courses(course[]);
void display_menu(course[]);

const int NUM_COURSES = 10;
const int QUIT = 99;

int main(int argc, char* argv[]) {

    course courses[NUM_COURSES];
    init_courses(courses);
    
    int choice = 0;
    while (choice != QUIT) {
    
        display_menu(courses);
        cout << "Enter number of course to see more information on\n";
        cin >> choice;
        cout << "\n";

        if (choice >= 1 && choice <= NUM_COURSES) {
            cout << courses[choice - 1] << "\n\n";
        }
    }

    return EXIT_SUCCESS;
}

void display_menu(course courses[]) {

    for (int i = 1; i <= NUM_COURSES; i++) {
        cout << i << ". " << courses[i - 1].name << "\n";
    } 
    cout << "99. Quit\n";
}

void init_courses(course courses[]) {
    
    ifstream inf("courses.txt");
    if (! inf) {
        cerr << "Could not open courses.txt" << endl;
        exit(EXIT_FAILURE);
    }
 
    for (int i = 0; i < NUM_COURSES; i++) {
        inf >> courses[i];
    } 
    
    inf.close();
}

