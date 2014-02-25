<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="liftingmagnet.com.usermanage.*" %>
<%@page import="liftingmagnet.com.db.dao.News" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	User user = (User)session.getAttribute("user");
	Authority limits = user.getLimits();
	
	String idString = request.getParameter("id");
	int id = -1;
	try
	{
		id = Integer.parseInt(idString);
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	
	News news = News.getNews(id);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath+"admin/online/"%>">
    
    <title>岳阳强力电磁有限公司---新闻详细信息</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	
	<link rel="stylesheet" type="text/css" href="css/basic.css">
	<style type="text/css">
		body
		{
			text-align: center;
			width: 660px;
		}
		
		.top_div
		{
			margin: 0px auto;
			width: 620px;
			text-align: left;
		}
		
		.news_title
		{
			color: #03005c;
			font-weight: bold;
			font-size: 16px;
			text-align: center;
			margin: 20px 0px;
		}
		
		.news_operations
		{
			padding: 2px 0px;
			text-align: right;
		}
		
		.news_abstract
		{
			padding: 5px 10px;
			border-top: solid 1px #3b97d9;
			text-align: center;
		}
		
		.news_abstract_key
		{
			padding: 0px 10px;
			color: red;
		}
		
		.news_content
		{
			padding: 5px 10px;
		}
	</style>
	<script type="text/javascript" src="../../js/iframe_auto_height.js"></script>
	<script type="text/javascript">
		window.onload = function(){
			update_iframe_height();
			parent.setLocation("新闻详细信息");
		};
	</script>
  </head>
  
  <body>
  	<div class="top_div">
  		<%
  			if (news!=null)
  			{
  		 %>
  		<div class="news_title"><%=news.getTitle() %></div>
  		<div class="news_operations">
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
  		</div>
  		<div class="news_abstract">
  			发布人：<span class="news_abstract_key"><%=news.getAuthor() %></span>
  			发布时间：<span class="news_abstract_key"><%=news.getSubmitDate() %></span>
  			被阅览次数：<span class="news_abstract_key"><%=news.getViewedNums() %></span>
  		</div>
  		<div class="news_content">
  			<jsp:include page="<%=news.getPath() %>"></jsp:include>
  		</div>
  		<%
  			}
  			else
  			{
  		 %>
  		 <div>您查找的新闻不存在！</div>
  		 <%
  		 	}
  		  %>
  	</div>
  </body>
</html>
