#include <iostream>
#include <vector>
#include <cstdio>
#include <algorithm>

using namespace std;

double getMax(double **prices, int from, int to, int n, double p)
{
	int mf, mt, idn;
	double max=1.0;
	
	if(from==to)return max;
	for(int i=0;i<n;i++)
	{
		for(int j=from;j<=to;j++)
		{
			for(int k=j+1;j<=to;j++)
			{
				if(prices[k][i]/prices[j][i]>max)
				{
					mf=j;
					mt=k;
					idn=i;
					max=prices[k][i]/prices[j][i];
				}
			}
		}
	}
	cout<<prices[mt][idn]/prices[mf][idn]<<endl;
	if(prices[mt][idn]/prices[mf][idn]<p||prices[mt][idn]<prices[mf][idn])return 1.0;
	return getMax(prices,from,mf,n,p)*(0.9*prices[mt][idn]/prices[mf][idn])*getMax(prices,mt,to,n,p);
}

double StockGod(int n, int m, double p, double** prices)
{
	return getMax(prices,0,m-1,n,p);
}


int main()
{
    int n = 0;
    int m = 0;
    double p = 0;
    cin >> n >> m >> p;

    double **prices;
	prices = new double*[m];
    for(int i = 0; i < m; ++i) {
		prices[i] = new double[n];
        for(int j = 0; j < n; ++j) {
            cin >> prices[i][j];
        }
    }

    double final = StockGod(n, m, p, prices);
    printf("%.1f\n", final);
    
    return 0;
}