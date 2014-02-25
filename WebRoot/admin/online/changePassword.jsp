<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath+"admin/online/"%>">
    
    <title>岳阳强力电磁有限公司---修改密码</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	
	<link rel="stylesheet" type="text/css" href="css/basic.css">
	<link rel="stylesheet" type="text/css" href="css/input_feedback.css">
	<style type="text/css">
		body
		{
			text-align: center;
			width: 660px;
		}
		
		.top_div
		{
			margin: 0px auto;
			width: 300px;
			text-align: left;
		}
	</style>
	<script type="text/javascript" src="../../js/prototype-1.6.0.3.js"></script>
	<script type="text/javascript" src="../../js/iframe_auto_height.js"></script>
	<script type="text/javascript" src="../js/basic.js"></script>
	<script type="text/javascript" src="js/changepassword.js"></script>
	<script type="text/javascript">
		window.onload = function(){
			update_iframe_height();
			parent.setLocation("修改登录密码");
			Event.observe($("change_password_form"),"submit",check_valid);
		};
	</script>
  </head>
  
  <body>
 	<form target="change_password_hidden" action="changepassword" method="post" id="change_password_form">
    <div class="top_div">
	    <table>
	    	<tbody>
	    		<tr>
	    			<td>旧密码：</td><td class="feedback"><input class="text_input" name="old_password" id="old_password" type="password"><font color="red">*</font></td>
	    		</tr>
	    		<tr>
	    			<td>新密码：</td><td class="feedback"><input class="text_input" name="new_password" id="new_password" onblur="check_pass_same(1,false);" onkeyup="check_pass_same(1,true);" type="password"><font color="red">*</font></td>
	    		</tr>
	    		<tr>
	    			<td>确认密码：</td><td class="feedback" id="password_same_f"><input class="text_input" id="new_password2" onblur="check_pass_same(2,false);" onkeyup="check_pass_same(2,true);" type="password"><font color="red">*</font></td>
	    		</tr>
	    		<tr>
	    			<td colspan="2" align="right"><input type="submit" value="保存修改"></td>
	    		</tr>
	    	</tbody>
	    </table>
	    <iframe name="change_password_hidden" width="0px" height="0px" frameborder="0" scrolling="no"></iframe>
     </div>
	 </form>
  </body>
</html>
