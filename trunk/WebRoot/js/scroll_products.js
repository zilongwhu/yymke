var stop = false;
var left = 0;

function scroll_products()
{
	var i;
	if (products<max_products)
	{
		
		i = 1;
		while (i<=products)
		{
			document.getElementById("product_"+i).style.left = pos[i-1]+"px";
			i+=1;
		}
		return;
	}
	if (!stop)
	{
		i = 0;
		var first = -1;
		while (i<products)
		{
			pos[i] -= 2;
			if (pos[i]<=-product_width)
			{
				first = i;
			}
			i+=1;
		}
		if (first>=0)
		{
			var max = pos[0];
			i = 1;
			while (i<products)
			{
				if (pos[i]>max)
				{
					max = pos[i];
				}
				i+=1;
			}
			pos[first] = max + product_width;
		}
		i = 1;
		while (i<=products)
		{
			document.getElementById("product_"+i).style.left = pos[i-1]+"px";
			i+=1;
		}
	}
}

function stop_scrolling()
{
	stop = true;
}

function restart_scrolling()
{
	stop = false;
}

function show_features(id)
{
	var left = parseInt(document.getElementById("product_"+id).style.left);
	var pd_des = document.getElementById("pd_d_"+id);
	var pd_name = document.getElementById("pd_n_"+id);
	var width;
	if (left+product_width/2<=302)
	{
		pd_des.style.left = (left+product_width-7)+"px";
		width = 600-(left+product_width-7);
		width = width>360?360:width;
	}
	else
	{
		width = left-9;
		width = width>360?360:width;
		pd_des.style.left = (left-9-width)+"px";
	}
	if (document.all)
	{
		pd_name.style["width"] = (width-2)+"px";
		pd_des.style["width"] = width+"px";
	}
	else
	{
		pd_name.style["width"] = (width-12)+"px";
		pd_des.style["width"] = (width-2)+"px";
	}
	pd_des.style.display = "block";
}

function hide_features(id)
{
	document.getElementById("pd_d_"+id).style.display = "none";
}