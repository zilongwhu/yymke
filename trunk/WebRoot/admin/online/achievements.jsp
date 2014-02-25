<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector" %>
<%@page import="liftingmagnet.com.db.dao.Achievement"%>
<%@page import="liftingmagnet.com.db.dao.Catalog"%>
<%@page import="liftingmagnet.com.usermanage.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	User user = (User)session.getAttribute("user");
	Authority limits = user.getLimits();
	if (!(limits.canDeleteAchievement()||limits.canModifyAchievement()||limits.canAddAchievement()))
	{
		%>
  		<jsp:include page="noPermission.jsp"></jsp:include>
		<%
		return;
	}
	
	String type = request.getParameter("type");
	String pageStr = request.getParameter("page");
	int id = -1;
	int pageIndex = 0;
	try
	{
		id = Integer.parseInt(type);
		pageIndex = Integer.parseInt(pageStr);
	}catch(Exception e){}
	
	Vector<Catalog> cats = Catalog.loadChildsFromDB(-1);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath+"admin/online/"%>">
    
    <title>岳阳强力电磁有限公司---查看业绩表&lt;修改删除&gt;</title>
    
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
			width: 580px;
			text-align: left;
		}
		
		table.blue tr th
		{
			background-color: #efefef;
			height: 30px;
		}
	</style>
	<script type="text/javascript" src="../../js/iframe_auto_height.js"></script>
	<script type="text/javascript">	
		window.onload = function(){
			update_iframe_height();
			parent.setLocation("查看业绩表<修改删除>");
		};
	</script>
  </head>
  
  <body>
    <div class="top_div">
    	<form action="achievements.jsp" id="form">
    		选择要查看的类型：
    		<select name="type" onchange="document.getElementById('form').submit();">
    			<% 
    				int size = cats.size(); 
    				boolean valid = false; 
    				for (int i=0;i<size;i++) 
    				{ 
    					Catalog cat = cats.get(i); 
    					if (cat.getId()==id) 
    					{ 
    						valid=true; 
    					} 
    			%>
    				<option value="<%=cat.getId() %>" <%=cat.getId()==id?"selected":"" %>><%=cat.getName() %></option>
    			<%	
    				}
    				if (!valid)
    				{
    					id = cats.get(0).getId();
    				}
    				
					Vector<Achievement> vas = Achievement.getByType(id);
    			 %>
    		</select>
    	</form>
    	<br>
    	<table class="blue" cellspacing="0" cellpadding="0">
    		<thead>
    			<tr>
    				<th>序号</th>
    				<th>产品名称</th>
    				<th>模型</th>
    				<th>数量</th>
    				<th>目的地</th>
    				<th>交易时间</th>
    			</tr>
    		</thead>
    		<tbody>
    			<%
    				int numsPerPage = 5;
    				size = vas.size();
    				pageIndex = pageIndex<0?0:pageIndex;
 					pageIndex = pageIndex>(size-1)/numsPerPage?(size-1)/numsPerPage:pageIndex;
					int start = pageIndex*numsPerPage;
    				int end = (pageIndex+1)*numsPerPage;
    				start = start>=size?(size-1)/numsPerPage*numsPerPage:start;
    				end = end>size?size:end;
    				for (int i=start;i<end;i++)
    				{
    					Achievement a = vas.get(i);
    					Vector<Object[]> orders = a.getOrders();
    					int rows = orders.size();
    					if (rows>0)
    					{
    						Object[] order = orders.get(0);
    			%>
    				<tr>
    					<td width="30px" align="center" rowspan="<%=rows %>"><%=i+1 %></td>
    					<td width="240px" style="padding:5px;"><a href="/viewProduct.jsp?id=<%=order[0] %>" target="_blank" title="点击查看该产品详细信息"><%=order[1] %></a></td>
    					<td width="80px" align="center" style="padding:5px;"><%=order[2] %></td>
    					<td width="30px" align="center"><%=order[3] %></td>
    					<td width="80px" align="center" rowspan="<%=rows %>"><%=a.getDestination() %></td>
    					<td width="70px" align="center" rowspan="<%=rows %>"><%=a.getDate() %></td>
    					<%
    						if (limits.canModifyAchievement()||limits.canDeleteAchievement())
    						{
    					 %>
    					<td width="30px" align="center" rowspan="<%=rows %>">
    						<div style="padding-bottom:5px;">
    							<a href="modifyAchievement.jsp?id=<%=a.getId() %>">修改</a>
    						</div>
							<div>
    							<a href="deleteachievement?type=<%=id %>&page=<%=pageIndex %>&id=<%=a.getId() %>">删除</a>
    						</div>
						</td>
						<%
							}
						 %>
    				</tr>
    			<%
	    					for (int j=1;j<rows;j++)
	    					{
	    						order = orders.get(j);
    			 %>
		    		<tr>
    					<td width="240px" style="padding:5px;"><a href="/viewProduct.jsp?id=<%=order[0] %>" target="_blank" title="点击查看该产品详细信息"><%=order[1] %></a></td>
    					<td width="80px" align="center" style="padding:5px;"><%=order[2] %></td>
    					<td width="30px" align="center"><%=order[3] %></td>
		    		</tr>
	    		<%
	    					}
	    				}
	    			}
	    		 %>
	    	</tbody>
	    </table>
	    <div style="padding-top:10px;padding-right:10px;">
	    	<%
	    		int pages = size/numsPerPage;
	    		pages = size%numsPerPage!=0?pages+1:pages;
	    		if (pages==1)
	    		{
	    	 %>
	    	 	<div style="text-align:right;margin-top:10px;">总共1页</div>
	    	 <%
	    	 	}
	    	 	else
	    	 	{
	    	  %>
	    	<form action="achievements.jsp" id="go">
	    		<input type="hidden" name="type" value="<%=id %>">
	    		<table align="right">
	    			<tbody>
	    				<tr>
	    					<td>总共<%=pages %>页,当前显示第<%=pageIndex+1 %>页</td>
	    					<td><a href="achievements.jsp?type=<%=id %>&page=0">首页</a></td>
	    					<td>
								<%
									if (pageIndex>0)
									{
								 %>
								 	<a href="achievements.jsp?type=<%=id %>&page=<%=pageIndex-1 %>">上一页</a>
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
								 	<a href="achievements.jsp?type=<%=id %>&page=<%=pageIndex+1 %>">下一页</a>
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
	    					<td><a href="achievements.jsp?type=<%=id %>&page=<%=pages-1 %>">尾页</a></td>
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
    </div>
  </body>
</html>
