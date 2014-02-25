<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="liftingmagnet.com.db.dao.*" %>
<%@page import="liftingmagnet.com.usermanage.*" %>
<%@page import="java.util.Vector"%>
<%
	request.setCharacterEncoding("UTF-8");
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
	
	String name = request.getParameter("name");
   	String sys = request.getParameter("startYear");
   	String sms = request.getParameter("startMonth");
   	String sds = request.getParameter("startDay");
   	String eys = request.getParameter("endYear");
   	String ems = request.getParameter("endMonth");
   	String eds = request.getParameter("endDay");
   	
   	int startYear = java.util.Calendar.getInstance().getTime().getYear() + 1900;
   	int startMonth = java.util.Calendar.getInstance().getTime().getMonth()+1;;
   	int startDay = 1;
   	int endYear = startYear;
   	int endMonth = startMonth;
   	int endDay = 1;
   	try
   	{
   		startYear = Integer.parseInt(sys);
   	}catch(Exception e){}
   	try
   	{
   		startMonth = Integer.parseInt(sms);
   	}catch(Exception e){}
   	try
   	{
   		startDay = Integer.parseInt(sds);
   	}catch(Exception e){}
   	try
   	{
   		endYear = Integer.parseInt(eys);
   	}catch(Exception e){}
   	try
   	{
   		endMonth = Integer.parseInt(ems);
   	}catch(Exception e){}
   	try
   	{
   		endDay = Integer.parseInt(eds);
   	}catch(Exception e){}
   	
   	String pageString = request.getParameter("page");
   	
  		int pageIndex = 0;
   	try
   	{
   		pageIndex = Integer.parseInt(pageString);
   	}catch(Exception e){}
   	
   	int numsPerPage = 30;
   	Vector<Action> all = null;
   	String start = startYear+"-"+startMonth+"-"+startDay;
   	String end = endYear+"-"+endMonth+"-"+endDay;
   	if (name==null||(name=name.trim()).length()==0)
   	{
   		name = "";
   		all = (Vector<Action>)session.getAttribute("log");
   		name = (String)session.getAttribute("employee_name");
   		if (all==null)
   		{
   			all = new Vector<Action>();
   			name = "";
   		}
   	}
   	else
   	{
   		all = user.getAction(name,start,end);
   		if (all.size()>numsPerPage)
   		{
   			session.setAttribute("log",all);
   			session.setAttribute("employee_name",name);
   		}
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
			width: 600px;
			padding: 10px 0px;
			text-align: left;
		}
	</style>
	<script type="text/javascript" src="../../js/iframe_auto_height.js"></script>
	<script type="text/javascript">
		window.onload = function(){
			update_iframe_height();
			parent.setLocation("员工<<%=name %>>的操作日志");
		};
	</script>
  </head>
  
  <body>
     <div class="top_div">
    <%
    	int total = all.size();
 		pageIndex = pageIndex<0?0:pageIndex;
 		pageIndex = pageIndex>(total-1)/numsPerPage?(total-1)/numsPerPage:pageIndex;
    	if (total>0)
    	{
    	
     %>
     	<div style="padding-bottom:10px;"><%=name+" 在 "+start+"至"+end+"时间段内的操作记录如下：" %></div>
	    <table class="blue" align="center">
	    	<thead>
	    		<tr><th>序列</th><th>操作</th><th>操作时间</th></tr>
	    	</thead>
	    	<tbody>
	    		<%
	    			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			    	for (int i=pageIndex*numsPerPage;i<total&&i<(pageIndex+1)*numsPerPage;i++)
			    	{
			    		Action action = all.get(i);
	    		 %>
	    		<tr class="<%=(i-pageIndex*numsPerPage)%2==0?"odd":"even" %>">
	    			<td align="center" width="40px"><%=i+1%></td>
	    			<td align="left" style="padding: 3px 10px;width:400px;*width:420px;">
	    				<%=action.getTarget() %>
	    			</td>
	    			<td align="center" width="140px"><%=sdf.format(action.getTime()) %></td>
	    		</tr>
	    		<%
	    			}
	    		 %>
	    	</tbody>
	    </table>
	    <div style="padding-top:10px;padding-right:10px;">
	    	<%
	    		int pages = total/numsPerPage;
	    		pages = total%numsPerPage!=0?pages+1:pages;
	    		if (pages==1)
	    		{
	    	 %>
	    	 	<div style="text-align:right;margin-top:10px;">总共1页</div>
	    	 <%
	    	 	}
	    	 	else
	    	 	{
	    	  %>
	    	<form action="logResult.jsp" id="go">
	    		<table align="right">
	    			<tbody>
	    				<tr>
	    					<td>总共<%=pages %>页,当前显示第<%=pageIndex+1 %>页</td>
	    					<td><a href="logResult.jsp?page=0">首页</a></td>
	    					<td>
								<%
									if (pageIndex>0)
									{
								 %>
								 	<a href="logResult.jsp?page=<%=pageIndex-1 %>">上一页</a>
								<%
									}
									else
									{
								 %>
								 	上一页
								<%
									}
								 %>
							</td>
	    					<td>
	    						<%
									if (pageIndex<pages-1)
									{
								 %>
								 	<a href="logResult.jsp?page=<%=pageIndex+1 %>">下一页</a>
								<%
									}
									else
									{
								 %>
								 	下一页
								<%
									}
								 %>
							</td>
	    					<td><a href="logResult.jsp?page=<%=pages-1 %>">尾页</a></td>
	    					<td>
	    						跳转到第
	    						<select name="page" onchange="document.getElementById('go').submit();">
	    							<%
	    								for (int i=0;i<pages;i++)
	    								{
	    							 %>
	    							 <option value="<%=i %>" <%=pageIndex==i?"selected":"" %>><%=i+1 %></option>
	    							<%
	    								}
	    							 %>
	    						</select>
	    						页
	    					</td>
	    				</tr>
	    			</tbody>
	    		</table>
	    	</form>
	    	<%
	    		}
	    	 %>
	    </div>
    <%
    	}
    	else
    	{
     %>
     	<div style="padding-bottom:10px;"><%=name+" 在 "+start+"至"+end+"时间段内的没有任何操作记录！" %></div>
     <%
     	}
      %>
	 </div>
  </body>
</html>
