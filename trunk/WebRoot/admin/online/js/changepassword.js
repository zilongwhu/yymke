function check_valid(evt)
{
	if (getInputValue("old_password").length==0)
	{
		Event.stop(evt);
		alert("旧密码必须提供！");
		$("old_password").focus();
		return;
	}
	
	if (getInputValue("new_password").length==0)
	{
		Event.stop(evt);
		alert("新密码必须提供！");
		$("new_password").focus();
		return;
	}
	
	if (getInputValue("new_password")!=getInputValue("new_password2"))
	{
		Event.stop(evt);
		alert("两次密码输入不一致！");
		$("new_password2").focus();
		return;
	}
}

function check_pass_same(which,iskeyup)
{
	var pass1 = getInputValue("new_password");
	var pass2 = getInputValue("new_password2");
	
	if (pass1.length==0||pass2.length==0)
	{
		$("password_same_f").className = "feedback";
		return;
	}
	if (iskeyup&&which==2)
	{
		if (pass1.length>pass2.length)
		{
			$("password_same_f").className = "feedback";
			return;
		}
	}
	if (pass1!=pass2)
	{
		$("password_same_f").className = "feedback_wrong";
	}
	else
	{
		$("password_same_f").className = "feedback_right";
	}
}

function callback(status)
{
	if (status==0)
	{
		alert("密码修改成功！重新登录。");
	  	parent.location.href="../login.jsp";
	}
	else if (status==1)
	{
		alert("旧密码错误！");
		$("old_password").focus();
	}
	else
	{
		alert("对不起，修改密码出错！");
	}
}