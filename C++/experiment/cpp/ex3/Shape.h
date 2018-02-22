#include"../ex2/CLine.h"
enum ColorType{White,Black,Red,Green,Blue,Yellow,Magenta,Cyan};
class Shape
{
	protected:
		ColorType color;
	public:
		Shape(){color=White;cout<<"Construct a Shape"<<endl;}
		Shape(Shape &shape){SetColor(shape.color);cout<<"Shape Copy Constructor is called!"<<endl;}
		Shape(ColorType ct){color=ct;cout<<"Construct a "<<ct<<" Shape"<<endl;}
		~Shape(){cout<<"Shape Destructed."<<endl;}
		void SetColor(ColorType ncolor){color=ncolor;}
		ColorType GetColor(){return color;}
		virtual void draw(){cout<<"This is a Shape!The color is "<<GetColor()<<endl;}
};
class Cline:public Shape,public CLine
{
	private:
		double length;
	public:
		Cline(){length=0;cout<<"Constructed a Cline!"<<endl;}
		Cline(Cline &cline){SetLength(cline.length);cout<<"Cline Copy Constructor is called!"<<endl;}
		Cline(double len,ColorType color){length=len;SetColor(color);cout<<"Constructed a Cline!"<<endl;}
		~Cline(){cout<<"Cline Destructed."<<endl;}
		void SetLength(double len){length=len;}
		double GetLength(){return length;}
		void ShowLine(){cout<<"length:"<<length<<endl;}
		void draw(){cout<<"This is a Cline!The color is "<<GetColor()<<".And the length is "<<GetLength()<<endl;}
};
class CRectangle:public Shape
{
	private:
		CPoint pt1,pt2,pt3,pt4;
	public:
		CRectangle(){cout<<"Constructed a CRectangle!"<<endl;}
		~CRectangle(){cout<<"CRextangle Destructed."<<endl;}
		void draw(){cout<<"This is a CRectangle!"<<endl;}

};
class CCircle:public Shape
{
	private:
		CPoint p;
		Cline l;
	public:
		CCircle(){cout<<"Contructed a CCircle!"<<endl;}
		~CCircle(){cout<<"CCircle Destructed."<<endl;}
		void draw(){cout<<"This is a CCircle!"<<endl;}
};