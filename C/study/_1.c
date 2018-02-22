#include<stdio.h>
#include<math.h>
fun();
main(){
	int n;
	while(1){
		printf("请输入一个数:\n");
		scanf("%d",&n);
		if(n<2)continue;
		fun(n);
	}
}
fun(int n){
	int i;
	for(i=2;i<=sqrt(n),n%i!=0;i++);
	i>sqrt(n)?printf("%d是一个素数\n",n):printf("%d是一个合数\n",n);
}