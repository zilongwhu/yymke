<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="liftingmagnet.com.app.*" %>
<%@page import="java.util.Vector" %>
<%@page import="liftingmagnet.com.db.dao.Product"%>
<%@page import="liftingmagnet.com.util.StringHelper"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	ContactInfo contactInfo = (ContactInfo)application.getAttribute("contact_info");

 	int pageIndex = 0;
 	try
 	{
 		pageIndex = Integer.parseInt(request.getParameter("page"));
 	}catch(Exception e){}
	
	Vector<Product> vp = (Vector<Product>)session.getAttribute("search");
	if (vp==null)
	{
		return;
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
	<base target="_self">
    
    <title><%=contactInfo.getCompanyName() %>---Products</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	
	<link rel="stylesheet" type="text/css" href="css/basic_style.css">
	<link rel="stylesheet" type="text/css" href="css/search.css">
	<script type="text/javascript" src="js/iframe_auto_height.js"></script>
	<script type="text/javascript">
	window.onload = function(){
		update_iframe_height();
		parent.setLocation("&nbsp;<a href='search.jsp'>Products</a>&nbsp;&gt;");
	};
	function toggle(visible,id)
	{
		if (visible)
		{
			document.getElementById("pd_"+id).style.display = "block";
		}
		else
		{
			document.getElementById("pd_"+id).style.display = "none";
		}
	}
	</script>
	<jsp:include page="hfoot.jsp"></jsp:include>
  </head>
  
  <body>
  	<%
  		int size=vp.size();
  		if (size>0)
  		{
	  		int numsPerPage = 12;
	  		int start = pageIndex*numsPerPage;
	  		int end = (pageIndex+1)*numsPerPage;
	  		end = end>size?size:end;
	  		int cols = 4;
	  		int rows = (end-start)/cols + ( (end-start)%cols>0?1:0 );
  	%>
  		<div style="position:relative;width:<%=cols*150 %>px;height:<%=rows*150 %>px;">
	  	<%
		  	for (int i=start;i<end;i++)
		  	{
		  		Product product = vp.get(i);
		  		int x = (i-start)%4;
		  		int y = (i-start)/4;
		%>
	  	 		<div style="position:absolute;z-index:1;width:135px;*width:141px;height:135px;*height:141px;border:solid 1px gray;padding:2px;margin:5px;left:<%=x*150 %>px;top:<%=y*150 %>px;">
					 <a href="/viewProduct.jsp?id=<%=product.getId() %>" target="_blank" title="click to see more about<<%=StringHelper.transform(product.getName(),'"',"'") %>>" onmouseover="toggle(true,<%=product.getId() %>);" onmouseout="toggle(false,<%=product.getId() %>);"><img width="135px" height="135px" src="<%=product.getImgPath() %>" border="0" style="position:fixed;z-index:0;"></a>
				</div>
				<div style="position:absolute;width:300px;display:none;background-color:#f8f8f8;border:solid 1px gray;padding:0px;z-index:2;<%=i%4<2?"left:"+(x+1)*150+"px;top:"+y*150+"px":"left:"+(x*150-300)+"px;top:"+y*150+"px;" %>" id="pd_<%=product.getId() %>">
			  	 	<div class="product_name">
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
	  		</div>
	  <%
			request.setAttribute("numsperpage",new Integer(12));
			request.setAttribute("total",new Integer(size));
			request.setAttribute("target","moreProducts.jsp");
			request.setAttribute("page",new Integer(pageIndex));
	  %>
		  	<jsp:include page="gotoPage.jsp"></jsp:include>
  <%
  	 	}
  	 	else
  	 	{
  	 		String name = (String)session.getAttribute("search_name");
   %>
   		<div style="text-algin:center;margin:10px;">No matching product<%=name==null||name.length()==0?"":" for &lt;"+name+"&gt;" %>!</div>
   <%
  	  	}
  %>
	<jsp:include page="foot.jsp"></jsp:include>
  </body>
</html>
