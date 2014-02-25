function update_iframe_height()
{
	if (window.parent.document.getElementById("stage"))
	{
		window.parent.document.getElementById("stage").style.height = get_page_height()+"px";
	}
}

function get_page_height()
{
	if (document.all)
	{
		return document.body.scrollHeight;
	}
	else
	{
		return document.documentElement.scrollHeight;
	}
}
