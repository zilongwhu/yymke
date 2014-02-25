<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="liftingmagnet.com.app.ContactInfo" %>
<%@page import="liftingmagnet.com.db.dao.VisitInfo" %>
<%@page import="java.util.Date"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	ContactInfo contactInfo = (ContactInfo)application.getAttribute("contact_info");
	VisitInfo visitInfo = (VisitInfo)session.getAttribute("visit_info");
	if (visitInfo==null)
	{
		visitInfo = new VisitInfo(request.getRemoteAddr(),new Date(System.currentTimeMillis()),true);
		session.setAttribute("visit_info",visitInfo);
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
	<base target="stage">

    <title><%=contactInfo.getCompanyName() %></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="岳阳强力,强力电磁,lifting,magnet,lifting magnet,electromagnet,yue yang,yueyang">
	<meta http-equiv="description" content="">
	<meta http-equiv="windows-target" content="_top">
	
	<link rel="Shortcut Icon" href="/favicon.ico" type="image/x-icon" />
	<link rel="stylesheet" type="text/css" href="css/basic_style.css">
	<link rel="stylesheet" type="text/css" href="css/style.css">
	
	<script type="text/javascript" src="js/prototype-1.6.0.3.js"></script>
	<script type="text/javascript" src="js/set_home_page.js"></script>
	<script type="text/javascript" src="js/add_favorite.js"></script>
	<script type="text/javascript" src="js/basic.js"></script>
	<script type="text/javascript" src="js/product_list.js"></script>
	<script type="text/javascript" src="js/bug_fixs.js"></script>

	<jsp:include page="hfoot.jsp"></jsp:include>
  </head>
  <script type="text/javascript">
  	window.onload = function()
	{
		var tree_1 = new Image(); tree_1.src = "images/tree/info.gif";
		var tree_2 = new Image(); tree_2.src = "images/tree/product.gif";
		var tree_3 = new Image(); tree_3.src = "images/tree/tree_empty.gif";
		var tree_4 = new Image(); tree_4.src = "images/tree/tree_file.gif";
		var tree_5 = new Image(); tree_5.src = "images/tree/tree_folder.gif";
		var tree_6 = new Image(); tree_6.src = "images/tree/tree_folderopen.gif";
		var tree_7 = new Image(); tree_7.src = "images/tree/tree_line.gif";
		var tree_8 = new Image(); tree_8.src = "images/tree/tree_linebottom.gif";
		var tree_9 = new Image(); tree_9.src = "images/tree/tree_linemiddle.gif";
		var tree_10 = new Image(); tree_10.src = "images/tree/tree_minusbottom.gif";
		var tree_11 = new Image(); tree_11.src = "images/tree/tree_minusmiddle.gif";
		var tree_12 = new Image(); tree_12.src = "images/tree/tree_plusbottom.gif";
		var tree_13 = new Image(); tree_13.src = "images/tree/tree_plusmiddle.gif";
	};
	function setLocation(msg)
	{
		$("location").innerHTML = msg;
	}
  </script>
  <body>
    <div class="main">
    	<div style="margin:0 20px">
    		<div class="header">
		    	<jsp:include page="header.jsp"></jsp:include>
	    	</div>
	    	<div class="nav" id="nav">
		    	<jsp:include page="navigator.jsp"></jsp:include>
	    	</div>
	    	<div>
	    		<div class="left_pane">
		    		<jsp:include page="left.jsp"></jsp:include>
				<div>
					<div style="margin:20px 0 5px 0"><font color=blue>Contact Infomation:</font></div>
					<div><img src="images/contact-en.png" /></div>
				</div>
	    		</div>
	    		<div class="center_pane">
		    		<div class="box_lb_gray">
						<div class="box_rb_gray">
  							<div class="center_panel_title_bg">
						  		<div class="box_lbc_gray">
						  			<div class="box_rbc_gray">
						  				<div class="center_panel_content">
								    		<div class="position"><a href="homepage.jsp">Home</a>&nbsp;&gt;<span id="location"></span></div>
									    	<iframe src="homepage.jsp" width="100%" height="820px" id="stage" name="stage" style="margin-right:20px;" frameborder="0">
									    			
									    	</iframe>
											<img style="display:block;" src="images/img-pad-5.gif">
							    		</div>
						    		</div>
					    		</div>
					    	</div>
		    			</div>
	    			</div>
	    		</div>
	    		<div class="clear"></div>
	    		<div class="footer">
	    			Copyright@2001-2009 <%=contactInfo.getCompanyName() %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<script language='JavaScript' src='http://s53.cnzz.com/stat.php?id=204658&amp;web_id=204658&amp;show=pic' type="text/javascript" charset='gb2312'></script>
	    		</div>
	    	</div>
    	</div>
    </div>
	<jsp:include page="foot.jsp"></jsp:include>
  </body>
</html>
<script language="javascript" src="http://lr.zoosnet.net/JS/LsJS.aspx?siteid=LEF80254127&float=1&lng=en"></script>
