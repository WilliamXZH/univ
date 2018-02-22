#include<stdio.h>

int len(char p[]);
char* encrypt(char p[],char q[]);
char* decipher(char p[],char q[]);

void main(){
	char p[100];
	char q[300];
	char r[100];
	while(scanf("%s",p)){
		printf("%s\n",p);
		printf("%s\n",encrypt(p,q));
		//printf("%d\n",len(q));
		printf("%s\n\n",decipher(q,r));
	}
}

int len(char p[]){
	int c = -1;
	while(p[++c]!='\0');
	return c;
}
char* encrypt(char p[],char q[]){
	int l = len(p);
	int i,j;
	
	//printf("%d",l);
	for(i=0;i<l;i++){
		int t = p[i];
		for(j=2;j>=0;j--){
			q[i*3+j]=t%10+'0';
			t /= 10;
		}
	}
	q[l*3] = '\0';
	
	return q;
}
char* decipher(char p[],char q[]){
	int l = len(p)/3;
	int i,j;
	for(i=0;i<l;i++){
		int t = 0;
		for(j=0;j<3;j++){
			t *= 10;
			t += p[i*3+j]-'0';
		}
		q[i] = t;
	}
	q[l] = '\0';
	return q;
}