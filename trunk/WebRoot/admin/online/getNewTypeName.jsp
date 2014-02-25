<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="liftingmagnet.com.usermanage.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	User user = (User)session.getAttribute("user");
	Authority limits = user.getLimits();
	if (!limits.canManageProductList())
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
    
    <title>岳阳强力电磁有限公司---添加新的产品类型</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	
	<script type="text/javascript" src="../js/basic.js"></script>
	<script type="text/javascript" src="../../js/prototype-1.6.0.3.js"></script>
	
	<script type="text/javascript">
		window.onload = function()
		{
			Event.observe($("form_1"), "submit", ok);
			$("type").focus();
		};
		
		function ok(evt)
		{
			Event.stop(evt);
			var type = getInputValue("type");
			if (type.length!=0)
			{
				opener.add_new_type(type);
				window.close();
			}
		}
	</script>
  </head>
  
  <body style="padding:0px;margin:0px;">
     <form id="form_1" style="padding:20px 10px;margin:0px;">
	    <span style="font-size:12px;">输入新类型名称：</span>
	    <input type="text" style="width:150px;border:solid 1px #3b97d9;" id="type">
	    <input type="submit" value="添加">
     </form>
  </body>
</html>
