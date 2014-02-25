<%@ page language="java" pageEncoding="UTF-8"%>
<ul>
	<li class="first"><a href="homepage.jsp" title="go to home page">Home</a></li>
	<li onmouseover="showCompanySubmenus();" onmouseout="hideAllSubmenus();"><a href="javascript:;" target="_self" title="company information">Company</a></li>
	<li><a href="news.jsp" title="view news">News</a></li>
	<li onmouseover="showProductsSubmenus();" onmouseout="hideAllSubmenus();"><a href="javascript:;" target="_self" title="view products">Products</a></li>
	<li><a href="achievements.jsp" title="view our achievements">Achievements</a></li>
	<li><a href="worldwides.jsp" title="worldwide">Worldwide</a></li>
	<li><a href="feedback.jsp" title="have sth. to tell us?">Feedback</a></li>
	<li><a href="contactUs.jsp" title="contact us">Contact Us</a></li>
	<li><a href="zh/index.jsp" title="Chinese" target="_blank">中文版</a></li>
</ul>
<div onmouseover="showCompanySubmenus();" onmouseout="hideAllSubmenus();" id="company_menu_wraper">
	<div id="company_menu">
	 	<ul class="menu">
			<li><a onclick="window.setTimeout('hideAllSubmenus();',200);" href="companyIntroduction.jsp" title="company introduction">Introduction</a></li>
			<!-- <li><a onclick="window.setTimeout('hideAllSubmenus();',200);" href="companyHonors.jsp" title="company honours">Honours</a></li> -->
			<li><a onclick="window.setTimeout('hideAllSubmenus();',200);" href="companyEquipments.jsp" title="see our equipments">Equipments</a></li>
	 	</ul>
	</div>
</div>
<div onmouseover="showProductsSubmenus();" onmouseout="hideAllSubmenus();" id="products_menu_wraper">
	<div id="products_menu">
		<ul class="menu">
 			<li><a onclick="window.setTimeout('hideAllSubmenus();',200);" href="search.jsp?type=26" title="see all lifting magnet products">Lifting Magnet</a></li>
 			<li><a onclick="window.setTimeout('hideAllSubmenus();',200);" href="search.jsp?type=27" title="see all separator products">Separator</a></li>
 			<li><a onclick="window.setTimeout('hideAllSubmenus();',200);" href="search.jsp?type=28" title="see all cable Drum products">Cable Drum</a></li>
 			<li><a onclick="window.setTimeout('hideAllSubmenus();',200);" href="search.jsp?type=29" title="see all electromagnetic stirrer products">Electromagnetic Stirrer</a></li>
 			<li><a onclick="window.setTimeout('hideAllSubmenus();',200);" href="search.jsp?type=30" title="see all permanent magnetic lifter products">Permanent magnetic lifter</a></li>
		</ul>
	</div>
</div>