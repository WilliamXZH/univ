#include<stdio.h>  
  
//Show the movement of the n-th plate  
void move(int n, int x, int y){  
        printf("the %dth plate from %c to %c\n",n,x+65,y+65);  
}  
  
  
//将n个盘子从A座移到C座的过程（借助B座）  
void hanoi(int n, int A, int B, int C){  
        if(n==1)  
            move(n,A,C);  
        else{  
            hanoi(n-1,A,C,B);  
            move(n,A,C);  
            hanoi(n-1,B,A,C);  
        }  
}  
  
//The main function  
int main()  
{  
    int n; //Hanoi's total plates  
    printf("Assuming the top plate is the first plate\nplease input the number of plate : ");  
    scanf("%d",&n);  
    hanoi(n,0,1,2);  
}  
