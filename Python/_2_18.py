class FooClass(object):
	"""my very first class:FooClass"""
	version=0.1 #class(data) attribute
	def __init__(self,nm='John Doe'):
		"""constructor"""
		self.name=nm # class instance (data)attribute
		print('Created a class instance for' ,nm)
	def showname():
		"""display instance attribute and class name"""
		print ('Your name is',self.name)
		print ('My name is',self._class_._name_)
	def showver(self):
		""""display class (static)attribute"""
		print (self.version) #referrnce FooClass.version
	def addMe2Me(self,x):#does not use'self
		"""apply +operation to argument"""
		return x+x

foo1 =FooClass()
foo1.showver()
print (foo1.addMe2Me(5))
print (foo1.addMe2Me('xyz'))
print ("%s is number %d!" %("python",1))
import sys
print(sys.stderr,'Fatal error :invalid input')
logfile =open('mylog.txt','a')
print(sys.stderr,file=logfile)
logfile.close()
b=bytes('\xc3\x9f\x65\x74\x61','iso-8859-1')
print(b)
b'hello' b'word'
b'\xc3\x9f\x65\x74\x61'.decode().encode()
data=open('dat.txt','rb').read()
print(data)#data is a string
#content of data txt printed out here
print("I love {0},{1},and {2}".format("eggs","bacon","sausage"))
print("I love {a},{b},and {c}".format(a="eggs",b="bacon",c="sausage"))
print("{0}".format("can't see me"))
print(format(10.0,"7.3g"))