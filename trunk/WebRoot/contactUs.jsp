<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="liftingmagnet.com.app.*" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	ContactInfo contactInfo = (ContactInfo)application.getAttribute("contact_info");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath %>">
    
    <title><%=contactInfo.getCompanyName() %>---Contact Us</title>
    
	<meta http-equiv="keywords" content="岳阳强力,强力电磁,lifting,magnet,lifting magnet,electromagnet,yue yang,yueyang">
	<meta http-equiv="description" content="">
	
	<link rel="stylesheet" type="text/css" href="css/basic_style.css">
	<style type="text/css">
		body
		{
			margin: 10px;
			padding: 0px;
			text-align: center;
			background-color: #f3f3f3;
			color: #09257e;
		}
		.fix_auto
		{
			margin: 0px auto;
			text-align: left;
			width: 616px;
		}
		.contact_title
		{
			font-size: 13px;
			font-weight: bold;
		}
	</style>
	<script type="text/javascript" src="js/iframe_auto_height.js"></script>
	<script type="text/javascript">
		window.onload = function(){
			update_iframe_height();
			parent.setLocation("&nbsp;<a href='contactUs.jsp'>Contact Us</a>&nbsp;&gt;");
		};
	</script>

	<jsp:include page="hfoot.jsp"></jsp:include>
  </head>
  
  <body>
    <div class="fix_auto">
    	<div>
    		<img src="images/map.gif">
    	</div>
    	<div style="padding-left:50px;margin:10px 0px;">
    		Notes:
    		<ul style="padding-top:0px;margin-top:0px;">
    			<li>Now From Changsha airport to our facility only takes 1.5 hours by car.</li>
    			<li>From Wuhan airport to our facility only takes 2.5 hours by car.</li>
    		</ul>
    	</div>
    	<div style="margin-left:50px;border:solid 1px gray;padding:5px 10px;width:460px;*width:480px;">
    		<table>
    			<tbody>
    				<tr><td width="80px"><span class="contact_title">Address:</span></td><td><%=contactInfo.getAddress() %></td></tr>
    				<tr><td width="80px"><span class="contact_title">Postcode:</span></td><td><%=contactInfo.getPostcode() %></td></tr>
    				<tr><td width="80px"><span class="contact_title">TEL:</span></td><td><%=contactInfo.getPhone1() %>&nbsp;&nbsp;<%=contactInfo.getPhone2() %></td></tr>
    				<tr><td width="80px"><span class="contact_title">FAX:</span></td><td><%=contactInfo.getFax1() %>&nbsp;&nbsp;<%=contactInfo.getFax2() %></td></tr>
    				<tr><td width="80px"><span class="contact_title">Email:</span></td><td><a href="mailto:<%=contactInfo.getEmail() %>" title="mailto:<%=contactInfo.getEmail() %>"><%=contactInfo.getEmail() %></a></td></tr>
    				<tr><td width="80px"><span class="contact_title">MSN:</span></td><td><a href="mailto:<%=contactInfo.getMsn1() %>" title="mailto:<%=contactInfo.getMsn1() %>"><%=contactInfo.getMsn1() %></a></td></tr>
    				<tr><td width="80px"><span class="contact_title">Skype:</span></td><td>starwang11287</td></tr>
    			</tbody>
    		</table>
	  	</div>
    </div>
	<jsp:include page="foot.jsp"></jsp:include>
  </body>
</html>
