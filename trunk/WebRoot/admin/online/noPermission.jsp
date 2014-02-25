<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath+"admin/online/"%>">
    
    <title>岳阳强力电磁有限公司---权限不够</title>
    
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
			margin: 10px auto;
			width: 300px;
			text-align: left;
		}
	</style>
	<script type="text/javascript" src="../../js/iframe_auto_height.js"></script>
	<script type="text/javascript">	
		window.onload = function(){
			update_iframe_height();
			parent.setLocation("权限不够");
		};
	</script>
  </head>
   
  <body>
  	<div class="top_div">
    	对不起您的权限不够，请与管理员联系！
    </div>
  </body>
</html>
