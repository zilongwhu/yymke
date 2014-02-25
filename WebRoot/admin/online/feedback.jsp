<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="net.fckeditor.FCKeditor"%>
<%@page import="liftingmagnet.com.db.dao.Feedback"%>
<%@page import="liftingmagnet.com.util.StringHelper"%>
<%@page import="liftingmagnet.com.usermanage.*"%>
<%@page import="liftingmagnet.com.db.dao.VisitInfo"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	User user = (User)session.getAttribute("user");
	Authority limits = user.getLimits();
	if (!limits.canAnswerFeedback())
	{
		%>
  		<jsp:include page="noPermission.jsp"></jsp:include>
		<%
		return;
	}
	
	session.setAttribute("manage_command","feedbacks");

	String idString = request.getParameter("id");
	int id = -1;
	try
	{
		id = Integer.parseInt(idString);
	}catch(Exception e){}
	
	Feedback fb = Feedback.getById(id);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath+"admin/online/"%>">
    
    <title>岳阳强力电磁有限公司---回复留言</title>
    
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
		.question
		{
			margin-top: 5px;
			width: 608px;
			border: solid 1px green;
		}
		.info
		{
			padding: 2px 10px;
			width: 588px;
			*width: 608px;
			background-color: #bfd4e9;
			border-bottom: dotted 1px gray;
		}
		.info_1
		{
			padding: 2px 10px;
			background-color: #bfd4e9;
			border-top: dotted 1px gray;
		}
		.content
		{
			padding: 5px 20px;
		}
	</style>
	<script type="text/javascript" src="../../js/iframe_auto_height.js"></script>
	<script type="text/javascript">
		window.onload = function(){
			update_iframe_height();
			parent.setLocation("回复留言");
		};
		
		function callback(status)
		{
			if (status==0)
			{
				alert("回复成功！");
				window.location.href = "answerFeedback.jsp";
			}
			else if(status==1)
			{
				alert("对不起，您的权限不够，请与管理员联系！");
			}
			else if(status==3)
			{
				alert("回复内容必须填写！");
			}
			else
			{
				alert("对不起，回复出错！");
			}
		}
	</script>
  </head>
  
  <body>
  	<form action="answerfeedback" method="post" target="answer_hidden">
  	<input type="hidden" name="id" value="<%=id %>">
  	<div class="top_div">
  		<%
  			if (fb!=null)
  			{
  		 %>
  		<div style="color:blue;font-weight:bold;">反馈信息</div>
  		<div style="margin:5px 0px 5px 30px;">
			<div class="question">
				<div class="info">
					<table width="100%" cellspacing="0" cellpadding="0">
						<tbody>
							<tr><td align="left"><font color="blue">问题来自:</font> <a target="_blank" href="http://www.ip138.com/ips.asp?ip=<%=fb.getIp() %>" title="(参考地址：<%=StringHelper.transform(VisitInfo.getAddr(fb.getIp()),'"',"'")%>)点击到网上查询该IP地址"><%=fb.getIp() %></a> </td><td align="right"><font color="blue">提交时间:</font> <%=fb.getSubmitTime() %></td></tr>
						</tbody>
					</table>
				</div>
				<div class="content">
					<%=fb.getQuestion() %>
				</div>
				<%
					String email = fb.getEmail();
					if (email!=null&&email.length()>0)
					{
				 %>
				<div class="info_1">
					<font color="blue">联系提问者:</font> <a href="mailto: <%=StringHelper.transform(email,'"',"'") %>"><%=email %></a>
				</div>
				<% 
					}
				%>
			</div>
  		</div>
  		<div style="color:blue;font-weight:bold;">回复内容</div>
  		<div style="margin: 5px 0px 10px 30px;border:solid 1px #3b97d9;">
		    <%
		    	FCKeditor editor = new FCKeditor(request,"content");
		    	editor.setBasePath("/admin/online/fckeditor");
		    	editor.setToolbarSet("MySite");
		    	editor.setHeight("400px");
		    	editor.setWidth("608px");
		    	out.write(editor.toString());
		     %>
  		</div>
  		<div>
  			<input type="submit" value="回复" style="margin-left:250px;">
  			<input type="reset" value="重置" style="margin-left:30px;">
  		</div>
  		<%
  			}
  			else
  			{
  		 %>
  		 <div style="text-align:center;">您要找的反馈信息不存在！</div>
  		<%
  			}
  		 %>
  	</div>
  	</form>
  	<iframe name="answer_hidden" width="0px" height="0px" frameborder="0" scrolling="no"></iframe>
  </body>
</html>
