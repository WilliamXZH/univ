#include<stdio.h>
#include<math.h>
fun();
main(){
	int n;
	while(1){
		printf("������һ����:\n");
		scanf("%d",&n);
		if(n<2)continue;
		fun(n);
	}
}
fun(int n){
	int i;
	for(i=2;i<=sqrt(n),n%i!=0;i++);
	i>sqrt(n)?printf("%d��һ������\n",n):printf("%d��һ������\n",n);
}