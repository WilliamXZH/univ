import stack.py
def longestValidParentheses(self, s):  
	stack, ans = [], 0  
	for i,v in enumerate(")"+s):  
	  if v == ")" and stack and stack[-1][1] == "(":  
		stack.pop()  
		ans = max(ans, i - stack[-1][0])  
	  else:  
		stack.append((i, v))  
	return ans  


print(longestValidParentheses(self,"(()"))
