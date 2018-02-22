#include<stdio.h>

void main(){
	int i,j,s=0;
	char p[100];
	char r='+';
	scanf("%s",p);
	for(i=0;p[i]!='\0';i++){
		//printf("%c",p[i]);
		if(p[i]>='0'&&p[i]<='9'){
			int t=0;
			while(p[i]>='0'&&p[i]<='9'){
				t*=10;
				t+=p[i++]-'0';
			}
			printf("tmp_res:%d%c%d\n",s,r,t);
			if(r=='+')s+=t;
			else if(r=='-')s-=t;
			i--;
		}else if(p[i]=='+') r=p[i];
		else if(p[i]=='-')r=p[i];
		else {
			printf("\nError!!!\n");
			break;
		}
	}
	printf("%d\n",s);
}