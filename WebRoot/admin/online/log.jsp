<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="liftingmagnet.com.db.dao.*" %>
<%@page import="liftingmagnet.com.usermanage.*" %>
<%@page import="java.util.Vector"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	User user = (User)session.getAttribute("user");
	Authority limits = user.getLimits();
	if (!(limits.canSupervise()))
	{
		%>
  		<jsp:include page="noPermission.jsp"></jsp:include>
		<%
		return;
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath+"admin/online/"%>">
    
    <title>岳阳强力电磁有限公司---查看员工操作日志</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	
	<link rel="stylesheet" type="text/css" href="css/basic.css">
	<link rel="stylesheet" type="text/css" href="css/table.css">
	<style type="text/css">
		body
		{
			text-align: center;
			width: 660px;
		}
		
		.top_div
		{
			margin: 0px auto;
			width: 400px;
			padding: 10px 0px;
			text-align: left;
		}
	</style>
	<script type="text/javascript" src="../../js/iframe_auto_height.js"></script>
	<script type="text/javascript" src="js/dayselecthelper.js"></script>
	<script type="text/javascript">
		window.onload = function(){
			updateDay(document.getElementById("startYear").value,document.getElementById("startMonth").value,document.getElementById("startDay"));
			updateDay(document.getElementById("endYear").value,document.getElementById("endMonth").value,document.getElementById("endDay"));
			update_iframe_height();
			parent.setLocation("查看员工操作日志");
		};
	</script>
  </head>
  
  <body>
     <div class="top_div">
     	<form action="logResult.jsp">
     		<div style="margin-bottom:5px;">
	     		<font color="blue">请选择员工</font>
	     		<select style="margin-left:23px;" name="name">
	     			<%
		     			Vector<User> users = user.getAllUsers();
		     			int size = users.size();
		     			for (int i=0;i<size;i++)
		     			{
		     				User u = users.get(i);
		     		 %>
		     		 	<option value="<%=u.getName() %>"><%=u.getName() %></option>
		     		 <%
		     		 	}
		     		  %>
	     		</select>
     		</div>
     		<div style="margin-bottom:5px;">
	     		<font color="blue">开始时间</font>
	     		<select style="margin-left:35px;" id="startYear" name="startYear" onchange="updateDay(document.getElementById('startYear').value,document.getElementById('startMonth').value,document.getElementById('startDay'));">
	  			<%
				   	int year = java.util.Calendar.getInstance().getTime().getYear() + 1900;
				   	int month = java.util.Calendar.getInstance().getTime().getMonth()+1;;
	  				for (int i=2009;i<2050;i++)
	  				{
	  			 %>
	  				<option value="<%=i %>" <%=i==year?"selected":"" %>><%=i %></option>
	  			<%
	  				}
	  			%>
	  			</select>
	  			<font color="blue">年</font>
	     		<select id="startMonth" name="startMonth" onchange="updateDay(document.getElementById('startYear').value,document.getElementById('startMonth').value,document.getElementById('startDay'));">
	  			<%
	  				for (int i=1;i<13;i++)
	  				{
	  			 %>
	  				<option value="<%=i %>" <%=i==month?"selected":"" %>><%=i %></option>
	  			<%
	  				}
	  			%>
	  			</select>
	  			<font color="blue">月</font>
	  			<select id="startDay" name="startDay">
	  				<option value="1">1</option>
	  			</select>
	  			<font color="blue">日</font>
     		</div>
     		<div style="margin-bottom:5px;">
	     		<font color="blue">结束时间</font>
	     		<select style="margin-left:35px;" id="endYear" name="endYear" onchange="updateDay(document.getElementById('endYear').value,document.getElementById('endMonth').value,document.getElementById('endDay'));">
	  			<%
	  				for (int i=2009;i<2050;i++)
	  				{
	  			 %>
	  				<option value="<%=i %>" <%=i==year?"selected":"" %>><%=i %></option>
	  			<%
	  				}
	  			%>
	  			</select>
	  			<font color="blue">年</font>
	     		<select id="endMonth" name="endMonth" onchange="updateDay(document.getElementById('endYear').value,document.getElementById('endMonth').value,document.getElementById('endDay'));">
	  			<%
	  				for (int i=1;i<13;i++)
	  				{
	  			 %>
	  				<option value="<%=i %>" <%=i==month?"selected":"" %>><%=i %></option>
	  			<%
	  				}
	  			%>
	  			</select>
	  			<font color="blue">月</font>
	  			<select id="endDay" name="endDay">
	  				<option value="1">1</option>
	  			</select>
	  			<font color="blue">日</font>
	  			<input type="submit" value="查看" style="margin-left: 30px;">
     		</div>
     	</form>
	 </div>
  </body>
</html>
