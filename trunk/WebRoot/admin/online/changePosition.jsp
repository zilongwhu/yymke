<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="liftingmagnet.com.usermanage.*" %>
<%@page import="java.util.Vector" %>
<%@page import="liftingmagnet.com.db.dao.Catalog" %>
	<option value="-1">请选择位置</option>
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
 		<option value="<%=cat.getId() %>">置于&lt;<%=cat.getName() %>&gt;之后</option>
<%		
			}
    	}
%>