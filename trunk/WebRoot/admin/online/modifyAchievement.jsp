<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="liftingmagnet.com.db.dao.Catalog"%>
<%@page import="liftingmagnet.com.db.dao.Achievement"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="liftingmagnet.com.usermanage.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	User user = (User)session.getAttribute("user");
	Authority limits = user.getLimits();
	if (!limits.canModifyAchievement())
	{
		%>
  		<jsp:include page="noPermission.jsp"></jsp:include>
		<%
		return;
	}
	
	String idString = request.getParameter("id");
	int aid = -1;
	try
	{
		aid = Integer.parseInt(idString);
	}catch(Exception e){}

	Vector<Catalog> types = Catalog.loadChildsFromDB(0);
	JSONArray typesArr = new JSONArray();
	int size = types.size();
	for (int i=0;i<size;i++)
	{
		Catalog c = types.get(i);
		JSONObject obj = new JSONObject();
		obj.put("type",c.getId());
		obj.put("name",c.getName());
		typesArr.put(obj);
	}
	
	HashMap<Integer,Vector<Catalog>> maps = Catalog.getAllChildProducts();
	JSONArray productsArr = new JSONArray();
	Set<Integer> keys = maps.keySet();
	Iterator<Integer> itr = keys.iterator();
	while (itr.hasNext())
	{
		Integer id = itr.next();
		Vector<Catalog> ps = maps.get(id);
		
		JSONObject obj = new JSONObject();
		obj.put("type",id.intValue());
		JSONArray arr1 = new JSONArray();
		size = ps.size();
		for (int i=0;i<size;i++)
		{
			Catalog c = ps.get(i);
			JSONObject obj1 = new JSONObject();
			obj1.put("id",c.getId());
			obj1.put("name",c.getName());
			arr1.put(obj1);
		}
		obj.put("products",arr1);
		productsArr.put(obj);
	}
	
	Achievement a = Achievement.getById(aid);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath+"admin/online/"%>">
    
    <title>岳阳强力电磁有限公司---添加新业绩表</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	
	<link rel="stylesheet" type="text/css" href="css/basic.css">
	<link rel="stylesheet" type="text/css" href="css/add_achievement.css">
	<script type="text/javascript" src="../../js/prototype-1.6.0.3.js"></script>
	<script type="text/javascript" src="../../js/iframe_auto_height.js"></script>
	<script type="text/javascript" src="../js/basic.js"></script>
	<script type="text/javascript" src="js/addachievement.js"></script>
	<script type="text/javascript">
		var types = <%=typesArr.toString()%>;
		var products = <%=productsArr.toString()%>;
		var os = 0;
		
		function callback(status,type)
		{
			if (status==0)
			{
				alert("修改成功！");
				window.location.href = "achievements.jsp?type="+type;
			}
			else if(status==1)
			{
				alert("对不起，您的权限不够，请与管理员联系！");
			}
			else
			{
				alert("对不起，修改出错！");
			}
		}
	</script>
  </head>
  
  <body>
    <div class="top_div">
    <%
    	if (a!=null)
    	{
    		Vector<Object[]> orders = a.getOrders();
    		int num = orders.size();
    		
     %>
     <script type="text/javascript">
		window.onload = function(){
			window.setInterval(update_iframe_height,100);
			parent.setLocation("修改业绩表");
			$("destination").focus();
     	<%
     		for (int i=0;i<num;i++)
    		{
    			Object[] objs = orders.get(i);
     	%>
     		add();$("product_"+os).value="<%=objs[0]%>";$("model_"+os).value="<%=objs[2]%>";$("quantity_"+os).value="<%=objs[3]%>";
	    <%
	    	}
	     %>
		};
     </script>
    <form action="modifyachievement" method="post" target="modify_achievement_hidden" id="modifyachievement_form">
    <input type="hidden" name="id" value="<%=aid %>">
    	<div>
    		<table>
    			<tbody>
	    			<tr>
	    				<td>产品发送地：</td><td><input class="text_input_big" type="text" name="destination" id="destination" value="<%=a.getDestination() %>"><font color="red">*</font></td>
	    			</tr>
	    			<tr>
	    				<td>交易时间：</td>
	    				<td>
	    					<select name="year">
				  			<%
				  				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				  				int year = sdf.parse(a.getDate()).getYear()+1900;
				  				for (int i=1996;i<2050;i++)
				  				{
				  			 %>
				  				<option value="<%=i %>" <%=i==year?"selected":"" %>><%=i %></option>
				  			<%
				  				}
				  			%>
				  			</select>
				  			年
				  			<select name="month">
				  			<%
				  				int month = sdf.parse(a.getDate()).getMonth()+1;
				  				for (int i=1;i<13;i++)
				  				{
				  			 %>
				  				<option value="<%=i %>" <%=i==month?"selected":"" %>><%=i %></option>
				  			<%
				  				}
				  			%>
				  			</select>
				  			月
				  			<font color="red">*</font>
	    				</td>
	    			</tr>
	    			<tr>
	    				<td>产品类型：</td>
	    				<td>
					    	<select name="type" id="type" onchange="change_products();">
								<%
									
									for (int i=0;i<types.size();i++)
									{
										Catalog cat = types.get(i);
								 %>
								   	<option value="<%=cat.getId() %>" <%=a.getType()==cat.getId()?"selected":"" %>><%=cat.getName() %></option>
								<%
									}
								 %>
							</select><font color="red">*</font>
							<a style="margin-left:20px;" href="javascript:add();">添加</a>
						</td>
					</tr>
	    		</tbody>
	    	</table>
	    </div>
	    <div id="orders"></div>
    	<div>
    		<input type="submit" value="修改" style="margin: 5px 20px 10px 100px;">
    		<input type="reset" value="重置" style="margin: 5px 20px 10px;">
    	</div>
    	</form>
    <%
    	}
    	else
    	{
     %>
     	<div style="text-align:center;">您要修改的业绩表不存在！</div>
     <%
     	}
      %>
    </div>
    <iframe name="modify_achievement_hidden" width="0px" height="0px" frameborder="0" scrolling="no"></iframe>
  </body>
</html>