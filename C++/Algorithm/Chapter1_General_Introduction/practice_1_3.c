#include<stdio.h>
#define IntPart(d) ((int)(d))
#define PrintDigit(d) printf("%d",d)
#define DecPart(d) (d-(int)(d))
#define PrintOut(d) printf("%d",d)

double RoundUp(double N,int DecPlaces){
	int i;
	double AmountToAdd = 0.5;
	for(i=0;i<DecPlaces;i++){
		AmountToAdd /= 10;
	}
	return N+AmountToAdd;
}

void PrintFractionPart(double FractionPart, int DecPlaces){
	int i, Adigit;
	for(i=0;i<DecPlaces;i++){
		FractionPart *= 10;
		Adigit = IntPart(FractionPart);
		PrintDigit(Adigit);
		FractionPart = DecPart(FractionPart);
	}
}

void PrintReal(double N, int DecPlaces){
	int IntegerPart;
	double FractionPart;
	if(N<0){
		putchar('-');
		N = -N;
	}
	N = RoundUp(N, DecPlaces);
	IntegerPart = IntPart(N);
	FractionPart = DecPart(N);
	PrintOut(IntegerPart);/* Using routine in text */
	if(DecPlaces >0){
		putchar('.');
	}
	PrintFractionPart(FractionPart, DecPlaces);
}

void main(){
	double i;
	int j;
	while(scanf("%lf%d",i,j)){
		PrintReal(i,j);
	}
}