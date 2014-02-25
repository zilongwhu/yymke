function enter_child()
{
	var child = document.getElementById("child").value;
	if (child!=-1)
	{
		window.location.href = "products.jsp?id="+child;
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
						window.location.href="products.jsp?id="+obj.parent_id;
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

function toggle_infos()
{
	if ($("type").checked)
	{
		$("infos").style.display = "";
	}
	else
	{
		$("infos").style.display = "none";
	}
}