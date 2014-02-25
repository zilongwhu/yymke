<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="net.fckeditor.FCKeditor"%>
<%@page import="liftingmagnet.com.usermanage.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	User user = (User)session.getAttribute("user");
	Authority limits = user.getLimits();
	if (!limits.canAddProduct())
	{
		%>
  		<jsp:include page="noPermission.jsp"></jsp:include>
		<%
		return;
	}
	
	session.setAttribute("manage_command","products");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath+"admin/online/"%>">
    
    <title>岳阳强力电磁有限公司---添加新产品</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	
	<link rel="stylesheet" type="text/css" href="css/basic.css">
	<link rel="stylesheet" type="text/css" href="css/addproduct.css">
	<script type="text/javascript" src="../../js/prototype-1.6.0.3.js"></script>
	<script type="text/javascript" src="../../js/iframe_auto_height.js"></script>
	<script type="text/javascript" src="../js/basic.js"></script>
	<script type="text/javascript" src="js/addproduct.js"></script>
	<script type="text/javascript">
		var parent_ids = [];
		var index = -1;
		
		window.onload = function(){
			window.setInterval(update_iframe_height,100);
			parent.setLocation("添加新产品");
			document.getElementById("name").focus();
			Event.observe($("add_product_form"),"submit",check_valid);
			init();
		};
		
		function check_valid(evt)
		{
			var name = getInputValue("name");
			if (name.length==0)
			{
				Event.stop(evt);
				alert("名称没有填写！");
				$("name").focus();
				return;
			}
			if ($("type_0").checked)
			{
				var path = getInputValue("img_path");
				if (path.length==0)
				{
					Event.stop(evt);
					alert("没有为产品指定主图片！");
					return;
				}
				var features = getInputValue("features");
				if (features.length==0)
				{
					Event.stop(evt);
					alert("没有输入产品特征描述信息！");
					$("features").focus();
					return;
				}
			}
		}
		
		function callback(status)
		{
			if (status==1)
			{
				alert("产品详细信息必须填写！");
			}
		}
	</script>

  </head>
  
  <body>
    <form action="addproduct" method="post" id="add_product_form">
  	<div class="top_div">
  		<div class="header">类型</div>
  		<div style="margin:5px 0px 5px 30px;">
  			<input type="radio" name="type" value="0" checked id="type_0" onclick="toggle_type();"><label for="type_0">产品</label>
  			<input type="radio" name="type" value="1" id="type_1" onclick="toggle_type();"><label for="type_1">介绍信息</label>
  		</div>
  		<div class="header">名称</div>
  		<div style="margin:5px 0px 5px 30px;"><input class="text_input_big" type="text" id="name" name="name"></div>
  		<div class="header">所属分类</div>
	  	<div style="margin:5px 0px 5px 30px;" id="product_type"></div>
	  	<div id="type_selector">
	  		<div class="header">产品主图片</div>
	  		<div style="margin:5px 0px 5px 30px;position:relative;width:600px;">
	  			<input type="hidden" name="img_path" id="img_path">
	  			<input type="text" class="text_input_big" disabled id="img_path2"><input style="margin-left:15px;width:40px;" type="button" value="上传" onclick="upload_img();">
	  			<input style="margin-left:15px;width:40px;" disabled type="button" value="预览" onclick="preview_image();" id="preview_button">
	  			<div id="preview" style="position:absolute;right:30px;top:0px;display:none;border:solid 1px gray;padding:2px;background-color:white;*padding-bottom:1px;">
	  				<img id="preview_img" src="" width="130px" height="130px" border="0">
	  			</div>
	  		</div>
	  		<div class="header">特征描述</div>
	  		<div style="margin:5px 0px 5px 30px;">
	  			<textarea name="features" id="features" style="width:480px;height:80px;border:solid 1px #3b97d9;font-size:12px;"></textarea>
	  		</div>
	  		<div class="header">附加设置</div>
	  		<div style="margin:5px 0px 5px 30px;">
	  			<input type="checkbox" name="promoted" value="yes" id="promoted" style="margin-right:10px;"><label for="promoted"><font color="blue">强烈推荐产品</font></label>
	  			<input type="checkbox" name="homepage" value="yes" id="homepage" style="margin-left:30px;margin-right:10px;"><label for="homepage"><font color="blue">将产品放置在首页</font></label>
	  			<select style="margin-left:55px;" name="year">
	  			<%
	  				int year = java.util.Calendar.getInstance().getTime().getYear() + 1900;
	  				for (int i=1996;i<2050;i++)
	  				{
	  			 %>
	  				<option value="<%=i %>" <%=i==year?"selected":"" %>><%=i %></option>
	  			<%
	  				}
	  			%>
	  			</select>
	  			<font color="blue">年</font>
	  			<select name="month">
	  			<%
	  				int month = java.util.Calendar.getInstance().getTime().getMonth()+1;
	  				for (int i=1;i<13;i++)
	  				{
	  			 %>
	  				<option value="<%=i %>" <%=i==month?"selected":"" %>><%=i %></option>
	  			<%
	  				}
	  			%>
	  			</select>
	  			<font color="blue">月上市</font>
	  		</div>
  		</div>
  		<div class="header">详细内容</div>
  		<div style="margin: 5px 0px 10px 30px;border:solid 1px #3b97d9;">
		    <%
		    	FCKeditor editor = new FCKeditor(request,"content");
		    	editor.setBasePath("/admin/online/fckeditor");
		    	editor.setToolbarSet("MySite");
		    	editor.setHeight("560px");
		    	editor.setWidth("608px");
		    	out.write(editor.toString());
		     %>
  		</div>
  		<div>
  			<input type="submit" value="添加" style="margin-left:250px;">
  			<input type="reset" value="重置" style="margin-left:30px;">
  		</div>
  	</div>
  	</form>
  </body>
</html>
