<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="liftingmagnet.com.usermanage.*" %>
<%@page import="java.util.Vector" %>
<%@page import="liftingmagnet.com.db.dao.Catalog" %>

	<table cellspacing="0" cellpadding="0">
	  <tbody>
	  
<%
		User user = (User)session.getAttribute("user"); 
    	Authority limits = user.getLimits();
    	if (limits.canManageProductList())
    	{
    		int id = -1;
    		try
    		{
    			id = Integer.parseInt(request.getParameter("catalog_id"));
    		}catch(Exception e){}
    		
    		Vector<Catalog> cats = Catalog.loadChildsFromDB(id);
	    	int size = cats.size();
	    	for (int i=0;i<size;i++)
	    	{
	    		Catalog cat = cats.get(i);
%>		
 		<tr>
 			<td class="dotted_border"><input type="checkbox" name="moving" value="<%=cat.getId() %>" onclick="check_movable('moving');check_placeable('moving');"></td>
 			<td width="500px" class="dotted_border">
 				<div class="<%=cat.getType()==0?"type":cat.getType()==1?"info":"product"%>">
	 				<a href="<%=cat.getType()==0?"javascript:enter_child("+cat.getId()+");":(cat.getType()==1?"/viewInfo.jsp?id="+cat.getId():"/viewProduct.jsp?id="+cat.getId())%>" <%=cat.getType()==0?"":"target='_blank'" %> title="<%=cat.getType()==0?"进入子类别":"查看详细信息"%>"><%=cat.getName() %></a>
 				</div>
 			</td>
 			<%
 				if ((limits.canModifyProduct()||limits.canDeleteProduct())&&cat.getType()!=0)
 				{
 					if(limits.canModifyProduct())
 					{
 			 %>
 			<td class="dotted_border" width="30px" align="left"><a style="margin-left: 2px;" href="modify<%=cat.getType()==1?"Info":"Product" %>.jsp?id=<%=cat.getId() %>"><img src="images/product-modify.gif" border="0"></a></td>
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
 			<td class="dotted_border" width="30px" align="center"><a href="javascript:delete_product(<%=cat.getId() %>)" title="删除<<%=cat.getName() %>>"><img src="images/product-delete.gif" border="0"></a></td>
 			<%
 					}
 					else
 					{
 			 %>
 			<td class="dotted_border" width="30px" align="left">&nbsp;</td>
 			<%
 					}
 					
 				}
 			 	else if(cat.getType()==0)
 				{
 			 %>
 			<td class="dotted_border" width="30px" align="left"><a href="javascript:toggle_product_catalog_state(<%=cat.getId() %>)" title="<%=cat.isOpened()?"关闭<"+cat.getName()+">":"打开<"+cat.getName()+">" %>" id="pcs_a<%=cat.getId() %>"><img src="/images/tree/tree_folder<%=cat.isOpened()?"open":"" %>.gif" border="0" id="pcs_img<%=cat.getId() %>"></a></td>
 			<td class="dotted_border" width="30px" align="center"><a href="javascript:delete_product_catalog(<%=cat.getId() %>)" title="删除<<%=cat.getName() %>>"><img src="images/product-delete.gif" border="0"></a></td>
 			<%
 				}
 			 %>
 		</tr>
<%		
			}
    	}
%>
	  </tbody>
	</table>