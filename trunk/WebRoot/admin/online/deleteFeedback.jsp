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
	if (!limits.canDeleteFeedback())
	{
		%>
  		<jsp:include page="noPermission.jsp"></jsp:include>
		<%
		return;
	}
	
	String pageString = request.getParameter("page");
    int pageIndex = 0;
    int numsPerPage = 2;
    try
    {
    	pageIndex = Integer.parseInt(pageString);
    }catch(Exception e){}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath +"admin/online/"%>">
    
    <title>岳阳强力电磁有限公司---删除反馈信息</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	
	<link rel="stylesheet" type="text/css" href="css/basic.css">
	<style type="text/css">
		body
		{
			margin: 10px;
			padding: 0px;
			text-align: center;
		}
		
		.top_div
		{
			margin: 0px auto;
			text-align: left;
			width: 582px;
		}
		
		.question_h
		{
			font-size: 14px;
			padding: 2px 5px;
			color: blue;
		}
		
		.feedback,.ask_question
		{
			padding: 5px 10px;
			margin: 10px 0px;
			width: 560px;
			*width: 582px;
			border: solid 1px green;
			background-color: #e4eeff;
		}
		
		.question,.answer
		{
			margin-top: 5px;
			border: solid 1px gray;
		}
		
		.question .info,.answer .info
		{
			padding: 2px 5px;
			width: 548px;
			*width: 558px;
			background-color: #bfd4e9;
			border-bottom: dotted 1px gray;
		}
		.content
		{
			padding: 5px 10px;
		}
	</style>
	<script type="text/javascript" src="../../js/iframe_auto_height.js"></script>
	<script type="text/javascript">
		window.onload = function(){
			update_iframe_height();
		};                   
	</script>
  </head>
  <body>
 	<div class="top_div">
 		<%
 			Vector<Feedback> fbs = Feedback.getAll();
 			int size = fbs.size();
 			if (size>0)
 			{
 				pageIndex = pageIndex<0?0:pageIndex;
	 			pageIndex = pageIndex>(size-1)/numsPerPage?(size-1)/numsPerPage:pageIndex;
				int start = pageIndex*numsPerPage;
				int end = (pageIndex+1)*numsPerPage;
				end = end>size?size:end;
	 			for (int i=start;i<end;i++)
	 			{
	 				Feedback fb = fbs.get(i);
 		 %>
 		<div class="feedback">
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
 			</div>
 			<div class="answer">
 				<div class="info">
 					<font color="blue">解答时间:</font> <%=fb.getAnswerTime() %>
 				</div>
 				<div class="content">
 					<jsp:include page="<%=fb.getAnswerPath() %>"></jsp:include>
 				</div>
 			</div>
 			<div style="text-align:right;padding:5px 5px 2px;"><a href="deletefeedback?id=<%=fb.getId() %>&page=<%=pageIndex %>" title="删除该项">删除</a></div>
 		</div>
 		<%
 			}
 		 %>
 		 <div style="padding-top:10px;padding-right:10px;">
	    	<%
	    		int pages = size/numsPerPage;
	    		pages = size%numsPerPage!=0?pages+1:pages;
	    		if (pages==1)
	    		{
	    	 %>
	    	 	<div style="text-align:right;margin-top:10px;">总共1页</div>
	    	 <%
	    	 	}
	    	 	else
	    	 	{
	    	  %>
	    	<form action="deleteFeedback.jsp" id="go">
	    		<table align="right">
	    			<tbody>
	    				<tr>
	    					<td>总共<%=pages %>页,当前显示第<%=pageIndex+1 %>页</td>
	    					<td><a href="deleteFeedback.jsp?page=0">首页</a></td>
	    					<td>
								<%
									if (pageIndex>0)
									{
								 %>
								 	<a href="deleteFeedback.jsp?page=<%=pageIndex-1 %>">上一页</a>
								<%
									}
									else
									{
								 %>
								 	上一页
								<%
									}
								 %>
							</td>
	    					<td>
	    						<%
									if (pageIndex<pages-1)
									{
								 %>
								 	<a href="deleteFeedback.jsp?page=<%=pageIndex+1 %>">下一页</a>
								<%
									}
									else
									{
								 %>
								 	下一页
								<%
									}
								 %>
							</td>
	    					<td><a href="deleteFeedback.jsp?page=<%=pages-1 %>">尾页</a></td>
	    					<td>
	    						跳转到第
	    						<select name="page" onchange="document.getElementById('go').submit();">
	    							<%
	    								for (int i=0;i<pages;i++)
	    								{
	    							 %>
	    							 <option value="<%=i %>" <%=pageIndex==i?"selected":"" %>><%=i+1 %></option>
	    							<%
	    								}
	    							 %>
	    						</select>
	    						页
	    					</td>
	    				</tr>
	    			</tbody>
	    		</table>
	    	</form>
	    	<%
	    		}
	    	 %>
	    </div>
	    <%
	    	}else
 			{
 		 %>
 		 <div style="text-align:center;padding:10px;">目前没有任何待回复的反馈信息！</div>
 		<%
 			}
 		 %>
    </div>
  </body>
</html>
