<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="liftingmagnet.com.app.*" %>
<%@page import="liftingmagnet.com.db.dao.Worldwide" %>
<%@page import="liftingmagnet.com.usermanage.User" %>
<%@page import="java.util.Vector"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	ContactInfo contactInfo = (ContactInfo)application.getAttribute("contact_info");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath %>">
    
    <title><%=contactInfo.getCompanyName() %>---Worldwide</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	
	<link rel="stylesheet" type="text/css" href="css/basic_style.css">
	<link rel="stylesheet" type="text/css" href="css/worldwide.css">
	<script type="text/javascript" src="js/iframe_auto_height.js"></script>
	<script type="text/javascript">
		window.onload = function(){
			update_iframe_height();
			parent.setLocation("&nbsp;<a href='worldwides.jsp'>Worldwide</a>&nbsp;&gt;");
		};
	</script>
	<jsp:include page="hfoot.jsp"></jsp:include>
  </head>
  <body>
 	<div class="fix_auto">
 	<%
	  	Vector<Worldwide> wws = Worldwide.getAll();
 	 %>
 	 	<div style="text-align:center;font-weight:bold;font-size:14px;margin-bottom:10px;">Our worldwide!</div>
    	<table class="blue" align="center">
    		<thead>
    			<tr><th>No.</th><th>Area</th><th>Partners</th></tr>
    		</thead>
    		<tbody>
	<%
	  	for (int i=0;i<wws.size();i++)
	  	{
	  		Worldwide ww = wws.get(i);
	%>
    			<tr class="<%=i%2==0?"odd":"even" %>">
	    			<td width="40px" align="center"><%=i+1 %></td>
	    			<td width="200px" align="center"><%=ww.getArea() %></td>
	    			<td width="200px" align="center"><%=ww.getAgent() %></td>
	    		</tr>
	<%
    	}
	%>
    		</tbody>
    	</table>
    </div>
	<jsp:include page="foot.jsp"></jsp:include>
  </body>
</html>
