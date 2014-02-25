<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="liftingmagnet.com.app.*" %>
<%@page import="liftingmagnet.com.db.dao.*" %>
<%@page import="java.util.Vector"%>
<%@page import="liftingmagnet.com.util.StringHelper"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	ContactInfo contactInfo = (ContactInfo)application.getAttribute("contact_info");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title><%=contactInfo.getCompanyName() %>---News</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	
	<link rel="stylesheet" type="text/css" href="css/basic_style.css">
	<link rel="stylesheet" type="text/css" href="css/news.css">

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
     <div class="fix_auto">
    <%
    	String pageString = request.getParameter("page");
    	int pageIndex = 0;
    	int numsPerPage = 10;
    	try
    	{
    		pageIndex = Integer.parseInt(pageString);
    	}catch(Exception e){}
    	Vector<News> news = News.getAll();
    	int total = news.size();
    	if (total>0)
    	{
     %>
     	Company News:
     	<div style="padding-left:20px;margin-top:5px;">
	    	<table class="news" cellspacing="0" cellpadding="0">
				<tbody>
					<%
						int start = pageIndex*numsPerPage;
						int end = (pageIndex+1)*numsPerPage;
						end = end>total?total:end;
						for (int i=start;i<end;i++)
						{
							News n = news.get(i);
					 %>
						<tr><td width="530px"><a class="list" href="viewNews.jsp?id=<%=n.getId() %>" title="<%=StringHelper.transform(n.getTitle(),'"',"'") %>"><%=StringHelper.getFristNChars(n.getTitle(),80) %></a></td><td width="80px" align="right"><%=n.getSubmitDate() %></td></tr>
					<%
						}
					 %>
				</tbody>
			</table>
	    </div>
	  <%
			request.setAttribute("numsperpage",new Integer(numsPerPage));
			request.setAttribute("total",new Integer(total));
			request.setAttribute("target","news.jsp");
			request.setAttribute("page",new Integer(pageIndex));
	  %>
		  	<jsp:include page="gotoPage.jsp"></jsp:include>
    <%
    	}
    	else
    	{
     %>
     	<div style="text-align:center;">
     		No any news!
     	</div>
     <%
     	}
      %>
	 </div>
	<jsp:include page="foot.jsp"></jsp:include>
  </body>
</html>
