<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="liftingmagnet.com.db.dao.*" %>
<%@page import="liftingmagnet.com.usermanage.*" %>
<%@page import="java.util.Vector"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	User user = (User)session.getAttribute("user");
	Authority limits = user.getLimits();
	if (!(limits.canAddNews()||limits.canModifyNews()||limits.canDeleteNews()))
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
    
    <title>岳阳强力电磁有限公司---新闻管理</title>
    
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
			parent.setLocation("查看新闻<修改删除>");
		};
	</script>
  </head>
  
  <body>
     <div class="top_div">
    <%
    	String pageString = request.getParameter("page");
    	int pageIndex = 0;
    	int numsPerPage = 10;
    	try
    	{
    		pageIndex = Integer.parseInt(pageString);
    	}catch(Exception e){}
    	Vector<News> all = News.getAll();
    	int total = all.size();
 		pageIndex = pageIndex<0?0:pageIndex;
 		pageIndex = pageIndex>(total-1)/numsPerPage?(total-1)/numsPerPage:pageIndex;
    	if (total>0)
    	{
     %>
	    <table class="blue">
	    	<thead>
	    		<tr><th>序列</th><th>新闻标题</th><th>发布人</th><th>发布时间</th><th>点击次数</th></tr>
	    	</thead>
	    	<tbody>
	    		<%
			    	for (int i=pageIndex*numsPerPage;i<total&&i<(pageIndex+1)*numsPerPage;i++)
			    	{
			    		News news = all.get(i);
	    		 %>
	    		<tr class="<%=(i-pageIndex*numsPerPage)%2==0?"odd":"even" %>">
	    			<td align="center" width="40px"><%=i+1%></td>
	    			<td align="center" width="300px">
	    				<a href="<%=response.encodeURL("viewNews.jsp?id="+news.getId())%>" title="查看详细内容"><%=news.getTitle() %></a>
	    			</td>
	    			<td align="center" width="80px"><%=news.getAuthor() %></td>
	    			<td align="center" width="80px"><%=news.getSubmitDate() %></td>
	    			<td align="center" width="40px"><%=news.getViewedNums() %></td>
	    			<%
	    				if (limits.canModifyNews()||limits.canDeleteNews())
	    				{
	    			 %>
	    			<td align="center" width="80px">
	    			<%
		    				if (limits.canModifyNews())
		    				{
	    			 %>
	    				<a href="<%=response.encodeURL("modifyNews.jsp?id="+news.getId())%>" title="修改新闻">修改</a>
	    			<%
	    					}
	    			 %>
	    			<%
		    				if (limits.canDeleteNews())
		    				{
	    			 %>
	    				<a href="<%=response.encodeURL("deletenews?id="+news.getId())%>" title="删除新闻">删除</a>
	    			<%
	    					}
	    			 %>
	    			</td>
	    			 <%
	    			 	}
	    			  %>
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
	    	<form action="news.jsp" id="go">
	    		<table align="right">
	    			<tbody>
	    				<tr>
	    					<td>总共<%=pages %>页,当前显示第<%=pageIndex+1 %>页</td>
	    					<td><a href="news.jsp?page=0">首页</a></td>
	    					<td>
								<%
									if (pageIndex>0)
									{
								 %>
								 	<a href="news.jsp?page=<%=pageIndex-1 %>">上一页</a>
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
								 	<a href="news.jsp?page=<%=pageIndex+1 %>">下一页</a>
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
	    					<td><a href="news.jsp?page=<%=pages-1 %>">尾页</a></td>
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
     	<div>
     		目前没有任何新闻！
     		<%
     			if (limits.canAddNews())
     			{
     		 %>
     		<a style="margin-left: 20px;" href="addNews.jsp">添加新闻</a>
     		<%
     			}
     		 %>
     	</div>
     <%
     	}
      %>
	 </div>
  </body>
</html>
