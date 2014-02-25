function callback(status)
{
	if (status==0)
	{
		alert("添加成功！");
	  	window.location.href = "worldwides.jsp";
	}
	else if (status==1)
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
	if (getInputValue("area").length==0)
	{
		Event.stop(evt);
		alert("代理区域必须填写！");
		$("area").focus();
		return;
	}
	if (getInputValue("agent").length==0)
	{
		Event.stop(evt);
		alert("代理商名称必须填写！");
		$("agent").focus();
		return;
	}
}