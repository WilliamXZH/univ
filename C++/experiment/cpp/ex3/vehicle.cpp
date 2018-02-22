#include"vehicle.h"
int main()
{
	vehicle v1,*v;
	bicycle v2;
	motorcar v3;
	motorcycle v4;
	v1.Run();
	v2.Run();
	v3.Run();
	v4.Run();
	v4.MaxSpeed=10.0;
	v4.Weight=5;
	v4.bicycle::Height=1.6;
	v4.SeatNum=3;
	cout<<"v4.MaxSpeed:"<<v4.MaxSpeed<<"\tv4.Weight:"<<v4.Weight<<"\tv4.bicycle::Height:"
		<<v4.bicycle::Height<<"\tv4.SeatNum:"<<v4.SeatNum<<endl;
	v=&v1;v->Run();v->Stop();
	v=&v2;v->Run();v->Stop();
	v=&v3;v->Run();v->Stop();
	v=&v4;v->Run();v->Stop();
	v1.Stop();
	v2.Stop();
	v3.Stop();
	v4.Stop();
}