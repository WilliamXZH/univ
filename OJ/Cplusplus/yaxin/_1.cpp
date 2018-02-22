#if !defined(_TestUtils_h_)
#define _TestUtils_h_

#include <string>
#include <vector>
#include <iostream>

using namespace std;

class TestUtils {
public:

	/**
	 * ���������ʽΪy=kx+b�����루x1,y1������x2,y2������k��b��ֵ
	 *
	 * @param x1 ������
	 * @param y1 ������
	 * @param x2 ������
	 * @param y2 ������
	 * @return ����������
	 */
	static const vector<double>& formula(double x1, double y1, double x2, double y2) {
		// ���ڴ���Ӵ���
        static vector<double> v;
		double k = (y1-y2)/(x1-x2);
		double b = y1-k*x1;
		cout<<k<<'\t'<<b<<endl;
		v.push_back(k);
		v.push_back(b);
		cout<<v.size()<<endl;
		return v;
	}

	// ������Ҫ�����ڴ���Ӹ�������������

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