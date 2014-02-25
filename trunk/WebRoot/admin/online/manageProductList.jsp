<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="liftingmagnet.com.usermanage.*" %>
<%@page import="java.util.Vector" %>
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
    
    <title>岳阳强力电磁有限公司---产品列表管理</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	
	<link rel="stylesheet" type="text/css" href="css/basic.css">
	<link rel="stylesheet" type="text/css" href="css/manage_product_list.css">
	<script type="text/javascript" src="../../js/prototype-1.6.0.3.js"></script>
	<script type="text/javascript" src="../../js/iframe_auto_height.js"></script>
	<script type="text/javascript" src="js/manageproductlist.js"></script>
	<script type="text/javascript">
		window.onload = function(){
			setInterval(update_iframe_height,100);
			parent.setLocation("产品列表管理");
		};
	</script>
  </head>
  
  <body>
    <div class="top_div">
    	<% 
    		Vector<Directory> dirs = user.getAllDirectories();
    		request.setAttribute("dirs",dirs);
    	 %>
    	<div style="padding-bottom: 20px;">
    		<div>
    			跳转到
    			<select id="dir" style="width:300px;" onchange="getChilds($F('dir'));">
	    			<jsp:include page="getCatalog.jsp"></jsp:include>
	    		</select>
	    		<a href="javascript:go_to_parent();" style="background: url(images/parent-type.gif) left center no-repeat;padding: 3px 0px 3px 25px;margin-left:10px;">返回上级目录</a>
    			<a href="javascript:get_type_name();" style="background: url(images/create-type.gif) left center no-repeat;padding: 3px 25px;">添加新类型</a>
    		</div>
    	</div>
    	<div style="border:solid 1px gray;background-color:white;">
    		<div style="padding-left:5px;margin:5px;border-bottom:solid 1px gray;"><input type="checkbox" id="select_all" onclick="select_all();check_placeable('moving');"><span style="padding-left:5px;color:blue;"><label for="select_all">全选</label></span><a href="javascript:toggle_select('moving');check_movable('moving');check_placeable('moving');" style="margin-left:10px;" title="反选">反选</a></div>
    		<div id="container">
    			<jsp:include page="getChilds.jsp"></jsp:include>
    		</div>
    	</div>
    	<div style="padding: 20px 0px 5px 0px;">
    	位置：
    		<select id="place_s" disabled style="width:300px;" onchange="place_after();">
    			<jsp:include page="changePosition.jsp"></jsp:include>
    		</select>
    	</div>
    	<div style="padding: 5px 0px;">
    	移动到
    		<select id="move_s" disabled style="width:300px;" onchange="move();">
    			<jsp:include page="getCatalog1.jsp">
    				<jsp:param name="id" value="-1" />
    			</jsp:include>
    		</select>
    	</div>
    </div>
  </body>
</html>
