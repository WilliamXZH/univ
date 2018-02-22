#include<stdio.h>
#include<stdlib.h>
void main()
{
	FILE *fp;
	char ch[80],*p=ch;
	int n;
	if((fp=fopen("F:\\myfile.txt","w"))==NULL)
	{
		printf("Cannot open the exit!");
		exit(0);
	}
	printf("input a string:\n");
	for(n=1;n<=5;n++)
	{
		gets(p);
		while(*p!='\0')
		{
			fputc(*p,fp);
			p++;
		}
		fputc('\n',fp);
		//fputs("abcd",fp);
		//fprintf(fp,"%d%c",j,ch);
		//fwrite(buffer,size,cout,fp);

		/*
		ch=fgetc(fp);
		fgets(str,n,fp);
		fscanf(fp,"%d%c",j,ch);
		fread(buffer,size,count,fp);
		rewind(fp);
		fseek(fp,100L,0);

		feof(fp);
		ferror(fp);
		clearerr(fp);
		*/
	}
	fclose(fp);

}