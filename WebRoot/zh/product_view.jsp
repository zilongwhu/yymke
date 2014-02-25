<%@ page language="java" import="java.sql.*,liftingmagnet.com.db.dao.*" pageEncoding="UTF-8"%>
<%@page import="utils.*;"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	VisitInfo visitInfo = (VisitInfo)session.getAttribute("visit_info_zh");
	if (visitInfo==null)
	{
		visitInfo = new VisitInfo(request.getRemoteAddr(),new Date(System.currentTimeMillis()),false);
		session.setAttribute("visit_info_zh",visitInfo);
	}
%>
<%
	String topic = "";
	String date = "";
	String content = "";
	int id = -1;
	
	Connection con = Util.getConnection();
	try {
		PreparedStatement state = con.prepareStatement("SELECT * FROM t_product WHERE id=?");
		state.setString(1,request.getParameter("id"));
		ResultSet rs = state.executeQuery();
		if (rs.next())
		{
			topic = rs.getString("topic");
			date = rs.getString("date");
			content = rs.getString("content");
			id = rs.getInt("typeid");
		}
		rs.close();
		state.close();
	} catch (SQLException e) {
		e.printStackTrace();
		topic = "";
		date = "";
		content = "";
		id = -1;
	}
	Util.closeConnection(con);
%>
<html>
	<head>
		<base href="<%=basePath+"zh/" %>"/>
		<meta http-equiv="Content-Language" content="zh-cn">
		
		<style>
		<!--
			td           { font-size: 12px }
		-->
		</style>
	</head>

	<body topmargin="3" leftmargin="3" rightmargin="3" bottommargin="3" marginwidth="3" marginheight="3">
		<table border="0" width="100%" id="table1" cellspacing="0" cellpadding="5">
			<tr>
				<td align="center" style="font-family: serif; font-size: 30px; font-weight: bold;"><%=topic%></td>
			</tr>
			<tr>
				<td>位置:产品展示&gt;&gt;&gt;<%=utils.Util.getParent(id)%></td>
			</tr>
			<tr>
				<td align="right">录入时间：<%=date%><span style="cursor:pointer" onClick="window.print()">【打印此页】</span> <span style="cursor:pointer" onClick="window.close()">【关闭窗口】</span> </td>
			</tr>
			<tr>
				<td><%=content%></td>
			</tr>
		</table>
	<jsp:include page="bd_foot.jsp"></jsp:include>
	</body>
	<script language="javascript">
	<!--
		function window.onload(){
			W=screen.width;
			H=screen.height;
			window.moveTo(W*0.1,H*0.06)
			window.resizeTo(W*0.8,H*0.8);
		}
		function window.onresize(){
			W=document.body.clientWidth;
			H=document.body.clientHeight;
		}
	//-->
	</script>
</html>
