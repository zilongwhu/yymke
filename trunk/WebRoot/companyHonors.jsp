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
    
    <title><%=contactInfo.getCompanyName() %>---Company Honors</title>
    
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
		}
		.fix_auto
		{
			margin: 0px auto;
			text-align: left;
			width: 616px;
		}
		.company_name
		{
			font-size: 20px;
			font-weight: bold;
			padding: 5px 20px;
			border-bottom: solid 1px gray;
		}
		.header
		{
			background: url(images/honors-header.gif) center center no-repeat;
			height: 40px;
			width: 616px;
			overflow-x: hidden;
		}
		.honor_des
		{
			font-size: 13px;
			line-height: 20px;
			color: #09257e;
			text-align: center;
			padding: 5px;
		}
		table.boxer td
		{
			width: 300px;
		}
	</style>
	<script type="text/javascript" src="js/iframe_auto_height.js"></script>
	<script type="text/javascript" src="js/filter.js"></script>
	<script type="text/javascript">
		window.onload = function(){
			update_iframe_height();
			parent.setLocation("&nbsp;<a href='companyHonors.jsp'>Company Honors</a>&nbsp;&gt;");
		};
	</script>

  </head>
  
  <body>
    <div class="fix_auto">
    	<div class="company_name">
    		YUEYANG MINGKE ELECTROMAGNET CO.,LTD
    	</div>
    	<div class="header"></div>
    	<div style="padding:10px;">
    		<table class="boxer" width="600px" cellspacing="0" cellpadding="0">
    			<tbody>
    				<tr>
    					<td>
    						<div><img style="border:solid 1px black;" src="images/honors/yxmyqy.gif"></div>
    						<div class="honor_des">Outstanding Private Enterprises</div>
    					</td>
    					<td>
    						<div><img style="border:solid 1px black;" src="images/honors/sjcxjydw.gif"></div>
    						<div class="honor_des">Top Ten Units of Honest Management</div>
    					</td>
    				</tr>
    				<tr>
    					<td rowspan="2">
    						<div><img style="border:solid 1px black;" src="images/honors/zlxysbz.gif"></div>
    						<div class="honor_des">Quality, the Prestige Double Assurance Demonstration Unit</div>
    					</td>
    					<td>
    						<div><img style="border:solid 1px black;" src="images/honors/zlfwsmy.gif"></div>
    						<div class="honor_des">Satisfying Quality and Service Unit</div>
    					</td>
    				</tr>
    				<tr>
    					<td>
    						<div><img style="border:solid 1px black;" src="images/honors/zxjxgyxh.gif"></div>
    						<div class="honor_des">China Heavy Machinery Industry Association Member Certificate</div>
    					</td>
    				</tr>
    				<tr>
    					<td>
    						<div><img style="border:solid 1px black;" src="images/honors/zlbztx_zh.gif"></div>
    						<div class="honor_des">Quality System Certificate(In Chinese)</div>
    					</td>
    					<td>
    						<div><img style="border:solid 1px black;" src="images/honors/zlbztx_en.gif"></div>
    						<div class="honor_des">Quality System Certificate</div>
    					</td>
    				</tr>
    			</tbody>
    		</table>
 		</div>
    </div>
  </body>
</html>