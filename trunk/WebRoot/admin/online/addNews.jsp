<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="net.fckeditor.FCKeditor"%>
<%@page import="liftingmagnet.com.usermanage.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	User user = (User)session.getAttribute("user");
	Authority limits = user.getLimits();
	if (!limits.canAddNews())
	{
		%>
  		<jsp:include page="noPermission.jsp"></jsp:include>
		<%
		return;
	}

	session.setAttribute("manage_command","news");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath+"admin/online/"%>">
    
    <title>岳阳强力电磁有限公司---添加新闻</title>
    
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
			width: 640px;
			text-align: left;
		}
		
		.text_input_big
		{
			width: 300px;
			border: solid 1px #3b97d9;
		}
	</style>
	<script type="text/javascript" src="../../js/prototype-1.6.0.3.js"></script>
	<script type="text/javascript" src="../../js/iframe_auto_height.js"></script>
	<script type="text/javascript" src="../js/basic.js"></script>
	<script type="text/javascript">
		window.onload = function(){
			Event.observe($("addnews_form"),"submit",check_valid);
			update_iframe_height();
			parent.setLocation("添加新闻");
			$("name").focus();
		};
		
		function check_valid(evt)
		{
			if (getInputValue("name").length==0)
			{
				Event.stop(evt);
				alert("新闻标题必须填写！");
				$("name").focus();
			}
		}
		
		function callback(status)
		{
			if (status==0)
			{
				alert("添加成功！");
				window.location.href = "news.jsp";
			}
			else if(status==1)
			{
				alert("对不起，您的权限不够，请与管理员联系！");
			}
			else if(status==2)
			{
				alert("新闻内容必须填写！");
			}
			else
			{
				alert("对不起，添加出错！");
			}
		}
	</script>
  </head>
  
  <body>
  	<form action="addnews" method="post" id="addnews_form" target="add_news_hidden">
  	<div class="top_div">
  		<div style="color:blue;font-weight:bold;">新闻标题</div>
  		<div style="margin:5px 0px 5px 30px;"><input class="text_input_big" type="text" id="name" name="title"></div>
  		<div style="color:blue;font-weight:bold;">新闻内容</div>
  		<div style="margin: 5px 0px 10px 30px;border:solid 1px #3b97d9;">
		    <%
		    	FCKeditor editor = new FCKeditor(request,"news");
		    	editor.setBasePath("/admin/online/fckeditor");
		    	editor.setToolbarSet("MySite");
		    	editor.setHeight("400px");
		    	editor.setWidth("608px");
		    	out.write(editor.toString());
		     %>
  		</div>
  		<div>
  			<input type="submit" value="发布" style="margin-left:250px;">
  			<input type="reset" value="重置" style="margin-left:30px;">
  		</div>
  	</div>
  	</form>
  	<iframe name="add_news_hidden" width="0px" height="0px" frameborder="0" scrolling="no"></iframe>
  </body>
</html>
