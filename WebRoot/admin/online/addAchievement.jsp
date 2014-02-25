<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="liftingmagnet.com.db.dao.Catalog"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="liftingmagnet.com.usermanage.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

	User user = (User)session.getAttribute("user");
	Authority limits = user.getLimits();
	if (!limits.canAddAchievement())
	{
		%>
  		<jsp:include page="noPermission.jsp"></jsp:include>
		<%
		return;
	}
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
		
		window.onload = function(){
			window.setInterval(update_iframe_height,100);
			parent.setLocation("添加新业绩表");
			$("destination").focus();
			change_products();
		};
		
		function callback(status,type)
		{
			if (status==0)
			{
				alert("添加成功！");
				window.location.href = "achievements.jsp?type="+type;
			}
			else if(status==1)
			{
				alert("对不起，您的权限不够，请与管理员联系！");
			}
			else
			{
				alert("对不起，添加出错！");
			}
		}
	</script>
  </head>
  
  <body>
    <div class="top_div">
    <form action="addachievement" method="post" target="add_worldwide_hidden" id="addworldwide_form">
    	<div>
    		<table>
    			<tbody>
	    			<tr>
	    				<td>产品发送地：</td><td><input class="text_input_big" type="text" name="destination" id="destination"><font color="red">*</font></td>
	    			</tr>
	    			<tr>
	    				<td>交易时间：</td>
	    				<td>
	    					<select name="year">
				  			<%
				  				int year = java.util.Calendar.getInstance().getTime().getYear() + 1900;
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
				  				int month = java.util.Calendar.getInstance().getTime().getMonth()+1;
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
								   	<option value="<%=cat.getId() %>"><%=cat.getName() %></option>
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
    		<input type="submit" value="添加" style="margin: 5px 20px 10px 100px;">
    		<input type="reset" value="重置" style="margin: 5px 20px 10px;">
    	</div>
    	</form>
    </div>
    <iframe name="add_worldwide_hidden" width="0px" height="0px" frameborder="0" scrolling="no"></iframe>
  </body>
</html>
