#include<iostream>
using namespace std;
const float PI=(float)3.14159;
const float FencePrice=35;
const float ConcretePrice=20;
class Circle
{
	public:
		Circle(float r);
		float Circumference();
		float Area();
	private:
		float radius;
};
Circle::Circle(float r)
{
	radius=r;
}
float Circle::Circumference()
{
	return 2*PI*radius;
}
float Circle::Area()
{
	return PI*radius*radius;
}
int main()
{
	float radius;
	float FenceCost,ConcreteCost;
	cout<<"Enter the radius of the pool:";
	cin>>radius;
	Circle Pool(radius);
	Circle PoolRim(radius+3);
	FenceCost =PoolRim.Circumference()*FencePrice;
	cout<<"Fencing Cost is гд "<<FenceCost<<endl;
	ConcreteCost=(PoolRim.Area()-Pool.Area())*ConcretePrice;
	cout<<"Concrete Cost is гд "<<ConcreteCost<<endl;
}