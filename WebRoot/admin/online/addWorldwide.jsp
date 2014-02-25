<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="liftingmagnet.com.usermanage.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	User user = (User)session.getAttribute("user");
	Authority limits = user.getLimits();
	if (!limits.canManageWorldwide())
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
    
    <title>岳阳强力电磁有限公司---添加代理商</title>
    
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
			width: 300px;
			text-align: left;
		}
	</style>
	<script type="text/javascript" src="../../js/prototype-1.6.0.3.js"></script>
	<script type="text/javascript" src="../../js/iframe_auto_height.js"></script>
	<script type="text/javascript" src="../js/basic.js"></script>
	<script type="text/javascript" src="js/addworldwide.js"></script>
	<script type="text/javascript">
		window.onload = function(){
			Event.observe($("addworldwide_form"),"submit",check_valid);
			update_iframe_height();
			parent.setLocation("添加新代理商");
			$("area").focus();
		};
	</script>
  </head>
  
  <body>
    <div class="top_div">
    	<div style="padding-bottom:10px;font-weight:bold;">新代理商信息</div>
    <form action="addworldwide" method="post" target="add_worldwide_hidden" id="addworldwide_form">
	    	<table>
	    		<tbody>
	    			<tr>
	    				<td>代理区域：</td><td><input class="text_input" type="text" name="area" id="are"><font color="red">*</font></td>
	    			</tr>
	    			<tr>
	    				<td>代理商名称：</td><td><input class="text_input" type="text" name="agent" id="agent"><font color="red">*</font></td>
	    			</tr>
	    		</tbody>
	    	</table>
    		<div>
    			<input type="submit" value="添加" style="margin: 5px 20px 10px;">
    			<input type="reset" value="重置" style="margin: 5px 20px 10px;">
    		</div>
    	</form>
    </div>
    <iframe name="add_worldwide_hidden" width="0px" height="0px" frameborder="0" scrolling="no"></iframe>
  </body>
</html>
