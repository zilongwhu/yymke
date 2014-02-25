<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="liftingmagnet.com.usermanage.*" %>
<%@page import="java.util.Vector" %>
<%
		User user = (User)session.getAttribute("user"); 
    	Authority limits = user.getLimits();
    	if (limits.canManageProductList())
    	{
	    	Vector<Directory> dirs = (Vector<Directory>)request.getAttribute("dirs");
	    	if (dirs==null)
	    	{
	    		dirs = user.getAllDirectories();
	    	}
	    	int selectedId = 0;
	    	try
	    	{
	    		selectedId = Integer.parseInt(request.getParameter("id"));
	    	}catch(Exception e){}
    		int size = dirs.size();
	    	for (int i=0;i<size;i++)
	    	{
	    		Directory dir = dirs.get(i);
%>
	     <option value="<%=dir.getId() %>" <%=selectedId==dir.getId()?"selected":"" %> title="<%=dir.getPath() %>"><%=dir.getPath() %></option>
<%
	    	}
    	}
    	else
    	{
%>
	您权限不够，请与管理员联系！
<%
		}
%>