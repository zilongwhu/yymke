function getChilds(catalogId)
{
	$('container').innerHTML = "<div style='padding-left:100px;'><img src='/images/loading.gif'>&nbsp;&nbsp;数据加载中...</div>";
	$('select_all').checked = false;
	$('place_s').disabled = true;
	$('move_s').disabled = true;
	new Ajax.Updater('container','getChilds.jsp',
		{
			parameters: 'catalog_id='+catalogId
		}
	);
	new Ajax.Updater('place_s','changePosition.jsp',
		{
			parameters: 'catalog_id='+catalogId
		}
	);
}
		
function check_movable(name)
{
	var tags = document.getElementsByName(name);
	var isSelected = false;
	var i=0;
	for (;i<tags.length;i+=1)
	{
		if (tags[i].checked)
		{
			isSelected = true;
			break;
		}
	}
	if (isSelected)
	{
		$("move_s").disabled = false;
	}
	else
	{
		$("move_s").disabled = true;
		$("move_s").value = "-1";
	}
}

function check_placeable(name)
{
	var tags = document.getElementsByName(name);
	if (tags.length<=1)
	{
		$("place_s").disabled = true;
		return;
	}
	var num = 0;
	var i=0;
	for (;i<tags.length;i+=1)
	{
		if (tags[i].checked)
		{
			num += 1;
		}
	}
	if (num==1)
	{
		$("place_s").disabled = false;
	}
	else
	{
		$("place_s").disabled = true;
	}
}

function get_type_name()
{
	var left = (parseInt(window.screen.width)-360)/2;
	var top = (parseInt(window.screen.height)-100)/2;
	window.open ("getNewTypeName.jsp", "", "height=100px, width=360px,top="+top+"px,left="+left+"px, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no");
}
		
function add_new_type(type)
{
	new Ajax.Request('addproducttype',
		{
			parameters: 'type='+type+'&parent='+$F('dir'),
			onSuccess: function(response){
				var obj = response.responseJSON;
				if (obj.status==0)
				{
					if ($F('dir')==obj.parent)
					{
						getChilds($F('dir'));
					}
					getCatalog();
				}
				else if(obj.status==1)
				{
					alert("对不起，您的权限不够，请与管理员联系！");
				}
				else
				{
					alert("对不起，添加出错！");
				}
			}
		}
	);
}

function getCatalog()
{
	var id = $F("dir");
	new Ajax.Updater('dir','getCatalog.jsp',
		{
			parameters: 'id='+id
		}
	);
	new Ajax.Updater('move_s','getCatalog1.jsp',
		{
			parameters: 'id=-1',
			onSuccess: function(response){
				$('move_s').disabled = true;
			}
		}
	);	
}

function move()
{
	var target = $F('move_s');
	if (target=="-1")
	{
		return;
	}
	var tags = document.getElementsByName("moving");
	var ids = "";
	var i = 0;
	for (;i<tags.length;i+=1)
	{
		if (tags[i].checked)
		{
			ids += "_"+tags[i].value;
			if (tags[i].value==target)
			{
				alert("请检查<不能移动到自己下面>");
				return;
			}
		}
	}
	new Ajax.Request('movecatalog',
		{
			parameters: 'ids='+ids+'&target='+target+'&parent='+$F('dir'),
			onSuccess: function(response){
				var obj = response.responseJSON;
				if (obj.status==0)
				{
					if ($F('dir')==obj.parent||$F('dir')==obj.target)
					{
						getChilds($F('dir'));
					}
					getCatalog();
				}
				else if(obj.status==1)
				{
					alert("对不起，您的权限不够，请与管理员联系！");
				}
				else
				{
					alert("对不起，添加出错！");
				}
			}
		}
	);
}

