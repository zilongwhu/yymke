<%@ page language="java" pageEncoding="UTF-8"%>
<%
	if (request.getServerName().endsWith("yymke.com"))
	{
		response.sendRedirect("zh/index.jsp");
	}
	else
	{
		response.sendRedirect("index.jsp");
	}
%>