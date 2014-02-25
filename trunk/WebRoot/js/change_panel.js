function change_na_panel(evt)
{
	var id = evt.element().id;
	if (id.indexOf("news")>=0)
	{
		$("news").style.display = "";
		$("achievements").style.display = "none";
		$("news_h").className = "nh_active";
		$("achievements_h").className = "ah_passive";
	}
	else
	{
		$("news").style.display = "none";
		$("achievements").style.display = "";
		$("news_h").className = "nh_passive";
		$("achievements_h").className = "ah_active";
	}
}

function change_product_panel(evt)
{
	var id = evt.element().id;
	var prefix = "product_type_";
	var h_prefix = "pt";
	var i = 1;
	for (;i<5;i+=1)
	{
		if (id.indexOf(i+"")>=0)
		{
			$(prefix+i).style.display = "";
			$(h_prefix+i).className = "ph_active";
		}
		else
		{
			$(prefix+i).style.display = "none";
			$(h_prefix+i).className = "ph_passive";
		}
	}
	Event.stop(evt);
}