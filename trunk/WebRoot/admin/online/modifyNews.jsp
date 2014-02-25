<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="liftingmagnet.com.db.dao.News" %>
<%@page import="net.fckeditor.FCKeditor"%>
<%@page import="liftingmagnet.com.usermanage.*"%>
<%@page import="java.io.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	User user = (User)session.getAttribute("user");
	Authority limits = user.getLimits();
	if (!limits.canModifyNews())
	{
		%>
  		<jsp:include page="noPermission.jsp"></jsp:include>
		<%
		return;
	}
	
	session.setAttribute("manage_command","news");
	
	String idString = request.getParameter("id");
	int id = -1;
	try
	{
		id = Integer.parseInt(idString);
	}
	catch(Exception e)
	{}
	
	News news = News.getNews(id);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath+"admin/online/"%>">
    
    <title>岳阳强力电磁有限公司---修改新闻</title>
    
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
	</style>
	<script type="text/javascript" src="../../js/prototype-1.6.0.3.js"></script>
	<script type="text/javascript" src="../../js/iframe_auto_height.js"></script>
	<script type="text/javascript" src="../js/basic.js"></script>
	<script type="text/javascript">
		window.onload = function(){
			Event.observe($("modify_news_form"),"submit",check_valid);
			update_iframe_height();
			parent.setLocation("修改新闻");
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
		
		function callback(status,id)
		{
			if (status==0)
			{
				alert("修改成功！");
				window.location.href = "viewNews.jsp?id="+id;
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
				alert("对不起，修改出错！");
			}
		}
	</script>
  </head>
  
  <body>
  	<%
  		if (news!=null)
  		{
  	 %>
  	<form action="modifynews" id="modify_news_form" method="post" target="modify_news_hidden">
  	<input type="hidden" name="id" value="<%=news.getId() %>">
  	<div class="top_div">
  		<div style="color:blue;font-weight:bold;">新闻标题</div>
  		<div style="margin:5px 0px 5px 30px;"><%=news.getTitle() %></div>
  		<div style="color:blue;font-weight:bold;">新闻内容</div>
  		<div style="margin: 5px 0px 10px 30px;border:solid 1px #3b97d9;">
		    <%
		    	File file = new File(application.getRealPath(news.getPath()));
		    	BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file)));
		    	StringBuffer sb = new StringBuffer();
		    	String line = br.readLine();
		    	while (line!=null)
		    	{
		    		sb.append(line);
		    		line = br.readLine();
		    	}
		    	br.close();
		    	
		    	FCKeditor editor = new FCKeditor(request,"news");
		    	editor.setBasePath("/admin/online/fckeditor");
		    	editor.setToolbarSet("MySite");
		    	editor.setWidth("608px");
		    	editor.setHeight("400px");
		    	editor.setValue(sb.toString());
		    	out.write(editor.toString());
		     %>
  		</div>
  		<div>
  			<input type="submit" value="保存" style="margin-left:250px;">
  			<input type="reset" value="重置" style="margin-left:30px;">
  		</div>
  	</div>
  	</form>
  	<iframe name="modify_news_hidden" width="0px" height="0px" frameborder="0" scrolling="no"></iframe>
 	<%
 		}
 		else
 		{
 	 %>
 	 <div>您查找的新闻不存在！</div>
 	 <%
 		 }
 	 %>
  </body>
</html>
