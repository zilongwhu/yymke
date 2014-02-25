<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="java.util.Vector" %>
<%@page import="liftingmagnet.com.db.dao.Achievement"%>
<%@page import="liftingmagnet.com.db.dao.Catalog"%>
<%@page import="liftingmagnet.com.app.*" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	ContactInfo contactInfo = (ContactInfo)application.getAttribute("contact_info");

	String type = request.getParameter("type");
	String pageStr = request.getParameter("page");
	int id = -1;
	int pageIndex = 0;
	try
	{
		id = Integer.parseInt(type);
		pageIndex = Integer.parseInt(pageStr);
	}catch(Exception e){}
	
	Vector<Catalog> cats = Catalog.loadChildsFromDB(-1);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath %>">
    
    <title><%=contactInfo.getCompanyName() %>---Achievements</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	
	<link rel="stylesheet" type="text/css" href="css/basic_style.css">
	<link rel="stylesheet" type="text/css" href="css/achievements.css">
	<script type="text/javascript" src="js/iframe_auto_height.js"></script>
	<script type="text/javascript">	
		window.onload = function(){
			update_iframe_height();
			parent.setLocation("&nbsp;<a href='achievements.jsp'>Achievements</a>&nbsp;&gt;");
		};
	</script>
	<jsp:include page="hfoot.jsp"></jsp:include>
  </head>
  
  <body>
    <div class="fix_auto">
    	<form action="achievements.jsp" id="form">
    		Please select product type：
    		<select name="type" onchange="document.getElementById('form').submit();">
    			<% 
    				int size = cats.size(); 
    				boolean valid = false; 
    				for (int i=0;i<size;i++) 
    				{ 
    					Catalog cat = cats.get(i); 
    					if (cat.getId()==id) 
    					{ 
    						valid=true; 
    					} 
    			%>
    				<option value="<%=cat.getId() %>" <%=cat.getId()==id?"selected":"" %>><%=cat.getName() %></option>
    			<%	
    				}
    				if (!valid)
    				{
    					id = cats.get(0).getId();
    				}
    				
					Vector<Achievement> vas = Achievement.getByType(id);
    			 %>
    		</select>
    	</form>
    	<br>
    	<table class="blue" cellspacing="0" cellpadding="0">
    		<thead>
    			<tr>
    				<th>No.</th>
    				<th>Product Name</th>
    				<th>Model</th>
    				<th>Quantity</th>
    				<th>Distribution</th>
    				<th>Deal Date</th>
    			</tr>
    		</thead>
    		<tbody>
    			<%
    				size = vas.size();
    				int numsPerPage = 10;
    				int start = pageIndex*numsPerPage;
    				int end = (pageIndex+1)*numsPerPage;
    				start = start>=size?(size-1)/numsPerPage*numsPerPage:start;
    				start = start<0?0:start;
    				end = end>size?size:end;
    				for (int i=start;i<end;i++)
    				{
    					Achievement a = vas.get(i);
    					Vector<Object[]> orders = a.getOrders();
    					int rows = orders.size();
    					if (rows>0)
    					{
    						Object[] order = orders.get(0);
    			%>
    				<tr>
    					<td width="30px" align="center" rowspan="<%=rows %>"><%=i+1 %></td>
    					<td width="270px" style="padding:5px;"><a href="/viewProduct.jsp?id=<%=order[0] %>" target="_blank" title="click to see more information about this product"><%=order[1] %></a></td>
    					<td width="100px" align="center" style="padding:5px;"><%=order[2] %></td>
    					<td width="50px" align="center">-</td>
    					<td width="100px" align="center" rowspan="<%=rows %>">---</td>
    					<td width="60px" align="center" rowspan="<%=rows %>"><%=a.getDate() %></td>
    				</tr>
    			<%
	    					for (int j=1;j<rows;j++)
	    					{
	    						order = orders.get(j);
    			 %>
		    		<tr>
    					<td width="270px" style="padding:5px;"><a href="/viewProduct.jsp?id=<%=order[0] %>" target="_blank" title="click to see more information about this product"><%=order[1] %></a></td>
    					<td width="100px" align="center" style="padding:5px;"><%=order[2] %></td>
    					<td width="50px" align="center">-</td>
		    		</tr>
	    		<%
	    					}
	    				}
	    			}
	    		 %>
	    	</tbody>
	    </table>
	    <%
			request.setAttribute("numsperpage",new Integer(numsPerPage));
			request.setAttribute("total",new Integer(size));
			request.setAttribute("target","achievements.jsp");
			request.setAttribute("page",new Integer(pageIndex));
			request.setAttribute("type",new Integer(id));
	  %>
		  	<jsp:include page="gotoPage.jsp"></jsp:include>
    </div>
	<jsp:include page="foot.jsp"></jsp:include>
  </body>
</html>
