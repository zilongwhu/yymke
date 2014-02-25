<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="liftingmagnet.com.db.dao.Feedback"%>
<%@page import="liftingmagnet.com.util.StringHelper"%>
<%@page import="liftingmagnet.com.usermanage.*"%>
<%@page import="liftingmagnet.com.db.dao.VisitInfo"%>
<%@page import="java.util.Vector"%>
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
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath+"admin/online/"%>">
    
    <title>岳阳强力电磁有限公司---回复反馈</title>
    
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
			width: 570px;
			text-align: left;
		}
		.question
		{
			margin-top: 5px;
			width: 568px;
			border: solid 1px green;
		}
		.info
		{
			padding: 2px 10px;
			width: 548px;
			*width: 568px;
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
			parent.setLocation("回复反馈");
		};
	</script>
  </head>
  <body>
 	<div class="top_div">
 		<%
 			Vector<Feedback> fbs = Feedback.getAllWaitingForAnswer();
 			int size = fbs.size();
 			if (size>0)
 			{
	 			for (int i=0;i<size;i++)
	 			{
	 				Feedback fb = fbs.get(i);
 		 %>
		<div class="question">
			<div class="info">
				<table width="100%" cellspacing="0" cellpadding="0">
					<tbody>
						<tr><td align="left"><font color="blue">问题来自:</font> <a target="_blank" href="http://www.ip138.com/ips.asp?ip=<%=fb.getIp() %>" title="(参考地址：<%=StringHelper.transform(VisitInfo.getAddr(fb.getIp()),'"',"'")%>)点击到网上查询该IP地址"><%=fb.getIp() %></a></td><td align="right"><font color="blue">提交时间:</font> <%=fb.getSubmitTime() %></td></tr>
					</tbody>
				</table>
			</div>
			<div class="content">
				<%=fb.getQuestion() %>
			</div>
			<div style="text-align:right;padding-right:20px;margin-bottom:5px;">
				<a href="feedback.jsp?id=<%=fb.getId() %>" title="回复该留言">回复</a>
				&nbsp;
				<a href="hiddenfeedback?id=<%=fb.getId() %>" title="屏蔽该留言">屏蔽</a>
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
 		<%
 				}
 			}
 			else
 			{
 		 %>
 		 <div style="text-align:center;padding:10px;">目前没有任何待回复的反馈信息！</div>
 		<%
 			}
 		 %>
    </div>
  </body>
</html>
