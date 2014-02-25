function init()
{
	var arr = [{
			"name":"顶层目录",
			"id":0
		}];
	$('product_type').appendChild(generateSelect(arr));
}

function init_2()
{
	if (parent_ids.length==0)
	{
		var arr = [{
				"name":"顶层目录",
				"id":0
			}];
		$('product_type').appendChild(generateSelect(arr));
	}
	else
	{
		new Ajax.Request("getcatalogchilds",{
			parameters: {"id":parent_ids[index]},
			onSuccess: function(response){
				var arr = response.responseJSON;
				while ($('product_type').childNodes.length>0)
				{
					$('product_type').removeChild($('product_type').childNodes[0]);
				}
				$('product_type').appendChild(generateSelect(arr));
				$('catalog').value = parent_id;
			}
		});
	}
}

function go_to_child()
{
	index += 1;
	parent_ids[index] = $F('catalog');
	
	new Ajax.Request("getcatalogchilds",{
		parameters: {"id":$F('catalog')},
		onSuccess: function(response){
			var arr = response.responseJSON;
			if (arr.length>0)
			{
				while ($('product_type').childNodes.length>0)
				{
					$('product_type').removeChild($('product_type').childNodes[0]);
				}
				$('product_type').appendChild(generateSelect(arr));
			}
			else
			{
				alert("当前所选目录没有子目录！");
				index -= 1;
			}
		}
	});
}

function go_to_parent()
{
	if (index<0)
	{
		alert("当前目录已经是顶层目录！");
		return ;
	}
	index -= 1;
	if (index==-1)
	{
		var arr = [{
			"name":"顶层目录",
			"id":0
		}];
		while ($('product_type').childNodes.length>0)
		{
			$('product_type').removeChild($('product_type').childNodes[0]);
		}
		$('product_type').appendChild(generateSelect(arr));
	}
	else
	{
		new Ajax.Request("getcatalogchilds",{
			parameters: {"id":parent_ids[index]},
			onSuccess: function(response){
				var arr = response.responseJSON;
				if (arr.length>0)
				{
					while ($('product_type').childNodes.length>0)
					{
						$('product_type').removeChild($('product_type').childNodes[0]);
					}
					$('product_type').appendChild(generateSelect(arr));
				}
				else
				{
					init();
					alert("当前所选目录没有子目录！");
				}
			}
		});
	}
}

function generateSelect(arr)
{
	var div = document.createElement("div");
	var select = document.createElement("select");
	select.id = "catalog";
	select.name = "catalog";
	select.style.width = "300px";
	var i=0;
	for (;i<arr.length;i+=1)
	{
		var option = document.createElement("option");
		option.value = arr[i].id;
		option.appendChild(document.createTextNode(arr[i].name));
		select.appendChild(option);
	}
	div.appendChild(select);
	var a = document.createElement("a");
	a.href = "javascript:go_to_child();";
	a.title = "进入子目录";
	a.className = "child_a";
	a.appendChild(document.createTextNode("子目录"));
	div.appendChild(a);
	a = document.createElement("a");
	a.href = "javascript:go_to_parent();";
	a.title = "返回上一级";
	a.className = "parent_a";
	a.appendChild(document.createTextNode("上级目录"));
	div.appendChild(a);
	return div;
}

function toggle_type()
{
	if ($("type_0").checked)
	{
		$("type_selector").style.display = "";
	}
	else
	{
		$("type_selector").style.display = "none";
	}
}

function upload_img()
{
	var left = (parseInt(window.screen.width)-400)/2;
	var top = (parseInt(window.screen.height)-100)/2;
	window.open ("getProductImg.jsp", "", "height=100px, width=400px,top="+top+"px,left="+left+"px, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no");
}

function set_path(path)
{
	$("img_path").value = path;
	$("img_path2").value = path;
	$("preview_button").disabled = (path.length==0);
	$("preview_img").src = path;
}


function preview_image()
{
	var src = $F("img_path");
	if (src.length>0)
	{
		var value = $F("preview_button");
		if (value=="预览")
		{
			$("preview").style.display = "";
			$("preview_img").src = src;
			$("preview_button").value="关闭";
		}
		else
		{
			$("preview").style.display = "none";
			$("preview_button").value="预览";
		}
	}
}