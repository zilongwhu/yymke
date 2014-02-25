<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector"%>
<%@page import="liftingmagnet.com.usermanage.*"%>
<%@page import="java.net.URLEncoder"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	User user = (User)session.getAttribute("user");
	Authority limits = user.getLimits();
	if (!(limits.canAddUser()||limits.canModifyUser()||limits.canDeleteUser()))
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
    
    <title>岳阳强力电磁有限公司---员工管理</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	
	<link rel="stylesheet" type="text/css" href="css/basic.css">
	<link rel="stylesheet" type="text/css" href="css/table.css">
	<link rel="stylesheet" type="text/css" href="css/users.css">
	<script type="text/javascript" src="../../js/iframe_auto_height.js"></script>

	<script type="text/javascript">
		window.onload = function(){
			update_iframe_height();
			parent.setLocation("查看员工<修改删除>");
			<%
				Integer status = (Integer)request.getAttribute("delete_status");
				if (status!=null)
				{
					if (status==1)
					{
			%>
				alert("对不起，您的权限不够，请与管理员联系！");
			<%
					}
					else if (status!=0)
					{
			%>
				alert("对不起，删除出错！");
			<%
					}
					request.removeAttribute("delete_status");
				}
			%>
		};
	</script>
  </head>
  <%
  	Vector<User> users = user.getAllUsers();
   %>
  <body>
  	<div class="top_div">
	    <table class="blue">
	    	<thead>
	    		<tr><th>员工名</th><th>操作权限</th></tr>
	    	</thead>
	    	<tbody>
	    		<%
	    			for (int i=0;i<users.size();i++)
	    			{
	    				User u = users.get(i);
	    				limits = u.getLimits();
	    		 %>
	    		<tr class="<%=i%2==0?"odd":"even" %>">
	    			<td><%=u.getName()%></td>
	    			<td>
	    				<div>
	    					<% 
				    			if (limits.canAddUser()||limits.canModifyUser()||limits.canDeleteUser()||limits.canSupervise())
				    			{
	    					 %>
			    			<div class="authority_h">
			    				员工账号管理 
			    			</div>
				    		<div class="authority_c">
				    			<%	
				    				if (limits.canAddUser())
				    				{
				    			%>
				    				添加新员工;
				    			<%
				    				}
				    				if (limits.canModifyUser())
				    				{
				    			%>
				    				修改员工信息;
				    			<%
				    				}
				    				if (limits.canDeleteUser())
				    				{
				    			%>
				    				删除员工;
				    			<%
				    				}
				    				if (limits.canSupervise())
				    				{
				    			%>
				    				员工历史操作浏览;
				    			<%
				    				}
				    			%>
			    			</div>
				    		<%
				    			}
				
				    			if (limits.canAddNews()||limits.canModifyNews()||limits.canDeleteNews())
				    			{
				    		 %>
	    					<div class="authority_h">
			    				新闻管理 
			    			</div>
				    		<div class="authority_c">
				    			<%	
				    				if (limits.canAddNews())
				    				{
				    			%>
				    				添加新闻;
				    			<%
				    				}
				    				if (limits.canModifyNews())
				    				{
				    			%>
				    				修改新闻;
				    			<%
				    				}
				    				if (limits.canDeleteNews())
				    				{
				    			%>
				    				删除新闻;
				    			<%
				    				}
				    			%>
			    			</div>
				    		<%
				    			}
				    		 	
				    		 	if (limits.canAddProduct()||limits.canModifyProduct()||limits.canDeleteProduct()||limits.canManageProductList())
				    			{
				    		 %>
	    					<div class="authority_h">
			    				产品管理 
			    			</div>
				    		<div class="authority_c">
				    			<%	
				    				if (limits.canAddProduct())
				    				{
				    			%>
				    				添加新产品;
				    			<%
				    				}
				    				if (limits.canModifyProduct())
				    				{
				    			%>
				    				修改产品信息;
				    			<%
				    				}
				    				if (limits.canDeleteProduct())
				    				{
				    			%>
				    				删除产品;
				    			<%
				    				}
				    				if (limits.canManageProductList())
				    				{
				    			%>
				    				管理产品列表;
				    			<%
				    				}
				    			%>
			    			</div>
				    		<%
				    			}
				    		 	
				    		 	if (limits.canAddAchievement()||limits.canModifyAchievement()||limits.canDeleteAchievement())
				    			{
				    		 %>
	    					<div class="authority_h">
			    				业绩表管理 
			    			</div>
				    		<div class="authority_c">
				    			<%	
				    				if (limits.canAddAchievement())
				    				{
				    			%>
				    				添加业绩表;
				    			<%
				    				}
				    				if (limits.canModifyAchievement())
				    				{
				    			%>
				    				修改业绩表;
				    			<%
				    				}
				    				if (limits.canDeleteAchievement())
				    				{
				    			%>
				    				删除业绩表;
				    			<%
				    				}
				    			%>
			    			</div>
				    		<%
				    			}
				    		 	
				    		 	if (limits.canAnswerFeedback()||limits.canDeleteFeedback())
				    			{
				    		 %>
	    					<div class="authority_h">
			    				客户反馈信息管理 
			    			</div>
				    		<div class="authority_c">
				    			<%	
				    				if (limits.canAnswerFeedback())
				    				{
				    			%>
				    				回复客户留言;
				    			<%
				    				}
				    				if (limits.canDeleteFeedback())
				    				{
				    			%>
				    				删除客户留言;
				    			<%
				    				}
				    			%>
			    			</div>
				    		<%
				    			}
				    		 	
				    		 	if (limits.canManageWorldwide()||limits.canManageContactInfo()||limits.canViewVisitors())
				    			{
				    		 %>
	    					<div class="authority_h">
			    				网站管理 
			    			</div>
				    		<div class="authority_c">
				    			<%	
				    				if (limits.canManageWorldwide())
				    				{
				    			%>
				    				代理商管理;
				    			<%
				    				}
				    				if (limits.canManageContactInfo())
				    				{
				    			%>
				    				公司联系地址管理;
				    			<%
				    				}
				    				if (limits.canViewVisitors())
				    				{
				    			%>
				    				网站访问统计浏览;
				    			<%
				    				}
				    			%>
			    			</div>
				    		<%
				    			}
				    		 %>
	    				</div>
	    			</td>
	    			<%
	    				if ( user.getLimits().canModifyUser()||user.getLimits().canDeleteUser())
	    				{
	    			 %>
	    			<td>
	    				<%
	    					String encodeName = URLEncoder.encode(u.getName(),"UTF-8");
	    					if ( user.getLimits().canModifyUser())
	    					{
	    				%>
	    					<a href="<%=response.encodeURL("modifyUser.jsp?name=" + encodeName)%>" title="修改<<%=u.getName()%>>的权限" style="margin:0px 5px;">修改</a>
	    				<%
	    					}
	    					if ( user.getLimits().canDeleteUser())
	    					{
	    				 %>
	    				 	<a href="<%=response.encodeURL("deleteuser?name=" + encodeName)%>" title="删除<<%=u.getName()%>>" style="margin:0px 5px 0px 0px;">删除</a>
	    				<%
	    					}
	    				%>
	    			</td>
	    			<%
	    				}
	    			 %>
	    		</tr>
	    		<%
	    			}
	    		 %>
	    	</tbody>
	    </table>
	 </div>
  </body>
</html>
