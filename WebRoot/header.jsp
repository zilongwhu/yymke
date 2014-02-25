<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="liftingmagnet.com.app.*" %>
<%
	ContactInfo contactInfo = (ContactInfo)application.getAttribute("contact_info");
	String siteurl = request.getScheme()+"://"+request.getServerName();
 %>
<table width="944px">
 	<tbody>
 		<tr>
 			<td>
				<table><tbody><tr>
					<td><a class="img" href="index.jsp" target="_blank"><img src="images/logo_e_mk.png" border=0></a></td>
					<td valign="center"><span class="company_name"><%=contactInfo.getCompanyName() %></span></td>
				</tr></tbody></table>
	   		 </td>
 			<td valign="bottom" align="right">
		    	<ul class="facility">
		    		<li><a class="set_home" href="javascript:setHomePage('<%=siteurl%>');" target="_self" title="set home page">Set Home</a></li>
		    		<li><a class="add_favorite" href="javascript:addFavorite('<%=siteurl%>');" target="_self" title="add home page to your favorite">Favorite</a></li>
		    		<li><a class="email_to" href="mailto:starwang@liftingmangnet.com.cn" target="_self" title="send email to us">Email</a></li>
		    	</ul>
		    </td>
 		</tr>
 	</tbody>
</table>
