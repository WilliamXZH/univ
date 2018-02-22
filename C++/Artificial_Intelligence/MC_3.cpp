/* 
 * Test.cpp 
 * 
 *  Created on: Aug 4, 2015 
 *      Author: guangwei8.wu 
 */  
  
#include "stdafx.h"  
  
#include <stdio.h>  
#include <memory.h>  
  
#define SIZE  256  
  
//condition nodes;  
//ml, cl means scholars and cannibals on the left  
//boat == 1 means left or right  
//level to record times crossing the river  
typedef struct  
{  
        int ml, cl, boat, level;  
} conNode;  
  
int N; //N the number of the cannibals  and also scholars  
int M; //M  the limit of the boat  
int Answer;  
conNode conQueue[SIZE]; //N*N*2     condition queue  
int flag[11][11][2]; //1 visited, 0 not  
  
int front, rear;  
  
void initQueue()  
{  
    front = 0;  
    rear = 0;  
}  
  
int fullQueue()  
{  
    if (front == (rear + 1) % SIZE)  
        return 1;  
    else  
        return 0;  
}  
  
int emptyQueue()  
{  
    if (front == rear)  
        return 1;  
    else  
        return 0;  
}  
void inQueue(conNode node)  
{  
    if (fullQueue())  
        return;  
    conQueue[rear] = node;  
    rear = (rear + 1) % SIZE;  
}  
  
conNode deQueue()  
{  
    if (!emptyQueue())  
    {  
        conNode n = conQueue[front];  
        front = (front + 1) % SIZE;  
        return n;  
    }  
}  
  
int validCon(conNode n);  
  
int main(void)  
{  
    int T, test_case;  
  
    setbuf(stdout, NULL);  
    scanf("%d", &T);  
    for (test_case = 0; test_case < T; test_case++)  
    {  
        int f;  
        conNode n;  
        scanf("%d %d", &N, &M);  
  
        Answer = -1;  
        memset(flag, 0, sizeof(flag));  
        initQueue();  
        n.ml = N;  
        n.cl = N;  
        n.boat = 1;  
        n.level = 0;  
        inQueue(n);  
        f = 1;  
        flag[n.ml][n.cl][n.boat] = 1;  
        while (!emptyQueue())  
        {  
            conNode tmp = deQueue();  
            conNode newNode;  
            int s = 0, c = 1;  
  
            for (s = 0; s <= M; s++)  
            {  
                if (s == 0)  
                    c = 1;  
                else  
                    c = 0;  
  
                while ((s == 0 && s + c <= M) || (s != 0 && s + c <= M && c <= s))  
                {  
                    if (tmp.boat == 1)  
                    {  
                        newNode.ml = tmp.ml - s;  
                        newNode.cl = tmp.cl - c;  
                        newNode.boat = 1 - tmp.boat;  
                        newNode.level = tmp.level + 1;  
                    }  
                    else  
                    {  
                        newNode.ml = tmp.ml + s;  
                        newNode.cl = tmp.cl + c;  
                        newNode.boat = 1 - tmp.boat;  
                        newNode.level = tmp.level + 1;  
                    }  
  
                    if (newNode.ml == 0 && newNode.cl == 0 && newNode.boat == 0)  
                    {  
                        f = 0;  
                        Answer = newNode.level;  
                        break;  
                    }  
  
                    if (validCon(newNode))  
                    {  
                        if (flag[newNode.ml][newNode.cl][newNode.boat] == 1)  
                        {  
                            c++;  
                            continue;  
                        }  
                        else  
                            flag[newNode.ml][newNode.cl][newNode.boat] = 1;  
  
                        inQueue(newNode);  
                    }  
  
                    c++;  
                }  
  
                if (f == 0)  
                    break;  
            }  
            if (f == 0)  
                break;  
        }  
        if (Answer == -1)  
            printf("impossible\n");  
        else  
            printf("%d\n", Answer);  
    }  
  
    return 0;  
}  
  
int validCon(conNode n)  
{  
    int ml = n.ml, cl = n.cl, boat = n.boat;  
  
    if (ml != 0 && ml < cl)  
        return 0;  
  
    if (N - ml != 0 && N - ml < N - cl)  
        return 0;  
  
    if (ml < 0 || cl < 0)  
        return 0;  
  
    if (ml > N || cl > N)  
        return 0;  
  
    if (ml == N && cl == N && boat == 0)  
        return 0;  
  
    if (ml == 0 && cl == 0 && boat == 1)  
        return 0;  
  
    return 1;  
}  