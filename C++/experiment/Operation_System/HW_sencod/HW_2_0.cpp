#include<iostream>
using namespace std;
const static int FULL=-1;
const static int EMPTY=0;
const static int OCUPIED=1;
const static int SLEEPING=2;
const static int DONE=3;
const static int WAITED=4;
static int ComeIn=1;
static int GetOut=1;
class BarberShop{
	private:
		int chairNumber;
		int barber;
		int *chairState;
	public:
		BarberShop(int pChairNum){
			chairNumber=pChairNum;
			chairState=new int[chairNumber];
			barber=SLEEPING;
			for(int i=0;i<chairNumber;i++)
				chairState[i]=EMPTY;
		}
		bool FindOneChair(){
			int test=FULL;
			for(int i=0;i<chairNumber;i++){
				if(chairState[i]=EMPTY)
					test=i;
			}
			if(test=FULL)
				return false;
			else 
				chairState[test]=OCUPIED;
			return true;
		}
		bool AnyoneWaiting(){
			for(int i=0;i<chairNumber;i++){
				if(chairState[i]==OCUPIED)
					return true;
			}
			return false;
		}
		int getHairCut(){
			wait(ComeIn);
			if(barber==SLEEPING){
				barber=OCUPIED;
				signal(ComeIn);
				return SLEEPING;
			}else if(barber==OCUPIED){
				bool test=FindOneChair();
				signal(ComeIn);
				if(test==false)
					return FULL;
				else{
					while(barber!=DONE)
						sleep();
					for(int i=0;i<chairNumber;i++){
						if(chairState[i]==OCUPIED){
							chairState[i]=EMPTY;
							break;
						}
					}
					barber=OCUPIED;
					return WAITED;
				}
			}else{
				barber=OCUPIED;
				signal(ComeIn);
				return DONE;
			}
		}
		void LeaveBarberShop(){
			wait(GetOut);
			bool test=AnyoneWaiting();
			if(test==true)
				barber=DONE;
			else 
				barber=SLEEPING;
			signal(GetOut);
		}
};