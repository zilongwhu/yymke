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
    
    <title><%=contactInfo.getCompanyName() %>---Company Equipments</title>
    
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
			background: url(images/equipments-header.gif) center center no-repeat;
			height: 40px;
			width: 616px;
			overflow-x: hidden;
		}
		.equip_des
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
			parent.setLocation("&nbsp;<a href='companyEquipments.jsp'>Company Equipments</a>&nbsp;&gt;");
		};
	</script>

	<jsp:include page="hfoot.jsp"></jsp:include>
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
    					<td valign="top">
    						<div><img style="border:solid 1px black;" src="images/equipments/DSC03177.gif"></div>
    						<div class="equip_des">Planer Type Milling Machine</div>
    					</td>
    					<td valign="top">
    						<div><img style="border:solid 1px black;" src="images/equipments/DSC03178.gif"></div>
    						<div class="equip_des">NC Vertical Lathe</div>
    					</td>
    				</tr>
    				<tr>
    					<td valign="top">
    						<div><img style="border:solid 1px black;" src="images/equipments/DSC03179.gif"></div>
    						<div class="equip_des">Horizontal Lathe</div>
    					</td>
    					<td valign="top">
    						<div><img style="border:solid 1px black;" src="images/equipments/DSC03182.gif"></div>
    						<div class="equip_des">Three Roller Plate Bending Machine</div>
    					</td>
    				</tr>
    				<tr>
    					<td valign="top">
    						<div><img style="border:solid 1px black;" src="images/equipments/DSC03183.gif"></div>
    						<div class="equip_des">Automatic Welding Positioner</div>
    					</td>
    					<td valign="top">
    						<div><img style="border:solid 1px black;" src="images/equipments/DSC03184.gif"></div>
    						<div class="equip_des">Profile NC Cutting Machine</div>
    					</td>
    				</tr>
    				<tr>
    					<td valign="top">
    						<div><img style="border:solid 1px black;" src="images/equipments/DSC03185.gif"></div>
    						<div class="equip_des">Winding Machine</div>
    					</td>
    					<td valign="top">
    						<div><img style="border:solid 1px black;" src="images/equipments/DSC03186.gif"></div>
    						<div class="equip_des">Withstanding Voltage Machine/Voltage Durable Machine</div>
    					</td>
    				</tr>
    			</tbody>
    		</table>
 		</div>
    </div>
	<jsp:include page="foot.jsp"></jsp:include>
  </body>
</html>
