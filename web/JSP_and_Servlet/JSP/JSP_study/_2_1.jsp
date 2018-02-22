<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.util.*" %>
<html>
<body bgcolor="cyan"><font size="1">
<p>
<br>
<form action="_2_1.jsp" method="post" name="form">
<input type="text" name="boy">
<input type="submit" value=" 送出" name="submit">
</form>
<%! doublea[]=new double[3];
	String answer=null;

%>
<%
	int i=0;
	boolean b=true;
	String s=null;
	double result=0;
	double a[]=new double[3];
	String answer=null;
	s=request.getParameter("boy");
	if(s!=null){
		StringTokenizer fenxi=new StringTokenizer(s,", ,");
		while(fenxi.hasMoreTokens()){
			String temp=fenxi.nextToeken();
			try{
				a[i]=Double.valueOf(temp).doubleValue();
				i++;

			}catch(NumberFormatException e){
				out.print("<br>"+"	请输入数字字符");
			}
		}
		if(a[0]+a[1]>a[2]&&a[0]+a[2]>a[1]&&a[1]+a[2]>a[0]&&b=true){
			double p=(a[0]+a[1]+a[2])/2;
			result=Math.sqrt(p*(p-a[0])*(p-a[1])*(p-a[2]));
			out.printl("\t面积："+result);
		}else{
			answer="	您输入的三边不能构成一个三角形";
			out.print("<br>"+answer);
		}
	}
%>
<p>	您输入的三边是:
<br>
<%=a[0]%>
<br>
<%=a[1]%>
<br>
<%=a[2]%>
</body>
</html>

