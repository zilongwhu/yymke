<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="net.fckeditor.FCKeditor"%>
<%@page import="liftingmagnet.com.db.dao.*"%>
<%@page import="java.util.Vector"%>
<%@page import="java.io.File"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="liftingmagnet.com.usermanage.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

	User user = (User)session.getAttribute("user");
	Authority limits = user.getLimits();
	if (!limits.canModifyProduct())
	{
		%>
  		<jsp:include page="noPermission.jsp"></jsp:include>
		<%
		return;
	}
	
	session.setAttribute("manage_command","products");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath+"admin/online/"%>">
    
    <title>岳阳强力电磁有限公司---修改介绍信息</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	
	<link rel="stylesheet" type="text/css" href="css/basic.css">
	<link rel="stylesheet" type="text/css" href="css/addproduct.css">
	<script type="text/javascript" src="../../js/prototype-1.6.0.3.js"></script>
	<script type="text/javascript" src="../../js/iframe_auto_height.js"></script>
	<script type="text/javascript" src="../js/basic.js"></script>
	<script type="text/javascript" src="js/addproduct.js"></script>
	<script type="text/javascript">
		var parent_ids = [];
		var index = -1;
		var parent_id = 0;
		
		window.onload = function(){
			window.setInterval(update_iframe_height,100);
			parent.setLocation("修改介绍信息");
			Event.observe($("modify_info_form"),"submit",check_valid);
			init_2();
		};
		
		function check_valid(evt)
		{
			var name = getInputValue("name");
			if (name.length==0)
			{
				Event.stop(evt);
				alert("名称没有填写！");
				$("name").focus();
				return;
			}
		}
		
		function callback(status)
		{
			if (status==1)
			{
				alert("新闻内容必须填写！");
			}
		}
	</script>

  </head>
  <%
  	String idString = request.getParameter("id");
  	int id = -1;
  	try
  	{
  		id = Integer.parseInt(idString);
  	}catch(Exception e){}
  	
  	Catalog info = Catalog.getFullInfoById(id);
   %>
  <body>
    <form action="modifyinfo" id="modify_info_form" method="post">
  	<div class="top_div">
  		<%
  			if (info!=null&&info.getType()==1)
  			{
  				Catalog parent = Catalog.getParent(info.getId());
  				if (parent!=null)
  				{
  					int parentId = parent.getId();
	  				parent = Catalog.getParent(parent.getId());
	  				Vector<Integer> ps = new Vector<Integer>();
	  				while (parent!=null)
	  				{
	  					ps.add(parent.getId());
	  					parent = Catalog.getParent(parent.getId());
	  				}
	  				ps.add(0);
	  				String psString = "0";
	  				int size = ps.size();
	  				for (int i=size-2;i>=0;i--)
	  				{
	  					psString += "," + ps.get(i);
	  				}
  		 %>
  		 <script type="text/javascript">
  		 	parent_ids = [<%=psString %>];
  		 	index = parent_ids.length - 1;
  		 	parent_id = <%=parentId %>;
  		 </script>
  		 <%
  		 		}
  		  %>
  		<div class="header">名称</div>
  		<div style="margin:5px 0px 5px 30px;">
  			<input type="hidden" name="id" value="<%=info.getId() %>">
  			<input class="text_input_big" type="text" name="name" id="name" value="<%=info.getName() %>">
  		</div>
  		<div class="header">所属分类</div>
	  	<div style="margin:5px 0px 5px 30px;" id="product_type"></div>
  		<div class="header">详细内容</div>
  		<div style="margin: 5px 0px 10px 30px;border:solid 1px #3b97d9;">
		    <%
		    	File file = new File(application.getRealPath(Catalog.getIntroductionPath(info.getTarget())));
		    	BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file)));
		    	StringBuffer sb = new StringBuffer();
		    	String line = br.readLine();
		    	while (line!=null)
		    	{
		    		sb.append(line);
		    		line = br.readLine();
		    	}
		    	br.close();
		    	
		    	FCKeditor editor = new FCKeditor(request,"content");
		    	editor.setBasePath("/admin/online/fckeditor");
		    	editor.setToolbarSet("MySite");
		    	editor.setValue(sb.toString());
		    	editor.setWidth("608px");
		    	editor.setHeight("560px");
		    	out.write(editor.toString());
		     %>
  		</div>
  		<div>
  			<input type="submit" value="修改" style="margin-left:250px;">
  			<input type="reset" value="重置" style="margin-left:30px;">
  		</div>
  		<%
  			}
  			else
  			{
  		 %>
  		 您要修改的介绍信息不存在！
  		 <%
  		 	}
  		  %>
  	</div>
  	</form>
  </body>
</html>
