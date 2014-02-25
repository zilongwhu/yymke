function hide_show(id)
{
	var header = document.getElementById(id);
	var content = document.getElementById("content_"+id.substring(7));
	if (header.className=="hide")
	{
		header.className = "show";
		header.title = "展开";
		content.style.display = "none";
	}
	else
	{
		header.className = "hide";
		header.title = "折叠";
		content.style.display = "";
	}
}