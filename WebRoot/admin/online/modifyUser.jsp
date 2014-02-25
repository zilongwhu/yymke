<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="liftingmagnet.com.usermanage.*" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	User user = (User)session.getAttribute("user");
	Authority limits = user.getLimits();
	if (!limits.canModifyUser())
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
    
    <title>岳阳强力电磁有限公司---修改员工权限</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	
	<link rel="stylesheet" type="text/css" href="css/basic.css">
	<link rel="stylesheet" type="text/css" href="css/modify_user.css">
	<script type="text/javascript" src="../../js/prototype-1.6.0.3.js"></script>
	<script type="text/javascript" src="../../js/iframe_auto_height.js"></script>
	<script type="text/javascript" src="js/modifyuser.js"></script>
	<script type="text/javascript">
		window.onload = function(){
			update_iframe_height();
			parent.setLocation("修改员工权限");
		};
	</script>

  </head>
  
  <body>
    <% 
    	String name = request.getParameter("name"); 
    	
    	User u = user.getUser(name);
    	if (u!=null)
    	{
    		limits = u.getLimits();
     %>
     <form target="modify_user_hidden" action="modifyuser" method="post">
     <input type="hidden" name="name" value="<%=name %>">
     <div class="top_div">
         <div style="margin: 5px 0px;"><font color="red"><%=name %></font>的所有权限如下：</div>
    	 <div class="authority">
  			<div class="authority_h">员工账号管理</div>
  			<div style="padding-left:10px;">
  				<table cellspacing="0" cellpadding="0">
  					<tbody>
  						<tr>
  							<td width="90px"><input <%=limits.canAddUser()?"checked":"" %> type="checkbox" name="add_user" id="add_user" value="yes" <%=user.getLimits().canAddUser()?"":"disabled" %>><label for="add_user">添加新员工</label></td>
  							<td width="100px"><input <%=limits.canModifyUser()?"checked":"" %> type="checkbox" name="modify_user" id="modify_user" value="yes" <%=user.getLimits().canModifyUser()?"":"disabled" %>><label for="modify_user">修改员工信息</label></td>
  							<td width="80px"><input <%=limits.canDeleteUser()?"checked":"" %> type="checkbox" name="delete_user" id="delete_user" value="yes" <%=user.getLimits().canDeleteUser()?"":"disabled" %>><label for="delete_user">删除员工</label></td>
  							<td width="120px"><input <%=limits.canSupervise()?"checked":"" %> type="checkbox" name="superviser" id="superviser" value="yes" <%=user.getLimits().canSupervise()?"":"disabled" %>><label for="superviser">员工历史操作浏览</label></td>
  						</tr>
  					</tbody>
  				</table>
  			</div>
  		</div>
  		<div class="authority">
  			<div class="authority_h">新闻管理</div>
  			<div style="padding-left:10px;">
  				<table cellspacing="0" cellpadding="0">
  					<tbody>
  						<tr>
  							<td width="90px"><input <%=limits.canAddNews()?"checked":"" %> type="checkbox" name="add_news" id="add_news" value="yes" <%=user.getLimits().canAddNews()?"":"disabled" %>><label for="add_news">添加新闻</label></td>
  							<td width="100px"><input <%=limits.canModifyNews()?"checked":"" %> type="checkbox" name="modify_news" id="modify_news" value="yes" <%=user.getLimits().canModifyNews()?"":"disabled" %>><label for="modify_news">修改新闻</label></td>
  							<td width="80px"><input <%=limits.canDeleteNews()?"checked":"" %> type="checkbox" name="delete_news" id="delete_news" value="yes" <%=user.getLimits().canDeleteNews()?"":"disabled" %>><label for="delete_news">删除新闻</label></td>
  						</tr>
  					</tbody>
  				</table>
  			</div>
  		</div>
  		<div class="authority">
  			<div class="authority_h">产品管理</div>
  			<div style="padding-left:10px;">
  				<table cellspacing="0" cellpadding="0">
  					<tbody>
  						<tr>
  							<td width="90px"><input <%=limits.canAddProduct()?"checked":"" %> type="checkbox" name="add_product" id="add_product" value="yes" <%=user.getLimits().canAddProduct()?"":"disabled" %>><label for="add_product">添加新产品</label></td>
  							<td width="100px"><input <%=limits.canModifyProduct()?"checked":"" %> type="checkbox" name="modify_product" id="modify_product" value="yes" <%=user.getLimits().canModifyProduct()?"":"disabled" %>><label for="modify_product">修改产品信息</label></td>
  							<td width="80px"><input <%=limits.canDeleteProduct()?"checked":"" %> type="checkbox" name="delete_product" id="delete_product" value="yes" <%=user.getLimits().canDeleteProduct()?"":"disabled" %>><label for="delete_product">删除产品</label></td>
  							<td width="120px"><input <%=limits.canManageProductList()?"checked":"" %> type="checkbox" name="manage_product_list" id="manage_product_list" value="yes" <%=user.getLimits().canManageProductList()?"":"disabled" %>><label for="manage_product_list">管理产品列表</label></td>
  						</tr>
  					</tbody>
  				</table>
  			</div>
  		</div>
  		<div class="authority">
  			<div class="authority_h">业绩表管理</div>
  			<div style="padding-left:10px;">
  				<table cellspacing="0" cellpadding="0">
  					<tbody>
  						<tr>
  							<td width="90px"><input <%=limits.canAddAchievement()?"checked":"" %> type="checkbox" name="add_achievement" id="add_achievement" value="yes" <%=user.getLimits().canAddAchievement()?"":"disabled" %>><label for="add_achievement">添加业绩表</label></td>
  							<td width="100px"><input <%=limits.canModifyAchievement()?"checked":"" %> type="checkbox" name="modify_achievement" id="modify_achievement" value="yes" <%=user.getLimits().canModifyAchievement()?"":"disabled" %>><label for="modify_achievement">修改业绩表</label></td>
  							<td width="80px"><input <%=limits.canDeleteAchievement()?"checked":"" %> type="checkbox" name="delete_achievement" id="delete_achievement" value="yes" <%=user.getLimits().canDeleteAchievement()?"":"disabled" %>><label for="delete_achievement">删除业绩表</label></td>
  						</tr>
  					</tbody>
  				</table>
  			</div>
  		</div>
  		<div class="authority">
  			<div class="authority_h">客户反馈信息管理</div>
  			<div style="padding-left:10px;">
  				<table cellspacing="0" cellpadding="0">
  					<tbody>
  						<tr>
  							<td width="90px"><input <%=limits.canAnswerFeedback()?"checked":"" %> type="checkbox" name="answer_feedback" id="answer_feedback" value="yes" <%=user.getLimits().canAnswerFeedback()?"":"disabled" %>><label for="answer_feedback">回复留言</label></td>
  							<td width="100px"><input <%=limits.canDeleteFeedback()?"checked":"" %> type="checkbox" name="delete_feedback" id="delete_feedback" value="yes" <%=user.getLimits().canDeleteFeedback()?"":"disabled" %>><label for="delete_feedback">删除留言</label></td>
  						</tr>
  					</tbody>
  				</table>
  			</div>
  		</div>
  		<div class="authority">
  			<div class="authority_h">网站管理</div>
  			<div style="padding-left:10px;">
  				<table cellspacing="0" cellpadding="0">
  					<tbody>
  						<tr>
  							<td width="90px"><input <%=limits.canManageWorldwide()?"checked":"" %> type="checkbox" name="manage_worldwide" id="manage_worldwide" value="yes" <%=user.getLimits().canManageWorldwide()?"":"disabled" %>><label for="manage_worldwide">全球代理商</label></td>
  							<td width="100px"><input <%=limits.canManageContactInfo()?"checked":"" %> type="checkbox" name="manage_contact_info" id="manage_contact_info" value="yes" <%=user.getLimits().canManageContactInfo()?"":"disabled" %>><label for="manage_contact_info">公司联系方式</label></td>
  							<td width="150px"><input <%=limits.canViewVisitors()?"checked":"" %> type="checkbox" name="view_visitors" id="view_visitors" value="yes" <%=user.getLimits().canViewVisitors()?"":"disabled" %>><label for="view_visitors">网站访问统计浏览</label></td>
  						</tr>
  					</tbody>
  				</table>
  			</div>
  		</div>
  		<div>
    		<input type="submit" value="修改" style="margin: 10px 10px 10px 100px;">
    		<input type="reset" value="重置" style="margin: 10px 50px;">
    	</div>
  	</div>
  	</form>
    <iframe name="modify_user_hidden" width="0px" height="0px" frameborder="0" scrolling="no"></iframe>
  	<%
  		}
  	%>
  </body>
</html>
