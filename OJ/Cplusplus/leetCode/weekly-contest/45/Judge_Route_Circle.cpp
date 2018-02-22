#include<iostream>
#include<string>
using namespace std;

bool judgeCircle(string moves);

int main(){

	string str;
	cin>>str;

	cout<<judgeCircle(str);

	return 0;
}

bool judgeCircle(string moves){
	int px=0;
	int py=0;
	for(int i=0;i<moves.size();i++){
		switch(moves[i]){
			case 'R':
				px++;
				break;
			case 'L':
				px--;
				break;
			case 'U':
				py++;
				break;
			case 'D':
				py--;
				break;
			default:
				break;
		}
	}

	return px==0&&py==0;
}