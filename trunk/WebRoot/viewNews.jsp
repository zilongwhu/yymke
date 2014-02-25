<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="liftingmagnet.com.app.*" %>
<%@page import="liftingmagnet.com.db.dao.News" %>
<%@page import="java.util.Vector"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	ContactInfo contactInfo = (ContactInfo)application.getAttribute("contact_info");
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
    <base href="<%=basePath%>">
    
    <title><%=contactInfo.getCompanyName() %>---<%=news==null?"sorry":news.getTitle() %></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	
	<link rel="stylesheet" type="text/css" href="css/basic_style.css">
	<style type="text/css">
		body
		{
			margin: 10px;
			padding: 0px;
			text-align: center;
			background-color: #f3f3f3;
		}
	
		.top_div
		{
			margin: 0px auto;
			width: 616px;
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
	<script type="text/javascript" src="js/iframe_auto_height.js"></script>
	<script type="text/javascript">
		window.onload = function(){
			update_iframe_height();
			parent.setLocation("&nbsp;<a href='news.jsp'>News</a>&nbsp;&gt;");
		};
	</script>
	<jsp:include page="hfoot.jsp"></jsp:include>
  </head>
  
  <body>
  	<div class="top_div">
  		<%
  			if (news!=null)
  			{
  				Vector<Integer> vNews = (Vector<Integer>)session.getAttribute("viewed");
  				if (vNews==null)
  				{
  					vNews = new Vector<Integer>();
  					session.setAttribute("viewed",vNews);
  				}
  				boolean viewed = false;
  				for (int i=0;i<vNews.size();i++)
  				{
  					if (vNews.get(i)==id)
  					{
  						viewed = true;
  						break;
  					}
  				}
  				if (!viewed)
  				{
  					vNews.add(new Integer(id));
  					News.increment(id);
  					news.setViewedNums(news.getViewedNums()+1);
  				}
  		 %>
  		<div class="news_title"><%=news.getTitle() %></div>
  		<div class="news_abstract">
  			Admin：<span class="news_abstract_key"><%=news.getAuthor() %></span>
  			Time：<span class="news_abstract_key"><%=news.getSubmitDate() %></span>
  			Viewed Nums：<span class="news_abstract_key"><%=news.getViewedNums() %></span>
  		</div>
  		<div class="news_content">
  			<jsp:include page="<%=news.getPath() %>"></jsp:include>
  		</div>
  		<%
  			}
  			else
  			{
  		 %>
  		 <div>Sorry, the news you are looking for is not existing now!</div>
  		 <%
  		 	}
  		  %>
  	</div>
	<jsp:include page="foot.jsp"></jsp:include>
  </body>
</html>
