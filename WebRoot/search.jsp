<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector" %>
<%@page import="liftingmagnet.com.db.dao.Product"%>
<%
	String name = request.getParameter("name");
	String type = request.getParameter("type");
	name = name==null?"":name.trim();
	int id = -1;
	try
	{
		id = Integer.parseInt(type);
	}catch(Exception e){}
	if (!(name.equals(session.getAttribute("search_name"))&&id==(Integer)session.getAttribute("search_id")))
	{
		Vector<Product> vp = Product.search(name,id);
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
		session.setAttribute("search",vpc);
		session.setAttribute("search_name",name);
		session.setAttribute("search_id",new Integer(id));
	}
%>
<jsp:include page="moreProducts.jsp"></jsp:include>
