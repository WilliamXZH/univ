#if !defined(_TestUtils_h_)
#define _TestUtils_h_

#include <string>
#include <vector>
#include <iostream>

using namespace std;

class TestUtils {
public:

	/**
	 * 设这个解析式为y=kx+b，输入（x1,y1）、（x2,y2），求k和b的值
	 *
	 * @param x1 浮点型
	 * @param y1 浮点型
	 * @param x2 浮点型
	 * @param y2 浮点型
	 * @return 浮点型数组
	 */
	static const vector<double>& formula(double x1, double y1, double x2, double y2) {
		// 请在此添加代码
        static vector<double> v;
		double k = (y1-y2)/(x1-x2);
		double b = y1-k*x1;
		cout<<k<<'\t'<<b<<endl;
		v.push_back(k);
		v.push_back(b);
		cout<<v.size()<<endl;
		return v;
	}

	// 若有需要，请在此添加辅助变量、方法

};

#endif


int main(){
	TestUtils t;
	const vector<double> v = t.formula(0,1,1.5,2.5);
	cout<<v.size()<<endl;
	for(int i=0;i<v.size();i++){
		cout<<v[i]<<endl;
	}
	return 0;
}