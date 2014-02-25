<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="liftingmagnet.com.db.dao.Worldwide" %>
<%@page import="liftingmagnet.com.usermanage.*" %>
<%@page import="java.util.Vector"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	User user = (User)session.getAttribute("user");
	Authority limits = user.getLimits();
	if (!limits.canManageWorldwide())
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
    
    <title>岳阳强力电磁有限公司---公司全球代理商管理</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	
	<link rel="stylesheet" type="text/css" href="css/basic.css">
	<link rel="stylesheet" type="text/css" href="css/table.css">
	<style type="text/css">
		body
		{
			text-align: center;
			width: 660px;
		}
		
		.top_div
		{
			margin: 0px auto;
			width: 360px;
			text-align: left;
		}
	</style>
	<script type="text/javascript" src="../../js/iframe_auto_height.js"></script>
	<script type="text/javascript" src="../js/basic.js"></script>
	<script type="text/javascript">
		window.onload = function(){
			update_iframe_height();
			parent.setLocation("公司全球代理商管理");
			<%
				Integer status = (Integer)request.getAttribute("delete_status");
				if (status!=null)
				{
					if (status==1)
					{
			%>
				alert("对不起，您的权限不够，请与管理员联系！");
			<%
					}
					else if (status!=0)
					{
			%>
				alert("对不起，删除出错！");
			<%
					}
					request.removeAttribute("delete_status");
				}
			%>
		};
	</script>
  </head>
  <body>
 	<div class="top_div">
 		<div>
 			<a href="<%=response.encodeURL("addWorldwide.jsp")%>">添加新代理商</a>
 		</div>
 	<%
	  	Vector<Worldwide> wws = Worldwide.getAll();
 	 %>
 		<div style="margin: 5px 0px 0px;">
 			<%=wws.size()>0?"公司目前代理商如下：":"您目前没有添加任何代理商！" %>
 		</div>
    	<table class="blue">
    		<thead>
    			<tr><th>序号</th><th>代理区域</th><th>代理商名称</th></tr>
    		</thead>
    		<tbody>
	<%
	  	for (int i=0;i<wws.size();i++)
	  	{
	  		Worldwide ww = wws.get(i);
	%>
    			<tr class="<%=i%2==0?"odd":"even" %>">
	    			<td width="40px" align="center"><%=i+1 %></td>
	    			<td width="160px" align="center"><%=ww.getArea() %></td>
	    			<td width="160px" align="center"><%=ww.getAgent() %></td>
	    			<td width="40px" align="center">
	    				<a href="<%=response.encodeURL("deleteworldwide?id=" + ww.getId())%>" title="删除代理商<<%=ww.getAgent()%>>" style="margin:0px 5px;">删除</a>
	    			</td>
	    		</tr>
	<%
    	}
	%>
    		</tbody>
    	</table>
    </div>
  </body>
</html>
