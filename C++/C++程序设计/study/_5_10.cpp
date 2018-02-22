#include"point.cpp"
int main(){
	Point A(4,5);
	cout<<"Point A,"<<A.GetX()<<","<<A.GetY()<<endl;
	A.GetC();
	Point B(A);
	cout<<"Point B,"<<B.GetX()<<","<<B.GetY()<<endl;
	Point::GetC();
}