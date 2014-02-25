<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="liftingmagnet.com.usermanage.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	User user = (User)session.getAttribute("user");
	Authority limits = user.getLimits();
	if (!(limits.canAddProduct()||limits.canModifyProduct()))
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
    
    <title>岳阳强力电磁有限公司---为新产品指定主图片</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
  </head>
  
  <body style="padding:0px;margin:0px;">
     <form id="form_1" style="padding:20px 10px;margin:0px;" method="post" action="uploadimg" enctype="multipart/form-data">
	    <span style="font-size:12px;">图片路径：</span>
	    <input type="file" name="img">
	    <input type="submit" value="上传">
     </form>
  </body>
</html>
