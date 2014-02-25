<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="liftingmagnet.com.db.dao.*" %>
<%@page import="liftingmagnet.com.usermanage.*" %>
<%@page import="java.util.Vector"%>
<%@page import="liftingmagnet.com.util.StringHelper;"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	User user = (User)session.getAttribute("user");
	Authority limits = user.getLimits();
	if (!(limits.canAddProduct()||limits.canModifyProduct()||limits.canDeleteProduct()))
	{
		%>
  		<jsp:include page="noPermission.jsp"></jsp:include>
		<%
		return;
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath+"admin/online/"%>">
    
    <title>岳阳强力电磁有限公司---产品管理</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	
	<link rel="stylesheet" type="text/css" href="css/basic.css">
	<link rel="stylesheet" type="text/css" href="css/products.css">
	<script type="text/javascript" src="../../js/prototype-1.6.0.3.js"></script>
	<script type="text/javascript" src="../../js/iframe_auto_height.js"></script>
	<script type="text/javascript" src="js/products.js"></script>

	<script type="text/javascript">
		window.onload = function(){
			setInterval(update_iframe_height,100);
			parent.setLocation("查看产品<修改删除>");
		};
	</script>
  </head>
  
  <body>
     <div class="top_div">
    <%
    	String idString = request.getParameter("id");
    	int id = 0;
    	try
    	{
    		id = Integer.parseInt(idString);
    	}catch(Exception e){}
    	
    %>
    	<div style="margin:10px 0px;">
    		 	<a href="products.jsp" title="进入类别<所有产品>">所有产品</a>&gt;
    		<%
    			Catalog parent = Catalog.getParent(id);
    			Vector<Catalog> ps = new Vector<Catalog>();
    			while (parent!=null)
    			{
    				ps.add(parent);
    				parent = Catalog.getParent(parent.getId());
    			}
    			
    			int size = ps.size();
    			for (int i=size-1;i>=0;i--)
    			{
    				parent = ps.get(i);
    		%>
    			<a href="products.jsp?id=<%=parent.getId() %>" title="进入类别<<%=parent.getName() %>>"><%=parent.getName() %></a>&gt;
    		<%
    			}
    			
    			Catalog self = Catalog.getShortInfoById(id);
    			if (self!=null)
    			{
    		 %>
    		    <%=self.getName() %>&gt;
    		 <%
    		    }
    		  %>
    	</div>
    	<div style="margin:10px 0px;">
    		<select id="child" onchange="enter_child();" style="width:400px;">
    			<option value="-1">请选择子类别</option>
    <%
    	Vector<Catalog> childs = Catalog.loadChildsFromDB(id);
    	size = childs.size();
    	for (int i=0;i<size;i++)
    	{
    		Catalog child = childs.get(i);
    		if (child.getType()==0)
    		{
    %>
    			<option value="<%=child.getId() %>" title="<%=child.getName() %>"><%=child.getName() %></option>
    <%
    		}
    	}
    %>
  		  </select>
	  	  <input name="type" value="1" type="checkbox" checked id="type" onclick="toggle_infos();">
	  	  <label for="type">介绍信息</label>
   		</div>
   		<div style="margin-left:10px;">
   		<div id="infos" style="margin-bottom:20px;">
		<%
		    	Vector<Catalog> cats = Catalog.loadChildsFromDB(id);
			    for (int i=0;i<cats.size();)
			    {
			    	Catalog cat = cats.get(i);
			    	if (cat.getType()!=1)
			    	{
			    		cats.remove(i);
			    	}
			    	else
			    	{
			    		i++;
			    	}
				}
			    size = cats.size();	
			    if(size>0)
			    {	    		
		%>
			<div style="text-align:center;font-size:14px;font-weight:bold;color:blue;">介绍信息</div>
		   	<table cellspacing="0" cellpadding="0">
			  	<tbody>
		<%
				    for (int i=0;i<size;i++)
				    {
			    		Catalog cat = cats.get(i);
		%>		
		 		<tr>
		 			<td width="520px" class="dotted_border">
		 				<a class="introduction" href="/viewInfo.jsp?id=<%=cat.getId() %>" target="_blank" title="查看详细信息"><%=cat.getName() %></a>
		 			</td>
	 			<%
		 				if ((limits.canModifyProduct()||limits.canDeleteProduct()))
		 				{
		 					if(limits.canModifyProduct())
		 					{
	 			 %>
		 			<td class="dotted_border" width="30px" align="left"><a style="margin-left: 2px;" href="modifyInfo.jsp?id=<%=cat.getId() %>" title="修改<<%=cat.getName() %>>"><img src="images/product-modify.gif" border="0"></a></td>
	 			<%
		 					}
		 					else
		 					{
	 			 %>
		 			<td class="dotted_border" width="30px" align="left">&nbsp;</td>
	 			<%
		 					}
		 					if(limits.canDeleteProduct())
		 					{
	 			 %>
		 			<td class="dotted_border" width="30px" align="center"><a href="javascript:delete_product(<%=cat.getId() %>)" title="永久删除信息<<%=cat.getName() %>>"><img src="images/product-delete.gif" border="0"></a></td>
	 			<%
		 					}
		 					else
		 					{
	 			 %>
		 			<td class="dotted_border" width="30px" align="left">&nbsp;</td>
	 			<%
	 						}
	 					}
	 					else
	 					{
	 			 %>
		 			<td class="dotted_border" width="30px" align="left">&nbsp;</td>
		 			<td class="dotted_border" width="30px" align="left">&nbsp;</td>
	 			 <%
	 					}
	 			 %>
		 		</tr>
		<%		
		    		}
		%>
			  </tbody>
			</table>
		<%
			}
			else
			{
	     %>
	     	<div style="margin:10px 0px;text-align:center;">
	     		该类别下目前没有介绍信息！
	     	</div>
	     <%
	     	}
	      %>
   		</div>
   		<div>
    <%
    	Vector<Product> all = Product.getProductsByParent(id);
    	int total = all.size();
    	if (total>0)
    	{
    %>
    	<div style="text-align:center;font-size:14px;font-weight:bold;color:blue;">产&nbsp;&nbsp;&nbsp;品</div>
    		<table>
    			<tbody>
    <%
    		for (int i=0;i<total;i++)
    		{
    			Product product = all.get(i);
    			if (i%4==0)
    			{
     %>
     				<tr>
     <%
     			}
      %>
      					<td align="left">
					    	<div class="product">
					    		<div class="product_img">
					    			<a href="/viewProduct.jsp?id=<%=product.getId() %>" target="_blank" title="点击查看<<%=product.getName() %>>的详细信息">
					    				<img width="125px" height="125px" src="<%=product.getImgPath() %>" border="0">
					    			</a>
					    		</div>
					    		<div class="product_name">
					    			<a href="/viewProduct.jsp?id=<%=product.getId() %>" title="<%=product.getName() %>" target="_blank">
					    				<%=StringHelper.getFristNChars(product.getName(),20) %>
					    			</a>
					    		</div>
					    		<%
					    			if (limits.canModifyProduct()||limits.canDeleteProduct())
					    			{
					    		 %>
					    		<div class="product_operations">
					    			<%
					    				if (limits.canModifyProduct())
					    				{
					    			 %>
					    			 <a href="modifyProduct.jsp?id=<%=product.getId() %>" title="修改产品详细信息"><img src="images/product-modify.gif" border="0"></a>
					    			 <%
					    			 	}
					    				if (limits.canDeleteProduct())
					    				{
					    			 %>
					    			 <a style="margin-left:5px;" href="javascript:delete_product(<%=product.getId()%>);" title="永久删除产品"><img src="images/product-delete.gif" border="0"></a>
					    			 <%
					    			 	}
					    			  %>
					    		</div>
					    		<%
					    			}
					    		 %>
					    	</div>
					    </td>
    <%
    			if (i%4==3||i==total-1)
    			{
    %>
    				</tr>
    <%
    			}
    		}
    %>
    			</tbody>
    		</table>
    <%
    	}
    	else
    	{
     %>
     	<div style="margin:10px 0px;text-align:center;">
     		该类别下目前没有产品！
     	</div>
     <%
     	}
      %>
      </div>
      </div>
	 </div>
  </body>
</html>
