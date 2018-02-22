class Point
{
	public:
		void InitP(float xx=0,float yy=0){X=xx;Y=yy;}
		void Move(float xOff,float yOff){X+=xOff;Y+=yOff;}
		float GetX(){return X;}
		float GetY(){return Y;}
	private:
		float X,Y;
};
class Rectangle:public Point
{
	public:
		void InitR(float x,float y,float w,float h){InitP(x,y);W=w,H=h;}
		float GetH(){return H;}
		float GetW(){return W;}
	private:
		float W,H;
};
//End of Rectangle.h