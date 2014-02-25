<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="liftingmagnet.com.usermanage.*" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath+"admin/online/"%>">
    <base target="stage">
    
    <title>岳阳强力电磁有限公司欢迎您！</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	
	<link rel="stylesheet" type="text/css" href="css/basic.css">
	<link rel="stylesheet" type="text/css" href="css/style.css">
	
	<script type="text/javascript" src="js/hide_show.js"></script>

  </head>
  <%
  	User user = (User)session.getAttribute("user");
  	Authority limits = user.getLimits();
   %>
  <body>
    <div class="top_div">
    	<div class="operations">
    		<div class="operation">
	    		<div class="header">
	    			<div class="show" id="header_self_info" title="展开" onclick="hide_show('header_self_info');"> 
	    				欢迎您,&nbsp;<%=user.getName() %>！
	    			</div>
	    		</div>
	    		<div class="content" id="content_self_info" style="display:none;">
	    			<ul>
	    				<li><a href="authority.jsp">查看操作权限</a></li>
	    				<li><a href="changePassword.jsp">修改登录密码</a></li>
	    				<li><a href="logout" target="_top">退出登录</a></li>
	    			</ul>
	    		</div>
    		</div>
    		<% 
    			if (limits.canAddUser()||limits.canModifyUser()||limits.canDeleteUser()||limits.canSupervise())
    			{
    		 %>
    		<div class="operation">
	    		<div class="header">
	    			<div class="hide" id="header_employee" title="折叠" onclick="hide_show('header_employee');">
	    				员工账号管理 
	    			</div>
	    		</div>
	    		<div class="content" id="content_employee" >
	    			<ul>
	    				<%	
	    					if (limits.canAddUser())
	    					{
	    				%>
	    				<li><a href="addUser.jsp">添加新员工</a></li>
	    				<%
	    					}
	    					if (limits.canModifyUser()||limits.canDeleteUser())
	    					{
	    				 %>
	    				<li><a href="users.jsp"><%=limits.canModifyUser()?"修改":""%><%=limits.canDeleteUser()?"/删除":""%>员工</a></li>
	    				<%
	    					}
	    					if (limits.canSupervise())
	    					{
	    				 %>
	    				<li><a href="log.jsp" title="监督员工对公司网站的操作">员工历史操作浏览</a></li>
	    				<%
	    					}
	    				 %>
	    			</ul>
	    		</div>
    		</div>
    		<%
    			}

    			if (limits.canAddNews()||limits.canModifyNews()||limits.canDeleteNews())
    			{
    		 %>
    		<div class="operation">
	    		<div class="header">
	    			<div class="hide" id="header_news" title="折叠" onclick="hide_show('header_news');">
	    				新闻管理
	    			</div>
	    		</div>
	    		<div class="content" id="content_news">
	    			<ul>
	    				<%	
	    					if (limits.canAddNews())
	    					{
	    				%>
	    				<li><a href="addNews.jsp">添加新闻</a></li>
	    				<%
	    					}
	    					if (limits.canModifyNews()||limits.canDeleteNews())
	    					{
	    				 %>
	    				<li><a href="news.jsp"><%=limits.canModifyNews()?"修改":""%><%=limits.canDeleteNews()?"/删除":""%>新闻</a></li>
	    				<%
	    					}
	    				 %>
	    			</ul>
	    		</div>
    		</div>
    		<%
    			}
    		 	
    		 	if (limits.canAddProduct()||limits.canModifyProduct()||limits.canDeleteProduct())
    			{
    		 %>
    		<div class="operation">
	    		<div class="header">
	    			<div class="hide" id="header_product" title="折叠" onclick="hide_show('header_product');">
	    				产品管理
	    			</div>
	    		</div>
	    		<div class="content" id="content_product">
	    			<ul>
	    				<%	
	    					if (limits.canManageProductList())
	    					{
	    				%>
	    				<li><a href="manageProductList.jsp" title="维护公司首页产品列表">管理产品列表</a></li>
	    				<%	
	    					}
	    					if (limits.canAddProduct())
	    					{
	    				%>
	    				<li><a href="addProduct.jsp">添加新产品</a></li>
	    				<%
	    					}
	    					if (limits.canModifyProduct()||limits.canDeleteProduct())
	    					{
	    				 %>
	    				<li><a href="products.jsp"><%=limits.canModifyProduct()?"修改":""%><%=limits.canDeleteProduct()?"/删除":""%>产品</a></li>
	    				<%
	    					}
	    				 %>
	    			</ul>
	    		</div>
    		</div>
    		<%
    			}
    		 	
    		 	if (limits.canAddAchievement()||limits.canModifyAchievement()||limits.canDeleteAchievement())
    			{
    		 %>
    		<div class="operation">
	    		<div class="header">
	    			<div class="hide" id="header_achievements" title="折叠" onclick="hide_show('header_achievements');">
	    				业绩表管理
	    			</div>
	    		</div>
	    		<div class="content" id="content_achievements">
	    			<ul>
	    				<%
	    					if (limits.canAddAchievement())
	    					{
	    				 %>
	    				<li><a href="addAchievement.jsp">添加业绩表</a></li>
	    				<%
	    					}
	    					if (limits.canModifyAchievement()||limits.canDeleteAchievement())
	    					{
	    				 %>
	    				<li><a href="achievements.jsp"><%=limits.canModifyAchievement()?"修改":""%><%=limits.canDeleteAchievement()?"/删除":""%>业绩表</a></li>
	    				<%
	    					}
	    				 %>
	    			</ul>
	    		</div>
    		</div>
    		<%
    			}
    		 	
    		 	if (limits.canAnswerFeedback()||limits.canDeleteFeedback())
    			{
    		 %>
    		<div class="operation">
	    		<div class="header">
	    			<div class="hide" id="header_feedback" title="折叠" onclick="hide_show('header_feedback');">
	    				客户反馈信息管理
	    			</div>
	    		</div>
	    		<div class="content" id="content_feedback">
	    			<ul>
	    				<%
	    					if (limits.canAnswerFeedback())
	    					{
	    				 %>
	    				<li><a href="answerFeedback.jsp">回复客户留言</a></li>
	    				<%
	    					}
	    					if (limits.canDeleteFeedback())
	    					{
	    				 %>
	    				<li><a href="deleteFeedback.jsp">删除客户留言</a></li>
	    				<%
	    					}
	    				 %>
	    			</ul>
	    		</div>
    		</div>
    		<%
    			}
    		 	
    		 	if (limits.canManageWorldwide()||limits.canManageContactInfo()||limits.canViewVisitors())
    			{
    		 %>
    		<div class="operation">
	    		<div class="header">
	    			<div class="hide" id="header_company" title="折叠" onclick="hide_show('header_company');">
	    				网站管理
	    			</div>
	    		</div>
	    		<div class="content" id="content_company">
	    			<ul>
	    				<%
	    					if (limits.canViewVisitors())
	    					{
	    				 %>
	    				<li><a href="ipstatistic.jsp">网站访问统计浏览</a></li>
	    				<%
	    					}
	    					if (limits.canManageWorldwide())
	    					{
	    				 %>
	    				<li><a href="worldwides.jsp">全球代理商管理</a></li>
	    				<%
	    					}
	    					if (limits.canManageContactInfo())
	    					{
	    				 %>
	    				<li><a href="contactInfo.jsp">公司联系方式管理</a></li>
	    				<%
	    					}
	    				 %>
	    			</ul>
	    		</div>
    		</div>
    		<%
    			}
    		 %>
    	</div>
    	<script type="text/javascript">
    		function setLocation(msg)
    		{
    			if (navigator.appName.toLowerCase().indexOf("microsoft")>=0)
				{
    				document.getElementById("location").innerText = msg;
				}
				else
				{
    				document.getElementById("location").textContent = msg;
				}
    		}
    	</script>
    	<div class="center">
    		<div class="header">
    			当前位置：<span id="location">我的权限</span>
    		</div>
	    	<div class="content">
	    		<iframe src="authority.jsp" width="660px" id="stage" name="stage" style="margin-right:20px;" frameborder="0">
				</iframe>
	    	</div>
    	</div>
    </div>
  </body>
</html>
