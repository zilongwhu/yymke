<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="net.fckeditor.FCKeditor"%>
<%@page import="liftingmagnet.com.db.dao.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
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
    
    <title>岳阳强力电磁有限公司---修改产品信息</title>
    
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
			parent.setLocation("修改产品信息");
			Event.observe($("modify_product_form"),"submit",check_valid);
			init_2();
		};
		
		function change_homepage()
		{
			if ($F("homepage1")=="true"&&!$("homepage").checked
				||$F("homepage1")=="false"&&$("homepage").checked)
			{
				$("homepage_changed").value = "yes";
			}
			else
			{
				$("homepage_changed").value = "no";
			}
		}
		
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
			var path = getInputValue("img_path");
			if (path.length==0)
			{
				Event.stop(evt);
				alert("没有为产品指定主图片！");
				return;
			}
			var features = getInputValue("features");
			if (features.length==0)
			{
				Event.stop(evt);
				alert("没有输入产品特征描述信息！");
				$("features").focus();
				return;
			}
		}
		
		function callback(status)
		{
			if (status==1)
			{
				alert("产品详细信息必须填写！");
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
  	
  	Product product = Product.getProductById(id);
   %>
  <body>
    <form action="modifyproduct" id="modify_product_form" method="post">
  	<div class="top_div">
  		<%
  			if (product!=null)
  			{
  				if (product.getParent()>0)
  				{
	  				Catalog parent = Catalog.getParent(product.getParent());
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
  		 	parent_id = <%=product.getParent() %>;
  		 </script>
  		 <%
  		 		}
  		  %>
  		<div class="header">名称</div>
  		<div style="margin:5px 0px 5px 30px;">
  			<input type="hidden" name="id" value="<%=product.getId() %>">
  			<input class="text_input_big" type="text" name="name" id="name" value="<%=product.getName() %>">
  		</div>
  		<div class="header">所属分类</div>
	  	<div style="margin:5px 0px 5px 30px;" id="product_type"></div>
	  	<div id="type_selector">
	  		<div class="header">产品主图片</div>
	  		<div style="margin:5px 0px 5px 30px;position:relative;width:600px;">
	  			<input type="hidden" name="img_path" id="img_path" value="<%=product.getImgPath() %>">
	  			<input type="text" class="text_input_big" disabled id="img_path2" value="<%=product.getImgPath() %>"><input style="margin-left:15px;width:40px;" type="button" value="上传" onclick="upload_img();">
	  			<input style="margin-left:15px;width:40px;" type="button" value="预览" onclick="preview_image();" id="preview_button">
	  			<div id="preview" style="position:absolute;right:30px;top:0px;display:none;border:solid 1px gray;padding:2px;background-color:white;*padding-bottom:1px;">
	  				<img id="preview_img" src="" width="130px" height="130px" border="0">
	  			</div>
	  		</div>
	  		<div class="header">特征描述</div>
	  		<div style="margin:5px 0px 5px 30px;">
	  			<textarea name="features" id="features" style="width:480px;height:80px;border:solid 1px #3b97d9;font-size:12px;"><%=product.getFeatures() %></textarea>
	  		</div>
	  		<div class="header">附加设置</div>
	  		<div style="margin:5px 0px 5px 30px;">
	  			<input type="checkbox" name="promoted" value="yes" <%=product.isPromoted()?"checked":"" %> id="promoted" style="margin-right:10px;"><label for="promoted"><font color="blue">强烈推荐产品</font></label>
	  			<input type="checkbox" name="homepage" id="homepage" value="yes" <%=product.isOnHomepage()?"checked":"" %> id="homepage" style="margin-left:30px;margin-right:10px;" onclick="change_homepage();"><label for="homepage"><font color="blue">将产品放置在首页</font></label>
	  			<input type="hidden" id="homepage1" value="<%=product.isOnHomepage()?"true":"false" %>">
	  			<input type="hidden" name="homepage_changed" id="homepage_changed" value="no">
	  			<select style="margin-left:55px;" name="year">
	  			<%
	  				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	  				Date date = df.parse(product.getProduceDate());
	  				int year = date.getYear() + 1900;
	  				for (int i=1996;i<2050;i++)
	  				{
	  			 %>
	  				<option value="<%=i %>" <%=i==year?"selected":"" %>><%=i %></option>
	  			<%
	  				}
	  			%>
	  			</select>
	  			<font color="blue">年</font>
	  			<select name="month">
	  			<%
	  				int month = date.getMonth()+1;
	  				for (int i=1;i<13;i++)
	  				{
	  			 %>
	  				<option value="<%=i %>" <%=i==month?"selected":"" %>><%=i %></option>
	  			<%
	  				}
	  			%>
	  			</select>
	  			<font color="blue">月上市</font>
	  		</div>
  		</div>
  		<div class="header">详细内容</div>
  		<div style="margin: 5px 0px 10px 30px;border:solid 1px #3b97d9;">
		    <%
		    	File file = new File(application.getRealPath(product.getPath()));
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
  		 您要修改的产品不存在！
  		 <%
  		 	}
  		  %>
  	</div>
  	</form>
  </body>
</html>
