//#include <syslib.h>
#include <malloc.h>
#include<stdio.h>
      main()
      {
        char *p;
        
        clrscr();        // clear screen
        textmode(0x00);

        p=(char *)malloc(100);
        if(p)
          printf("Memory Allocated at: %x",p);
        else
          printf("Not Enough Memory!\n");
          
        getchar();
        free(p);         // release memory to reuse it

        p=(char *)calloc(100,1);
        if(p)
          printf("Memory Reallocated at: %x",p);
        else
          printf("Not Enough Memory!\n");

        free(p);         // release memory at program end
        
        getchar();
        return 0;
      }