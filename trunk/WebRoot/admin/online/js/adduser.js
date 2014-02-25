function hide_show_authority()
{
	var link = $("hs_authority");
	var panel = $("authority");
	if (link.className=="a_hide")
	{
		link.className = "a_show";
		link.title = "展开";
		panel.style.display = "none";
	}
	else
	{
		link.className = "a_hide";
		link.title = "折叠";
		panel.style.display = "";
	}
}

function callback(status)
{
	if (status==0)
	{
		alert("添加成功！");
	  	window.location.href = "users.jsp";
	}
	else if (status==1)
	{
		alert("用户名已经存在，添加失败！");
		$("name").focus();
	}
	else if (status==2)
	{
		alert("对不起，您的权限不够，请与管理员联系！");
	}
	else
	{
		alert("对不起，添加出错！");
	}
}
		
function check_valid(evt)
{
	if (getInputValue("name").length==0)
	{
		Event.stop(evt);
		alert("名字必须填写！");
		$("name").focus();
		return;
	}
	if (getInputValue("password").length==0)
	{
		Event.stop(evt);
		alert("密码必须填写！");
		$("password").focus();
		return;
	}
	if (getInputValue("password")!=getInputValue("password2"))
	{
		Event.stop(evt);
		alert("两次密码输入不一致！");
		$("password2").focus();
		return;
	}
}

function check_pass_same(which,iskeyup)
{
	var pass1 = getInputValue("password");
	var pass2 = getInputValue("password2");
	
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