#include<stdio.h>
//#define len(p) (sizeof(p)/sizeof(p[0]))
char* toUpper(char p[],int n);
char* toLower(char p[],int n);
char* cesar(char p[],int n,int x);
char* toOpposite(char p[],int n);
int len(char p[]){
	int c=-1;
	while(p[++c]!='\0');
	return c;
}
//char* strcp(char p[],char q[]){
//	int i=0;
//	while((q[i]=p[i++])!='\0');
//	return q;
//}

void main(){
	char p[100];
	scanf("%s",p);
	printf("original string:%s\n",p);
	printf("opposite string:%s\n",toOpposite(p,len(p)));//×Ö·û´®´óÐ¡Ð´»¥»»
	toOpposite(p,len(p));//×Ö·û´®»»»ØÔ­Ñù
	printf("all       upper:%s\n",toUpper(p,len(p)));
	printf("all       lower:%s\n",toLower(p,len(p)));
}

char* toOpposite(char p[],int n){
	int i;
	for(i=0;i<n;i++){
		//printf("%c",p[i]);
		if(p[i]>=65&&p[i]<=90){
			p[i] = p[i]+32;
		}else if(p[i]>=97&&p[i]<=122){
			p[i] = p[i]-32;
		}
		//printf("%c",p[i]);
	}
	//printf("\n");
	return p;
}
char* toUpper(char p[],int n){
	return cesar(p,n,-32,96,122);
}
char* toLower(char p[],int n){
	return cesar(p,n,32,65,90);
}
char* cesar(char p[],int n,int x,int f,int t){
	int i;
	for(i=0;i<n;i++){
		if(p[i]>=f&&p[i]<=t){
			p[i] = p[i]+x;
		}
	}
	return p;
}