<% @page contentType="text/html;charset=GB2312" %>
<HTML>
	<BODY BGCOLOR=cyan>
	<FONT Size=1>
	<p>����һ���򵥵�JSPҳ��
		<% int i,sum=0;
			for(i=0;i<=100;i++)
			{
				sum=sum+i;
			}
		%>
	<p>1 �� 100 ���������ǣ�http://localhost:8080/moon/Example1_2.jsp
	<br>
	<% =sum%>
	</font>
	</body>
</HTML>