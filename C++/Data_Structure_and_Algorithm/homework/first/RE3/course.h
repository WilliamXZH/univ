#ifndef COURSE_H
#define COURSE_H
#include"safearray.cpp"
int const MAX_LINES2 = 10;
class course;
ostream& operator<<(ostream & out, const course& c);
istream& operator>>(istream & in, course& c);

class course {

  public:
    string name;
    string title;
    safearray<string> description(MAX_LINES2);
     
    course() : name(""), title("") {}
    course(string name, string title) : 
        name(name), title(title) {}

    friend ostream& operator<<(ostream&, const course&);        
    friend istream& operator>>(istream&, course&);
};

ostream& operator<<(ostream& out, const course& c) {

    out << c.name << ": " << c.title << "\n";

    /*int index = 0;
    while (c.description[index] != "") {
        out << c.description[index++] << "\n";    
    }*/
	int index = 0;
	string d=c.description[index];
    while ( d!= "") {
		d= c.description[index++];
        out << d<< "\n";    
    }


    return out;
}

istream& operator>>(istream& in, course& c) {

    getline(in, c.name);
    getline(in, c.title);

    string line;
    getline(in, line);
    int number = 0;
    while (line != "") {
        c.description[number++] = line;
        getline(in, line);
    }
    
    return in;
}

#endif
