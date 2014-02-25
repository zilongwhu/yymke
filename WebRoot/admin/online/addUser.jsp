<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="liftingmagnet.com.usermanage.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	User user = (User)session.getAttribute("user");
	Authority limits = user.getLimits();
	if (!limits.canAddUser())
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
    
    <title>岳阳强力电磁有限公司---添加员工</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	
	<link rel="stylesheet" type="text/css" href="css/basic.css">
	<link rel="stylesheet" type="text/css" href="css/add_user.css">
	<link rel="stylesheet" type="text/css" href="css/input_feedback.css">
	<script type="text/javascript" src="../../js/prototype-1.6.0.3.js"></script>
	<script type="text/javascript" src="../../js/iframe_auto_height.js"></script>
	<script type="text/javascript" src="../js/basic.js"></script>
	<script type="text/javascript" src="js/adduser.js"></script>
	<script type="text/javascript">
		window.onload = function(){
			Event.observe($("adduser_form"),"submit",check_valid);
			setInterval(update_iframe_height,100);
			parent.setLocation("添加员工");
			$("name").focus();
		};
	</script>
  </head>
  
  <body>
    <div class="top_div">
    	<div style="padding-bottom:10px;font-weight:bold;">新员工基本信息</div>
    <form action="adduser" method="post" target="add_user_hidden" id="adduser_form">
	    	<table>
	    		<tbody>
	    			<tr>
	    				<td>姓名：</td><td><input class="text_input" type="text" name="name" id="name"><font color="red">*</font></td>
	    			</tr>
	    			<tr>
	    				<td>密码：</td><td><input class="text_input" type="password" name="password" id="password" onblur="check_pass_same(1,false);" onkeyup="check_pass_same(1,true);"><font color="red">*</font></td>
	    			</tr>
	    			<tr>
	    				<td>确认密码：</td><td class="feedback" id="password_same_f"><input class="text_input" type="password" id="password2" onblur="check_pass_same(2,false);" onkeyup="check_pass_same(2,true);"><font color="red">*</font></td>
	    			</tr>
	    			<tr>
	    				<td colspan="2"><a id="hs_authority" href="javascript:hide_show_authority();" title="展开" class="a_show">设置该员工的操作权限</a></td>
	    			</tr>
	    		</tbody>
	    	</table>
	    	<div id="authority" style="display:none;padding-top:5px;">
		    	<div class="authority">
	    			<div class="authority_h">员工账号管理</div>
	    			<div style="padding-left:10px;">
	    				<table cellspacing="0" cellpadding="0">
	    					<tbody>
	    						<tr>
	    							<td width="90px"><input type="checkbox" name="add_user" id="add_user" value="yes" <%=user.getLimits().canAddUser()?"":"disabled" %>><label for="add_user">添加新员工</label></td>
	    							<td><input type="checkbox" name="modify_user" id="modify_user" value="yes" <%=user.getLimits().canModifyUser()?"":"disabled" %>><label for="modify_user">修改员工信息</label></td>
	    						</tr>
	    						<tr>
	    							<td width="90px"><input type="checkbox" name="delete_user" id="delete_user" value="yes" <%=user.getLimits().canDeleteUser()?"":"disabled" %>><label for="delete_user">删除员工</label></td>
	    							<td><input type="checkbox" name="superviser" id="superviser" value="yes" <%=user.getLimits().canSupervise()?"":"disabled" %>><label for="superviser">员工历史操作浏览</label></td>
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
	    							<td width="90px"><input type="checkbox" name="add_news" id="add_news" value="yes" <%=user.getLimits().canAddNews()?"":"disabled" %>><label for="add_news">添加新闻</label></td>
	    							<td><input type="checkbox" name="modify_news" id="modify_news" value="yes" <%=user.getLimits().canModifyNews()?"":"disabled" %>><label for="modify_news">修改新闻</label></td>
	    						</tr>
	    						<tr>
	    							<td width="90px"><input type="checkbox" name="delete_news" id="delete_news" value="yes" <%=user.getLimits().canDeleteNews()?"":"disabled" %>><label for="delete_news">删除新闻</label></td>
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
	    							<td width="90px"><input type="checkbox" name="add_product" id="add_product" value="yes" <%=user.getLimits().canAddProduct()?"":"disabled" %>><label for="add_product">添加新产品</label></td>
	    							<td><input type="checkbox" name="modify_product" id="modify_product" value="yes" <%=user.getLimits().canModifyProduct()?"":"disabled" %>><label for="modify_product">修改产品信息</label></td>
	    						</tr>
	    						<tr>
	    							<td width="90px"><input type="checkbox" name="delete_product" id="delete_product" value="yes" <%=user.getLimits().canDeleteProduct()?"":"disabled" %>><label for="delete_product">删除产品</label></td>
	    							<td><input type="checkbox" name="manage_product_list" id="manage_product_list" value="yes" <%=user.getLimits().canManageProductList()?"":"disabled" %>><label for="manage_product_list">管理产品列表</label></td>
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
	    							<td width="90px"><input type="checkbox" name="add_achievement" id="add_achievement" value="yes" <%=user.getLimits().canAddAchievement()?"":"disabled" %>><label for="add_achievement">添加业绩表</label></td>
	    							<td><input type="checkbox" name="modify_achievement" id="modify_achievement" value="yes" <%=user.getLimits().canModifyAchievement()?"":"disabled" %>><label for="modify_achievement">修改业绩表</label></td>
	    						</tr>
	    						<tr>
	    							<td width="90px"><input type="checkbox" name="delete_achievement" id="delete_achievement" value="yes" <%=user.getLimits().canDeleteAchievement()?"":"disabled" %>><label for="delete_achievement">删除业绩表</label></td>
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
	    							<td width="90px"><input type="checkbox" name="answer_feedback" id="answer_feedback" value="yes" <%=user.getLimits().canAnswerFeedback()?"":"disabled" %>><label for="answer_feedback">回复留言</label></td>
	    							<td><input type="checkbox" name="delete_feedback" id="delete_feedback" value="yes" <%=user.getLimits().canDeleteFeedback()?"":"disabled" %>><label for="delete_feedback">删除留言</label></td>
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
	    							<td width="90px"><input type="checkbox" name="manage_worldwide" id="manage_worldwide" value="yes" <%=user.getLimits().canManageWorldwide()?"":"disabled" %>><label for="manage_worldwide">全球代理商</label></td>
	    							<td><input type="checkbox" name="manage_contact_info" id="manage_contact_info" value="yes" <%=user.getLimits().canManageContactInfo()?"":"diabled" %>><label for="manage_contact_info">公司联系方式</label></td>
	    						</tr>
	    						<tr>
	    							<td colspan="2"><input type="checkbox" name="view_visitors" id="view_visitors" value="yes" <%=user.getLimits().canViewVisitors()?"":"disabled" %>><label for="view_visitors">网站访问统计浏览</label></td>
	    						</tr>
	    					</tbody>
	    				</table>
	    			</div>
	    		</div>
    		</div>
    		<div style="margin-top: 10px;">
    			<input type="submit" value="添加" style="margin: 5px 20px 10px;">
    			<input type="reset" value="重置" style="margin: 5px 20px 10px;">
    		</div>
    	</form>
    </div>
    <iframe name="add_user_hidden" width="0px" height="0px" frameborder="0" scrolling="no"></iframe>
  </body>
</html>
