<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="liftingmagnet.com.app.*" %>
<%@page import="liftingmagnet.com.db.dao.News" %>
<%@page import="java.util.Vector" %>
<%@page import="liftingmagnet.com.util.StringHelper"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	ContactInfo contactInfo = (ContactInfo)application.getAttribute("contact_info");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
	<base target="_self">
    
    <title><%=contactInfo.getCompanyName() %></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	
	<link rel="stylesheet" type="text/css" href="css/basic_style.css">
	<link rel="stylesheet" type="text/css" href="css/homepage_style.css">
	<script type="text/javascript" src="js/prototype-1.6.0.3.js"></script>
	<script type="text/javascript" src="js/change_panel.js"></script>
	<script type="text/javascript" src="js/iframe_auto_height.js"></script>
	<script type="text/javascript" src="js/filter.js"></script>
	<script type="text/javascript">
	
	window.onload = function(){
		Event.observe($("news_h"),"mouseover",change_na_panel);
		Event.observe($("achievements_h"),"mouseover",change_na_panel);
		Event.observe($("a_news"),"mouseover",change_na_panel);
		Event.observe($("a_achievements"),"mouseover",change_na_panel);
	
		Event.observe($("pt1"),"mouseover",change_product_panel);
		Event.observe($("pt2"),"mouseover",change_product_panel);
		Event.observe($("pt3"),"mouseover",change_product_panel);
		Event.observe($("pt4"),"mouseover",change_product_panel);
		Event.observe($("a_pt1"),"mouseover",change_product_panel);
		Event.observe($("a_pt2"),"mouseover",change_product_panel);
		Event.observe($("a_pt3"),"mouseover",change_product_panel);
		Event.observe($("a_pt4"),"mouseover",change_product_panel);
		
		setInterval(update_iframe_height,100);
		parent.setLocation("");
		preloadImage("images/company/l_0",".jpg",3);
		start(0,"images/company/l_0",".jpg",3,"imgs");
	};
	</script>
	<jsp:include page="hfoot.jsp"></jsp:include>
  </head>
  
  <body>
  	<div class="fix_auto">
	  	<div class="news_achievements">
	  		<div class="news_achievements_header">
				<ul>
					<li class="nh_passive" id="news_h"><a id="a_news" href="news.jsp" title="see more company news">News</a></li>
					<li class="ah_active" id="achievements_h"><a id="a_achievements" href="companyIntroduction.jsp" title="see more company information">Company</a></li>
					<li class="nah_more"></li>
				</ul>
			</div>
			<div class="news_achievements_body">
				<div id="news" class="news_achievements_content" style="display:none;">
					<table>
						<tbody>
							<tr><td>
					<table class="news" cellspacing="0" cellpadding="0">
						<tbody>
							<%
								Vector<News> news = News.getFirst10();
								int size = news.size();
								size = size>10?10:size;
								for (int i=0;i<size;i++)
								{
									News n = news.get(i);
							 %>
								<tr><td width="526px"><a class="list" href="viewNews.jsp?id=<%=n.getId() %>" title="<%=StringHelper.transform(n.getTitle(),'"',"'") %>"><%=StringHelper.getFristNChars(n.getTitle(),80) %></a></td><td width="70px"><%=n.getSubmitDate() %></td></tr>
							<%
								}
							 %>
						</tbody>
					</table>
							</td></tr>
							<tr><td>&nbsp;</td></tr>
							<tr><td><img style="border:solid 1px black;" src='images/company/news_body.jpg'></td></tr>
						</tbody>
					</table>
				</div>
				<div id="achievements"  class="news_achievements_content">
					<div style="margin-top: 3px;"><a class="go" href="companyIntroduction.jsp" title="see company information">Introduction</a>&nbsp;&nbsp;&nbsp;<!-- <a class="go" href="companyHonors.jsp" title="see company honors">Honors</a>&nbsp;&nbsp;&nbsp;--><a class="go" href="companyEquipments.jsp" title="see company equipments">Equipments</a></div>
					<div style="border: solid 1px gray;margin: 2px 0px 5px 0px;*margin: 7px 0px 5px 0px;padding:2px;"><a href="companyIntroduction.jsp" title="see more about out company"><img style="filter:revealTrans(Transition=7,Duration=1.5);" id="imgs" border="0" width="586" height="360" src="images/company/l_01.jpg"></a></div>
				</div>
			</div>
	  	</div>
	  	<div class="products">
		  	<div class="product_header">
				<ul>
					<li class="ph_active" id="pt1"><a id="a_pt1" href="search.jsp?type=26" title="see all lifting magnet products">Lifting Magnet</a></li>
					<li class="ph_passive" id="pt2"><a id="a_pt2" href="search.jsp?type=27" title="see all separator products">Separator</a></li>
					<li class="ph_passive" id="pt3"><a id="a_pt3" href="search.jsp?type=28" title="see all cable Drum products">Cable Drum</a></li>
					<li class="ph_passive" id="pt4"><a id="a_pt4" href="search.jsp?type=29" title="see all electromagnetic stirrer products">Stirrer</a></li>
				</ul>
			</div>
			<div class="suggest_products">
				<div id="product_type_1">
					<iframe src="homepageProducts.jsp?id=26" class="product_mask" scrolling="no" frameborder="0"></iframe>
				</div>
				<div id="product_type_2" style="display:none;">
					<iframe src="homepageProducts.jsp?id=27" class="product_mask" scrolling="no" frameborder="0"></iframe>
				</div>
				<div id="product_type_3" style="display:none;">
					<iframe src="homepageProducts.jsp?id=28" class="product_mask" scrolling="no" frameborder="0"></iframe>
				</div>
				<div id="product_type_4" style="display:none;">
					<iframe src="homepageProducts.jsp?id=29" class="product_mask" scrolling="no" frameborder="0"></iframe>
				</div>
			</div>
	  	</div>
	  	<div class="contact_info">
	  		<div class="ci_header"><img src="images/home/contact-header.gif"><span class="ci_header_title"><a href="contactUs.jsp" title="see more information">Contact Us</a></span></div>
	  		<div class="ci_content">
	 			<table cellspacing="0" cellpadding="0">
	    			<tbody>
	    				<tr><td width="80px"><span class="contact_title">Address:</span></td><td><%=contactInfo.getAddress() %></td></tr>
	    				<tr><td width="80px"><span class="contact_title">Postcode:</span></td><td><%=contactInfo.getPostcode() %></td></tr>
	    				<tr><td width="80px"><span class="contact_title">TEL:</span></td><td><%=contactInfo.getPhone1() %>&nbsp;&nbsp;&nbsp;<%=contactInfo.getPhone2() %></td></tr>
	    				<tr><td width="80px"><span class="contact_title">FAX:</span></td><td><%=contactInfo.getFax1() %>&nbsp;&nbsp;&nbsp;<%=contactInfo.getFax2() %></td></tr>
	    				<tr><td width="80px"><span class="contact_title">Email:</span></td><td><a href="mailto:<%=contactInfo.getEmail() %>" title="mailto:<%=contactInfo.getEmail() %>"><%=contactInfo.getEmail() %></a></td></tr>
	    				<tr><td width="80px"><span class="contact_title">MSN:</span></td><td><a href="mailto:<%=contactInfo.getMsn1() %>" title="mailto:<%=contactInfo.getMsn1() %>"><%=contactInfo.getMsn1() %></a></td></tr>
	    				<tr><td width="80px"><span class="contact_title">Skype:</span></td><td>starwang11287</td></tr>
	    			</tbody>
	    		</table>
	  		</div>
	  	</div>
  	</div>
	<jsp:include page="foot.jsp"></jsp:include>
  </body>
</html>
