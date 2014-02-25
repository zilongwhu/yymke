<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath+"admin/"%>">
    
    <title>岳阳强力电磁有限公司</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	
	<link rel="stylesheet" type="text/css" href="css/login.css">
	
	<script type="text/javascript" src="../js/prototype-1.6.0.3.js"></script>
	<script type="text/javascript" src="js/basic.js"></script>
	<script type="text/javascript" src="js/login.js"></script>

  </head>
  <script type="text/javascript">
  	window.onload = function()
  	{
  		var div = $("login_div");
  		div.style.left = ( parseInt(document.body.clientWidth) - 270)/2 + "px";
  		div.style.top = ( parseInt(document.body.clientHeight) - 300)/2 + "px";
  		Event.observe($("login_form"), "submit", check_valid);
  		$("username").focus();
  	}

  </script>
  <body>
	  <form action="login" method="post" target="login_hidden" id="login_form">
	  	<div class="login" id="login_div">
	  		<div class="login_header">欢迎您登录公司网站！</div>
	  		<div class="login_content">
			    <table>
			    	<tbody>
			    		<tr><td>用户名：</td><td class="feedback" id="username_f"><input type="text" id="username" name="name" onfocus="$('username_f').className='feedback';"></td></tr>
			    		<tr><td>密码：</td><td class="feedback" id="password_f"><input type="password" id="password" name="password" onfocus="$('password_f').className='feedback';"></td></tr>
			    		<tr><td>验证码：</td><td class="feedback" id="auth_code_f"><input type="text" id="auth_code" onblur="validate_code();" onkeyup="validate_code2();"></td><td><a href="javascript:reload_auth_img();" title="点击换一张"><img id="auth_img" border="0" src="/auth_image"></a></td></tr>
			    		<tr><td colspan="3" align="center"><input class="button" type="submit" value="登录"><input class="button" type="reset" value="重置"></td></tr>
			    	</tbody>
			    </table>
	  		</div>
	    </div>
	   </form>
	   <iframe name="login_hidden" width="0px" height="0px" frameborder="0" scrolling="no"></iframe>
  </body>
</html>
