<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="liftingmagnet.com.app.*" %>
<%@page import="liftingmagnet.com.db.dao.*" %>
<%@page import="java.util.Date" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	ContactInfo contactInfo = (ContactInfo)application.getAttribute("contact_info");
	VisitInfo visitInfo = (VisitInfo)application.getAttribute("visit_info");
	if (visitInfo==null)
	{
		visitInfo = new VisitInfo(request.getRemoteAddr(),new Date(System.currentTimeMillis()),true);
		session.setAttribute("visit_info",visitInfo);
	}
	String id = request.getParameter("id");
	boolean valid = true;
	int idValue = -1;
	if (id==null||(id=id.trim()).length()==0)
	{
		valid = false;
	}
	else
	{
		try
		{
			idValue = Integer.parseInt(id);
		}catch(Exception e){valid = false;}
	}
	if (valid==false)
	{
		return;
	}
	Product product = Product.getProductById(idValue);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
	<base target="stage">

    <title><%=contactInfo.getCompanyName() %>---<%=product==null?"sorry":product.getName() %></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="岳阳强力,强力电磁,lifting,magnet,lifting magnet,electromagnet,yue yang,yueyang">
	<meta http-equiv="description" content="">
	<meta http-equiv="windows-target" content="_top">
	
	<link rel="Shortcut Icon" href="/favicon.ico" type="image/x-icon" />
	<link rel="stylesheet" type="text/css" href="css/product.css">
	<jsp:include page="hfoot.jsp"></jsp:include>
  </head>
  <body>
    <%
    	if (product==null)
    	{
     %>
     	Sorry, the product you are looking for is not existing now!
     <%
     	}
     	else
     	{
      %>
      	<div class="name">
      		<%=product.getName() %>
      	</div>
      	<div class="location">
      		Location:&nbsp;Products/<%=Catalog.getLocation(product.getId(),"/") %>
      	</div>
      	<div class="main">
	      	<div class="features">
		      	<div class="f_h">Features:</div>
		      	<div class="f_b">
		      		<%=product.getFeatures() %>
		      	</div>
	      	</div>
	      	<jsp:include page="<%=product.getPath() %>"></jsp:include>
      	</div>
      <%
      	}
       %>
	<jsp:include page="foot.jsp"></jsp:include>
  </body>
</html>