function go_to_parent()
{
	var id = parseInt($F('dir'));
	if (id>0)
	{
		new Ajax.Request('getparent',
			{
				parameters: 'id='+id,
				onSuccess: function(response){
					var obj = response.responseJSON;
					if (obj.parent>=0)
					{
						getChilds(''+obj.parent);
						$('dir').value = obj.parent;
					}
					else
					{
						alert("对不起，您的权限不够，请与管理员联系！");
					}
				}
			}
		);
	}
}

function select_all()
{
	var selected = false;
	if ($("select_all").checked)
	{
		selected = true;
	}
	var tags = document.getElementsByName("moving");
	var i=0;
	for (;i<tags.length;i+=1)
	{
		tags[i].checked = selected;
	}
	if (selected&&i>0)
	{
		$("move_s").disabled = false;
	}
	else
	{
		$("move_s").disabled = true;
	}
}

function place_after()
{
	var values = document.getElementsByName("moving");
	if (values.length<=1)
	{
		return;
	}
	var i=0;
	var value;
	for (;i<values.length;i+=1)
	{
		if (values[i].checked)
		{
			value = values[i].value;
			break;
		}
	}
	var target = $F('place_s');
	if (value!=target&&target!=-1)
	{
		new Ajax.Updater('place_s','changeposition',
			{
				parameters: {'p_id':$F('dir'),'s_id':value,'t_id':target},
				onSuccess: function(response){
					var obj = response.responseJSON;
					if (obj.status)
					{
						getChilds($F('dir'));
					}
				}
			}
		);
	}
}

function delete_product_catalog(id)
{
	if (window.confirm("您确定要删除该产品类型?"))
	{
		new Ajax.Request('deleteproductcatalog',
			{
				parameters: {'id':id},
				onSuccess: function(response){
					var obj = response.responseJSON;
					if (obj.status==0)
					{
						getChilds($F('dir'));
					}
					else if(obj.status==1)
					{
						alert("对不起，您的权限不够，请与管理员联系！");
					}
					else if(obj.status==2)
					{
						alert("删除被拒绝，该类型下面还有子类型或产品，请先删除它们！");
					}
					else
					{
						alert("对不起，删除出错！");
					}
				}
			}
		);
	}
}

function delete_product(id)
{
	if (window.confirm("您确定要删除该产品(信息)?"))
	{
		new Ajax.Request('deleteproduct',
			{
				parameters: {'id':id},
				onSuccess: function(response){
					var obj = response.responseJSON;
					if (obj.status==0)
					{
						getChilds($F('dir'));
					}
					else if(obj.status==1)
					{
						alert("对不起，您的权限不够，请与管理员联系！");
					}
					else if(obj.status==2)
					{
						alert("删除被拒绝，该类型下面还有子类型或产品，请先删除它们！");
					}
					else
					{
						alert("对不起，删除出错！");
					}
				}
			}
		);
	}
}

function enter_child(id)
{
	$('dir').value = id+'';
	getChilds(id);
}

function toggle_select(name)
{
	var tags = document.getElementsByName("moving");
	var i=0;
	for (;i<tags.length;i+=1)
	{
		tags[i].checked = !tags[i].checked;
	}
}

function toggle_product_catalog_state(id)
{
	new Ajax.Request("changeproductcatalogstate",{
		parameters:{"id":id},
		onSuccess: function(response){
			var obj = response.responseJSON;
			if (obj.status==0)
			{
				if (obj.opened)
				{
					var title = $("pcs_a"+obj.id).title;
					$("pcs_a"+obj.id).title = "关闭"+title.substring(2);
					$("pcs_img"+obj.id).src = "/images/tree/tree_folderopen.gif";
				}
				else
				{
					var title = $("pcs_a"+obj.id).title;
					$("pcs_a"+obj.id).title = "打开"+title.substring(2);
					$("pcs_img"+obj.id).src = "/images/tree/tree_folder.gif";
				}
			}
			else if(obj.status==1)
			{
				alert("对不起，您的权限不够，请与管理员联系！");
			}
			else if(obj.status==2)
			{
				alert("修改状态出错！");
			}
			else
			{
				alert("对不起，修改出错！");
			}
		}
	});
}