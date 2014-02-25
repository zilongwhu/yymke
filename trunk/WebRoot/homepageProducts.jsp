<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector" %>
<%@page import="liftingmagnet.com.db.dao.Product" %>
<%@page import="liftingmagnet.com.app.HomepageProducts" %>
<%@page import="liftingmagnet.com.util.StringHelper;"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

  	String idString = request.getParameter("id");
  	boolean valid = true;
  	int id = 0;
  	try
  	{
  		id = Integer.parseInt(idString);
  	}
  	catch(Exception e)
  	{
  		valid = false;
  	}
  	Vector<Product> vp = (Vector<Product>)((HomepageProducts)application.getAttribute("homepageproducts")).getMaps().get(new Integer(id));
  	if (vp==null)
  	{
  		valid = false;
  	}
  	else
  	{
  		Vector<Product> vpc = new Vector<Product>();
		Vector<Integer> orders = (Vector<Integer>)application.getAttribute("product_orders");
		if (orders!=null)
		{
			for (int i=0;i<orders.size();i++)
			{
				int pid = orders.get(i); 
				for (int j=0;j<vp.size();j++)
				{
					if (vp.get(j).getId()==pid)
					{
						vpc.add(vp.get(j));
						break;
					}
				}
			}
		}
		vp = vpc;
  	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
	<base target="_parent">
    
    <title>Promoted products!</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
  <%
  	if (valid)
  	{
   %>
	<script type="text/javascript" src="js/scroll_products.js"></script>
	<script type="text/javascript">
	  	var products = 5;
	  	var product_width = 150;
	  	var max_products = 4;
	  	var pos = [];
	  	window.onload = function()
	  		{
	  			var i = 0;
	  			while(i<products)
	  			{
	  				pos[i] = i*product_width;
	  				i+=1;
	  			}
	  			if (products>max_products)
	  			{
	  				window.setInterval(scroll_products,150);
	  			}
	  			else
	  			{
		  			i = 1;
					while (i<=products)
					{
						document.getElementById("product_"+i).style.left = pos[i-1]+"px";
						i+=1;
					}
	  			}
	  		};
	</script>
	<link rel="stylesheet" type="text/css" href="css/promote_products.css">
  <%
  	}
   %>
  </head>
  <body onmouseover="stop_scrolling();" onmouseout="restart_scrolling();">
  	<div class="products_frame">
  	<%
  		if (valid)
  		{
  	 %>
  		<%
  			int size = vp.size();
  			for (int i=0;i<size;i++)
  			{
  				Product product = vp.get(i);
  		 %>
		<div class="product_border" id="product_<%=i+1 %>">
			<a href="/viewProduct.jsp?id=<%=product.getId() %>" target="_blank" title="<%=StringHelper.transform(product.getName(),'"',"'") %>" onmouseover="show_features(<%=i+1 %>);" onmouseout="hide_features(<%=i+1 %>);"><img width="130px" height="130px" border="0" src="<%=product.getImgPath() %>"></a>
		</div>
		<div class="product_des" id="pd_d_<%=i+1 %>">
	  	 	<div class="product_name" id="pd_n_<%=i+1 %>">
	  	 		<%=product.getName() %>
	  	 	</div>
	  	 	<div class="product_features">
	  	 		<div style="font-weight:bold;color:red;">Product Features:</div>
	  	 		<div style="padding-left:10px;"><%=product.getFeatures() %></div>
	  	 	</div>
	  	 	<div class="product_abstract">
	  	 		<span style="color:red;">
	  	 			<%=product.isPromoted()?"Strongly Promoted!":"" %>
	  	 		</span>
	  	 		<span style="padding-left:20px;">
	  	 			<%=product.getProduceDate() %>
	  	 		</span>
	  	 	</div>
	  </div>
		<%
			}
		 %>
		 <script type="text/javascript">
		 	products = <%=size %>;
		 </script>
	<%
		 }
	%>
	</div>
	<jsp:include page="foot.jsp"></jsp:include>
  </body>
</html>
