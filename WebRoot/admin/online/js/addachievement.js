function change_products()
{
	var type = $F("type");
	
	var div = $("orders");
	while (div.childNodes.length>0)
	{
		div.removeChild(div.childNodes[0]);
	}
	append(div);
}

function add()
{
	var div = $("orders");
	append(div);
}

function delete_order(id)
{
	var div = $("orders");
	div.removeChild($("order_"+id));
}

function append(div)
{
	var type = $F("type");
	
	var order = document.createElement("div");
	os += 1;
	order.id = "order_"+os;
	order.className = "order";
	
	var item = document.createElement("div");
	item.className = "order_item";
	item.appendChild(document.createTextNode("名称："));
	
	var select = document.createElement("select");
	select.name = "product_"+os;
	select.id = "product_"+os;
	select.style.width = "400px";
	var i = 0;
	for (;i<products.length;i+=1)
	{
		if (products[i].type==type)
		{
			var ps = products[i].products;
			var j = 0;
			for (;j<ps.length;j+=1)
			{
				var option = document.createElement("option");
				option.value = ps[j].id;
				option.title = ps[j].name;
				option.appendChild(document.createTextNode(ps[j].name));
				select.appendChild(option);
			}
			break;
		}
	}
	item.appendChild(select);
	
	order.appendChild(item);
	
	item = document.createElement("div");
	item.className = "order_item";
	item.appendChild(document.createTextNode("型号："));
	
	var model = document.createElement("input");
	model.className = "text_input_big";
	model.name = "model_"+os;
	model.id = "model_"+os;
	item.appendChild(model);
	
	order.appendChild(item);
	
	item = document.createElement("div");
	item.className = "order_item";
	item.appendChild(document.createTextNode("数量："));
	
	select = document.createElement("select");
	select.name = "quantity_"+os;
	select.id = "quantity_"+os;
	i = 1;
	for (;i<=50;i+=1)
	{
		var option = document.createElement("option");
		option.value = i;
		option.appendChild(document.createTextNode(i));
		select.appendChild(option);
	}
	item.appendChild(select);
	
	var pad = document.createElement("img");
	pad.src = "images/pad-400.gif";
	item.appendChild(pad);
	
	var a = document.createElement("a");
	a.href = "javascript:delete_order("+os+");";
	a.title = "删除该项";
	a.appendChild(document.createTextNode("删除"));
	item.appendChild(a);
	
	order.appendChild(item);
	
	div.appendChild(order);
}