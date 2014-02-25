function callback(status)
{
	if (status==0)
	{
		alert("修改成功！");
	  	window.location.href = "users.jsp";
	}
	else if (status==1)
	{
		alert("对不起，您的权限不够，请与管理员联系！");
	}
	else
	{
		alert("对不起，修改出错！");
	}
}