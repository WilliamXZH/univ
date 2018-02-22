#if !define(Space_Point_001)
#define Space_Point_001
///////////////
#include "Point.h"
class SpacePoint:public Point
{
	private:
		int z;
	public:
		void SetZ(int pz=0){z=pz;};
		int GetZ(){return z;}
		void ShowPoint()
		{
			cout<<"<"<<GetX()<<","<<GetY()<<","<<z<<">"<<endl;
		}
		//protect x,y
		//x,y
};
////////////////
#endif