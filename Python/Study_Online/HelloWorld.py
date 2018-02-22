#-*-coding:utf-8-*-
# coding:utf-8 
myString='Hello,World!'
print(myString)
#error:price=raw_input('input the stock price of Apple:')
'''price=input('input the stock price of Apple:')
print(price)
print(type(price))'''
#comment No.1
print('hello world!')#comment No.2
#long sentence
signal='red'
car='moving'
if(signal=='red')and\
(car=='moving'):
	car='stop'
elif(signal=='green')and\
(car=='stop'):
	car='moving'
print(car)

#triple quotes
print( '''hi everybody,
wlcome to python's MOOC course.
Here we can learn something about python.Good lucky!
''')

#Indentation
if(signal=='red')and(car=='moving'):
	car='stop'
	signal='yellow'
elif(signal=='green')and(car=='stop'):
	car='moving'
	signal='yellow'

#variable
p=3.14159
myString='is a mathematic circular constant'
print(p,myString)

x='Today';y='is';z='Thursday';
print(x,y,z)

#Identifier
PI=3.14159
pi='one word'
print(PI)
print(pi)


#key words
'''
False None True 
and as assert break class continue def del
elif else except exec finally for from global 
if import in is lambda nonlocal not or pass
print raise return try while with vield
'''

#experssion
PI=3.14159
r=2
c_circ=2*PI*r
print("The circle's circum:%f"%(c_circ))

#assignment
m=18
m%=5
print(m)
m**=2
print(m)

PI,r=3.14159,3
(PI,r)=(3.14159,3)#same as no round brackets
print(PI,r)

#integer
print(type(3.1))
print(type(3))

#boolean
x=True
print(x)
print(int(x))
y=False
print(y)
print(int(y))

#float
print(3.22)
print(9.8e3)
print(-4.78e-2)
print(type(-4.78e-2))

#complex
print(2.4+5.6j)
print(type(2.4+5.6j))
print(3j)
print(type(3j))
print(5+0j)
print(type(5+0j))

#complex
x=2.4+5.6j
print(x.imag)
print(x.real)
print(x.conjugate())

#expression of String
myString='Hello World!'
print(myString)
myString="Hello World!"
print(myString)
myString='''Hello World!'''
print(myString)

#mappping type:dictionary
d={'sine':'sin','cosine':'cos','PI':3.14159}
print(d['sine'])

#arithmetic operations
pi=3.14159
r=3
circum=2*pi*r
x=1
y=2
z=3
result1=x+3/y-z%2
result2=(x+y**z*4)//5 
#-*-coding:utf-8-*-
# -*- coding: utf-8 -*- write at the beginning,or can't contain chinese
#//整除,取整数结果
print(circum,result1,result2)

#compare
print(2==2)
print(2.46<=8.33)
print('abc'=='xyz')
print('abc'>'xyz')
print('abc'<'xyz')

#logical
print('logical')
x,y=3.1415926536,-1024
print(x<5.0)
print(x<5.0)or(y>2.718281828)
print((x<5.0)and(y>2.718281828))
print(not(x is y))
print(3<4<7) #same as "(3<4)and(4<7)"

#character_operation
#r
#f=open('c:\python\test.py','w')
f=open('test.py','w')
#r/R用于一些不希望转义字符起作用的地方
#u/R转换成Unicode字符串
#f=open(r'c:\python\test.py','w')
#f=open('c:\\python\\test.py','w')
# u
print(u'Hello\nWorld')

#FILL UP
#mix
print(3<2 and 2<1 or 5>4)
print(x+3/y-z%2>2)
print(3-2<<1)
print(3-2<<1<3)
#位运算符、比较运算符、逻辑运算符


#function
#绝对值函数abs(x)
#类型函数type(x)
#四舍五入函数round(x)

#内建函数
#-cmp(),str(),type()适用于所有标准类型

'''
数值型内建函数
abs()		bool()		oct()
coerce()	int()		hex()
divmod()	long()		ord()
pow()		float()		chr()

实用函数
dir()		raw_input()	input()
help()		open()
len()		range()


Build-in Functions
abs()			divmod()		input()			open()			staticmethod()
all()			enumerate()		int()			ord()			str()
any()			eval()			isinstance()	pow()			sum()
basestring()	execfile()		issubclass()	print()			super()
bin()			file()			iter()			property()		tuple()
bool()			filter()		len()			range()			type()
bytearray()		float()			list()			raw_input()		unichr()
callable()		format()		locals()		reduce()		unicode()
chr()			frozenset()		long()			reload()		vars()
classmethod()	getattr()		map()			repr()			xrange()
cmp()			globals()		max()			reversed()		zip()
compile()		hasattr()		memoryview()	round()			__import__()
complex()		hash()			min()			set()			apply()
delattr()		help()			next()			setattr()		buffer()
dict()			hex()			object()		slice()			coerce()
dir()			id()			oct()			sorted()		intern()


Build_in Functions in Python 3.x
abs()			dict()			help()			min()			setattr()
all()			dir()			hex()			next()			slice()
any()			divmod()		id(0			object()		sorted()
ascii()			enumerate()		input()			oct()			staticmethod()	
bin()			eval()			int()			open()			str()
bool()			exec()			isinstance()	ord()			sum()
bytearray()		filter()		issubclass()	pow()			super()
bytes()			float()			iter()			print()			tuple()
callable()		format()		len()			property()		type()
chr()			frozenset()		list()			range()			cars()
classmethod()	getattr()		locals()		repr()			zip()
compile()		globals()		map()			reversed()		__import__()
complex()		hasattr()		max()			round()
delattr()		hash()			memoryview()	set()
'''

#dound-off int
print(int(35.4))
print(int(35.5))
print(int(35.8))
print(type(int(35.8)))
#round-off round
print(round(35.4))
print(round(35.5))
print(round(35.8))
print(type(int(35.8)))

#round-off floor
from math import*
print(floor(5.4))
print(floor(-35.5))
print(floor(-35.8))

#module
import math
print(math.pi)


#import ModuleName
#import ModuleName1,ModuleName2,...
#from Module1 import ModuleElement


'''
AAA/
	__init__.py
	bbb.py
	CCC/
		__init__.py
		c1.py
		c2.py
	DDD/
		__init__.py
		d1.py
	EEE/
'''
#import AAA.CCC.c1
#AAA.CCC.C1.func1(123)
#from AAA.CCC.c1 import func1
#func1(123)

'''
#library
decimal
math cmath
random
operator
array
'''


