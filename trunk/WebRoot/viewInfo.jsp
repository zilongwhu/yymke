<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="liftingmagnet.com.app.*" %>
<%@page import="liftingmagnet.com.db.dao.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

ContactInfo contactInfo = (ContactInfo)application.getAttribute("contact_info");
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
Catalog catalog = Catalog.getFullInfoById(idValue);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
	<base target="stage">

    <title><%=contactInfo.getCompanyName() %>---<%=catalog==null?"sorry":catalog.getName() %></title>
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
    	if (catalog==null||catalog.getType()!=1)
    	{
     %>
     	Sorry, the introduction information you looking for is not existing now!
     <%
     	}
     	else
     	{
      %>
      	<div class="name">
      		<%=catalog.getName() %>
      	</div>
      	<div class="location">
      		Location:&nbsp;Introductions/<%=Catalog.getLocation(catalog.getId(),"/") %>
      	</div>
      	<jsp:include page="<%=Catalog.getIntroductionPath(catalog.getTarget()) %>"></jsp:include>
      <%
      	}
       %>
	<jsp:include page="foot.jsp"></jsp:include>
  </body>
</html>
