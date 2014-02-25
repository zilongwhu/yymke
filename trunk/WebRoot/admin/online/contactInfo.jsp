<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="liftingmagnet.com.app.*" %>
<%@page import="liftingmagnet.com.usermanage.*" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	User user = (User)session.getAttribute("user");
	Authority limits = user.getLimits();
	if (!limits.canManageContactInfo())
	{
		%>
  		<jsp:include page="noPermission.jsp"></jsp:include>
		<%
		return;
	}

	ContactInfo contactInfo = (ContactInfo)application.getAttribute("contact_info");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath+"admin/online/"%>">
    
    <title>岳阳强力电磁有限公司---公司联系方式管理</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	
	<link rel="stylesheet" type="text/css" href="css/basic.css">
	<style type="text/css">
		body
		{
			text-align: center;
			width: 660px;
		}
		
		.top_div
		{
			margin: 0px auto;
			width: 420px;
			text-align: left;
		}
		
		.text_input_big
		{
			width: 300px;
			border: solid 1px #3b97d9;
		}
		
		.text_input_middle
		{
			width: 150px;
			border: solid 1px #3b97d9;
		}
	</style>
	<script type="text/javascript" src="../../js/iframe_auto_height.js"></script>
	<script type="text/javascript" src="../js/basic.js"></script>
	<script type="text/javascript">
		window.onload = function(){
			update_iframe_height();
			parent.setLocation("公司联系方式管理");
			discardModify();
		};
		
		function startModify()
		{
			document.getElementById("modify_button").disabled = true;
			document.getElementById("discard_button").disabled = false;
			document.getElementById("submit_button").disabled = false;
			
			document.getElementById("address").disabled = false;
			document.getElementById("postcode").disabled = false;
			document.getElementById("phone1").disabled = false;
			document.getElementById("phone2").disabled = false;
			document.getElementById("fax1").disabled = false;
			document.getElementById("fax2").disabled = false;
			document.getElementById("email").disabled = false;
			document.getElementById("msn1").disabled = false;
			document.getElementById("msn2").disabled = false;
			
			document.getElementById("address").focus();
		}
		
		function discardModify()
		{
			document.getElementById("change_contact_info_form").reset();
			
			document.getElementById("modify_button").disabled = false;
			document.getElementById("discard_button").disabled = true;
			document.getElementById("submit_button").disabled = true;
			
			document.getElementById("address").disabled = true;
			document.getElementById("postcode").disabled = true;
			document.getElementById("phone1").disabled = true;
			document.getElementById("phone2").disabled = true;
			document.getElementById("fax1").disabled = true;
			document.getElementById("fax2").disabled = true;
			document.getElementById("email").disabled = true;
			document.getElementById("msn1").disabled = true;
			document.getElementById("msn2").disabled = true;
		}
		
		function ok()
		{
			alert("修改成功！");
			location.reload();
		}
	</script>
  </head>
  
  <body>
 	<form target="change_contact_info_hidden" action="modifycontactinfo" method="post" id="change_contact_info_form">
    <div class="top_div">
    	<div><span style="color:red;">注意：</span>公司联系信息是放在公司首页上面的，方便客户联系，请用英文填写。</div>
	    <table>
	    	<tbody>
	    		<tr>
	    			<td>公司地址：</td><td><input class="text_input_big" name="address" id="address" type="text" value="<%=contactInfo.getAddress() %>"><font color="red">*</font></td>
	    		</tr>
	    		<tr>
	    			<td>邮编：</td><td><input class="text_input" name="postcode" id="postcode" type="text" value="<%=contactInfo.getPostcode() %>"><font color="red">*</font></td>
	    		</tr>
	    		<tr>
	    			<td>联系电话1：</td><td><input class="text_input_middle" name="phone1" id="phone1" type="text" value="<%=contactInfo.getPhone1() %>"><font color="red">*</font></td>
	    		</tr>
	    		<tr>
	    			<td>联系电话2：</td><td><input class="text_input_middle" name="phone2" id="phone2" type="text" value="<%=contactInfo.getPhone2() %>"><font color="red">*</font></td>
	    		</tr>
	    		<tr>
	    			<td>传真1：</td><td><input class="text_input_middle" name="fax1" id="fax1" type="text" value="<%=contactInfo.getFax1() %>"><font color="red">*</font></td>
	    		</tr>
	    		<tr>
	    			<td>传真2：</td><td><input class="text_input_middle" name="fax2" id="fax2" type="text" value="<%=contactInfo.getFax2() %>"><font color="red">*</font></td>
	    		</tr>
	    		<tr>
	    			<td>联系邮箱：</td><td><input class="text_input_big" name="email" id="email" type="text" value="<%=contactInfo.getEmail() %>"><font color="red">*</font></td>
	    		</tr>
	    		<tr>
	    			<td>Msn1：</td><td><input class="text_input_big" name="msn1" id="msn1" type="text" value="<%=contactInfo.getMsn1() %>"><font color="red">*</font></td>
	    		</tr>
	    		<tr>
	    			<td>Msn2：</td><td><input class="text_input_big" name="msn2" id="msn2" type="text" value="<%=contactInfo.getMsn2() %>"><font color="red">*</font></td>
	    		</tr>
	    		<tr>
	    			<td colspan="2" align="left"><input type="button" id="modify_button" style="margin: 2px 15px;" value="修改" onclick="startModify();"><input type="button" id="discard_button" style="margin: 2px 15px;" onclick="discardModify();" value="放弃"><input type="submit" id="submit_button" style="margin: 2px 15px;" value="保存"></td>
	    		</tr>
	    	</tbody>
	    </table>
	    <iframe name="change_contact_info_hidden" width="0px" height="0px" frameborder="0" scrolling="no"></iframe>
     </div>
	 </form>
  </body>
</html>
