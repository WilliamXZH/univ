#include <cstdio>    
#include <cstdlib>
#include <iostream>
using namespace std;

#define     FAIL    ((struct BOAT *)-1)  
#define       M   3        
#define       C   3        
#define       K   2        

   
struct Lift   
{   
    int m;                         
int c;                     
    int b;                     
    struct Lift *pNext;           
};      
  
struct BOAT   
{   
    int m; 
    int c;    
    struct BOAT *pNext;   
};   
   
struct BOAT *g_pBoatSet = NULL;  
   
    
int Equal(struct Lift *pLift1, struct Lift *pLift2)  
{   
    if (pLift1->m == pLift2->m &&   
        pLift1->c == pLift2->c &&   
        pLift1->b == pLift2->b)    
        return 1;   
    else   
        return 0;   
}   
   
struct Lift *NewLift(int m, int c, int b)   
{   
    struct Lift *pLift = NULL;   
    pLift = (Lift*)malloc(sizeof(struct Lift));   
    if (pLift == NULL) return NULL;   
    pLift->m = m;   
    pLift->c = c;   
    pLift->b = b;   
    pLift->pNext = NULL;   
    return pLift;   
}   
   
struct BOAT *NewBoat(int m, int c)   
{   
    struct BOAT *pBoat = NULL;   
pBoat = (BOAT*)malloc(sizeof(struct BOAT));
    if (pBoat == NULL) return NULL;   
    pBoat->m = m;   
    pBoat->c = c;   
    pBoat->pNext = NULL;   
    return pBoat;   
}   
struct BOAT *InitBoats(void)   
{   
    struct BOAT *pBoats = NULL, *pBoat = NULL;   
    int i, j;   
   
        
    for (i = 0; i <= 2; i++)       {   
        for (j = 0; j <= 2; j++)   
        {   
            if(i+j<=2)			{ 
            pBoat = NewBoat(i, j);   
            if (pBoat == NULL) return NULL;   
            pBoat->pNext = pBoats;   
            pBoats = pBoat;
			}
        }   
    }   
    return pBoats;   
}   
   
int IsGoal(struct Lift *pLift)   
{   
    if (pLift->m == 0 &&   
        pLift->c == 0 &&   
        pLift->b == 0)    
        return 1;   
    else    
        return 0;   
}   
           
int Safe(struct Lift *pLift)   
{   
    if (pLift->m < 0 ||   
        pLift->c < 0 ||   
        pLift->m > M ||
		pLift->c > C ||
        pLift->c > M) return 0;  
    if (pLift->m == M ||   
        pLift->m == 0) return 1; 
return (pLift->m == pLift->c); 
}   
   
void PrintLift(struct Lift *pLift)
{   
	int rm=3-(pLift->m), rc=3-(pLift->c);
    printf("(%d, %d, %d)  (%d, %d)\n", pLift->m, pLift->c, pLift->b,rm, rc); 
	}   
   
  
 
void PrintBoatList(struct BOAT *pList)   
{   
       
    if (pList == FAIL)   
    {   
        printf("no solution!\n");   
        return;   
    }   
    if (pList == NULL)   
    {   
        printf("( )\n");   
        return;   
    }   
    else   
    {      
        printf("(0, 0, 0)\n");   
    }   

}   
   
int Length(struct Lift *pList)   
{   
    if (pList == NULL) return 0;   
    return Length(pList->pNext) + 1;   
}   
   
struct Lift *ConsLift(struct Lift *pLift, struct Lift *pList)   
{   
    pLift->pNext = pList;   
    return pLift;   
}   
   
   
struct BOAT *ConsBoat(struct BOAT *pBoat, struct BOAT *pList)   
{   
    pBoat->pNext = pList;   
    return pBoat;   
}   
   
    
struct Lift *Gen(struct BOAT *pBoat, struct Lift *pData)   
{   
    if (pData->b == 1)   
    {   
        return NewLift(pData->m - pBoat->m, pData->c - pBoat->c, 0);   
    }   
    else   
    {   
        return NewLift(pData->m + pBoat->m, pData->c + pBoat->c, 1);   
    }   
}   
   
struct BOAT *CopyBoat(struct BOAT *pBoat)   
{   
    return NewBoat(pBoat->m, pBoat->c);   
}   
   
  
struct Lift *In(struct Lift *pLift, struct Lift *pList)   
{   
    if (pList == NULL) return NULL;   
    if (Equal(pLift, pList)) return pList;   
    return In(pLift, pList->pNext);   
}   
   
    
void FreeLiftList(struct Lift *pLiftList)   
{   
    struct Lift *pLift = NULL;   
    while (pLiftList)   
    {   
        pLift = pLiftList;   
        pLiftList = pLiftList->pNext;   
        free(pLift);   
    }   
}   
   
    
void FreeBoatList(struct BOAT *pBoatList)   
{   
    struct BOAT *pBoat = NULL;   
    if (pBoatList == FAIL) return;   
    while (pBoatList)   
    {   
        pBoat = pBoatList;   
        pBoatList = pBoatList->pNext;   
        free(pBoat);   
    }   
}   
   
struct BOAT *Backtrack1(struct Lift *pDataList, int bound)   
{   
    struct Lift *pData = NULL, *pRData = NULL, *pRDataList = NULL;   
    struct BOAT *pBoat = NULL, *pBoats = NULL, *pPath = NULL;   
   
    pData = pDataList;    
    if (In(pData, pDataList->pNext))    
    {   
        return FAIL;       
    }   
    if (IsGoal(pData))      
    {   
        FreeLiftList(pDataList);       
        return NULL;       
    }   
    if (!Safe(pData))     
    {   
        return FAIL;       
    }   
    if (Length(pDataList) > bound)   
    {   
        return FAIL;       
    }   
   
    pBoats = g_pBoatSet;       
       
    PrintLift(pDataList);   
    while (pBoats)   
    {   
        pBoat = pBoats; 
        pBoats = pBoats->pNext;    
        pRData = Gen(pBoat, pData);   
        if (pRData == NULL) return FAIL;     
   
        if (!Safe(pRData))          {   
            free(pRData);               continue;     
        }   
           
           
        pRDataList = ConsLift(pRData, pDataList);   
        pPath = Backtrack1(pRDataList, bound);     
           
   
        if (pPath == FAIL)   
        {   
   
            free(pRData);              continue;    
        }   
           
           
        pBoat = CopyBoat(pBoat);      
        if (pBoat == NULL) return FAIL;   
        return ConsBoat(pBoat, pPath);      
    }   
    return FAIL;      
}   
   
void main(void)   
{   
    struct Lift *pData = NULL;   
    struct BOAT *pPath = NULL;       
    g_pBoatSet = InitBoats();     
    cout<<"3个传教士与3个野人问题的答案为：\n左岸\t右岸"<<endl;   
    pData = NewLift(3, 3, 1);      
    pPath = Backtrack1(pData, 20);    
       
    PrintBoatList(pPath);   

       
    if (pPath == FAIL)      
    {   
        free(pData);        
    }   
    FreeBoatList(pPath);        
    FreeBoatList(g_pBoatSet);      
}
