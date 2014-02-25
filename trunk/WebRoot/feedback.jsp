<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="liftingmagnet.com.app.*" %>
<%@page import="liftingmagnet.com.db.dao.Feedback"%>
<%@page import="java.util.Vector"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	ContactInfo contactInfo = (ContactInfo)application.getAttribute("contact_info");

	String pageString = request.getParameter("page");
    int pageIndex = 0;
    int numsPerPage = 5;
    try
    {
    	pageIndex = Integer.parseInt(pageString);
    }catch(Exception e){}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath %>">
    
    <title><%=contactInfo.getCompanyName() %>---Feedback</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	
	<link rel="stylesheet" type="text/css" href="css/basic_style.css">
	<link rel="stylesheet" type="text/css" href="css/feedback.css">
	<script type="text/javascript" src="js/iframe_auto_height.js"></script>
	<script type="text/javascript">
		window.onload = function(){
			update_iframe_height();
			parent.setLocation("&nbsp;<a href='feedback.jsp'>Feedback</a>&nbsp;&gt;");
		};
		
		function reload_auth_img()
		{
		  	document.getElementById("auth_img").src = "/auth_image?type=1&r="+Math.random();
		}
		
		function callback(status)
		{
			if (status==0)
			{
				alert("Ok, we'll answer your question as soon as possible!");
				document.getElementById("add_feedback_form").reset();
			}
			else if (status==1)
			{
				alert("You should type your question first.");
				document.getElementById("question").focus();
			}
			else if (status==2)
			{
				alert("Please describe your question in 1000 characters.");
				document.getElementById("question").focus();
			}
			else if (status==3)
			{
				alert("Validation code must be provided.");
				document.getElementById("code").focus();
			}
			else if (status==4)
			{
				alert("Validation code is wrong. If you cannot see it clearly, click it to change another picture.");
				document.getElementById("code").focus();
			}
			else if (status==5)
			{
				alert("Your question is too short. Please say more about your question.");
				document.getElementById("question").focus();
			}
			else
			{
				alert("Sorry, network error!");
			}
		}
	</script>
	<jsp:include page="hfoot.jsp"></jsp:include>
  </head>
  <body>
 	<div class="fix_auto">
 		<%
 			Vector<Feedback> fbs = Feedback.getAll();
 			int size = fbs.size();
 			if (size>0)
 			{
				int start = pageIndex*numsPerPage;
				int end = (pageIndex+1)*numsPerPage;
				end = end>size?size:end;
	 			for (int i=start;i<end;i++)
	 			{
	 				Feedback fb = fbs.get(i);
	 				String ip = fb.getIp();
	 				ip = ip.substring(0,ip.lastIndexOf('.'))+".*";
 		 %>
 		<div class="feedback">
 			<div class="question">
 				<div class="info">
 					<table width="100%" cellspacing="0" cellpadding="0">
 						<tbody>
 							<tr><td align="left"><font color="blue">Question from:</font> <%=ip %></td><td align="right"><font color="blue">Submit time:</font> <%=fb.getSubmitTime() %></td></tr>
 						</tbody>
 					</table>
 				</div>
 				<div class="content">
 					<%=fb.getQuestion() %>
 				</div>
 			</div>
 			<div class="answer">
 				<div class="info">
 					<font color="blue">Answer time:</font> <%=fb.getAnswerTime() %>
 				</div>
 				<div class="content">
 					<jsp:include page="<%=fb.getAnswerPath() %>"></jsp:include>
 				</div>
 			</div>
 		</div>
 		<%
 				}
				request.setAttribute("numsperpage",new Integer(numsPerPage));
				request.setAttribute("total",new Integer(size));
				request.setAttribute("target","feedback.jsp");
				request.setAttribute("page",new Integer(pageIndex));
	 	 %>
	 	<div style="width:582px;padding-bottom:25px;*padding-bottom:5px;">
	 		<jsp:include page="gotoPage.jsp"></jsp:include>
	 	</div>
	 	<%
	 		}
	 		else
	 		{
	 	 %>
	 	 <div style="margin:10px;text-align:center;">There is no any feedbacks so far!</div>
	 	 <%
	 	 	}
	 	  %>
 		<div class="ask_question">
 			<form action="/addfeedback" target="submit_feedback_form" id="add_feedback_form" method="post">
 				<table class="ask" cellspacing="0" cellpadding="0">
 					<tbody>
 						<tr>
 							<td colspan="3">Your words will help us a lot.(Email is optional.)</td>
 						</tr>
 						<tr>
 							<td valign="top" class="question_h">Question:<br><span style="color:black;font-size:12px;">(in 1000 characters)</span></td>
 							<td><textarea name="question" id="question" style="width:400px;height:100px;border:solid 1px #3b97d9;"></textarea></td>
 							<td valign="top" align="left"><font color="red">*</font></td>
 						</tr>
 						<tr>
 							<td class="question_h">Validation code:</td>
 							<td>
 								<table cellspacing="0" cellpadding="0">
 									<tbody>
 										<tr>
 											<td align="left">
 												<input type="text" name="code" id="code" style="width:50px;border:solid 1px #3b97d9;margin-right: 2px;"><font color="red">*</font>
 											</td>
 											<td align="left">
 												<a href="javascript:reload_auth_img();" title="Can't see it clearly, click to change another one."><img id="auth_img" border="0" src="/auth_image?type=1"></a>
 											</td>
 										</tr>
 									</tbody>
 								</table>
 								</td>
 							<td></td>
 						</tr>
 						<tr>
 							<td class="question_h">Email:</td>
 							<td><input type="text" name="email" style="width:200px;border:solid 1px #3b97d9;">&nbsp;(We cannot contact you without it.)</td>
 							<td></td>
 						</tr>
 						<tr>
 							<td colspan="3" align="center"><input type="submit" value="Send"></td>
 						</tr>
 					</tbody>
 				</table>
 			</form>
 		</div>
    </div>
    <iframe frameborder="0" height="0px" width="0px" name="submit_feedback_form"></iframe>
	<jsp:include page="foot.jsp"></jsp:include>
  </body>
</html>
