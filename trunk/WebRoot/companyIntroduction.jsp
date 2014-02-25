<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="liftingmagnet.com.app.*" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	ContactInfo contactInfo = (ContactInfo)application.getAttribute("contact_info");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath %>">
    
    <title><%=contactInfo.getCompanyName() %>---Company Introduction</title>
    
	<meta http-equiv="keywords" content="岳阳强力,强力电磁,lifting,magnet,lifting magnet,electromagnet,yue yang,yueyang">
	<meta http-equiv="description" content="">
	
	<link rel="stylesheet" type="text/css" href="css/basic_style.css">
	<style type="text/css">
		body
		{
			margin: 10px;
			padding: 0px;
			text-align: center;
			background-color: #f3f3f3;
		}
		.fix_auto
		{
			margin: 0px auto;
			text-align: left;
			width: 616px;
		}
		.company_name
		{
			font-size: 20px;
			font-weight: bold;
			padding: 5px 20px;
			border-bottom: solid 1px gray;
		}
		.header
		{
			background: url(images/introduction-header.gif) center center no-repeat;
			height: 40px;
			width: 616px;
			overflow-x: hidden;
		}
		.description
		{
			font-size: 13px;
			line-height: 20px;
			padding: 10px;
			color: #09257e;
		}
	</style>
	<script type="text/javascript" src="js/iframe_auto_height.js"></script>
	<script type="text/javascript" src="js/filter.js"></script>
	<script type="text/javascript">
		window.onload = function(){
			update_iframe_height();
			parent.setLocation("&nbsp;<a href='companyIntroduction.jsp'>Company Introduction</a>&nbsp;&gt;");
			preloadImage("images/company/s_0",".jpg",3);
			start(0,"images/company/s_0",".jpg",3,"imgs");
		};
	</script>

	<jsp:include page="hfoot.jsp"></jsp:include>
  </head>
  
  <body>
    <div class="fix_auto">
    	<div class="company_name">
    		YUEYANG MINGKE ELECTROMAGNET CO.,LTD
    	</div>
    	<div class="header"></div>
    	<div class="description">
    		<div>
    			<div style="float:left;padding:5px;margin:0px;">
    				<img style="filter:revealTrans(Transition=2,Duration=1.5);" id="imgs" width="360px" height="233px" src="images/company/s_01.jpg" title="Our company.">
    			</div>
	    		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Yueyang Mingke Electromagnet Co., Ltd was founded according to the modern enterprise system. On the basis of introducing Japanese technology, we expand communication and cooperation with Europe and US counterpart, keep innovating and change the science research achievement and technology advantage into the competitive power. Our international market is always at the forefront of this field. We are the largest exporter of lifting electromagnet and electromagnetic separator in China and have sole agents in EU, Japan, Malaysia, Singapore and Thailand. Our products have been exported all over the world, covering 35 countries and regions.
	    		</div>
    		<div>
    			<div style="float:right;padding:5px 0px 5px 5px;margin:0px;">
    				<img width="220px" height="259px" src="images/company/tower.gif" title="The famous Yueyang tower.<Be concerned before anyone else and enjoy oneself only after everyone else finds enjoyment.>">
    			</div>
	    		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;We have advanced equipments in our plants, such as 3.5m gantry crane, T160 floor type borer, large-sized lathe, computerized plate blending machine, auto-welding device and etc. Hunan University, Central south University and Xiangtan University are our science research partner. Our company is also the training base of Hunan Institute of Science and Technology. We specialize in lifting electromagnet and its control equipment; electromagnetic separator and its control equipment; permanent-magnetic lifter; permanent-magnetic separator; electromagnetic stirrer and its control equipment; spring and motor type cable drum; water oil-pipe, gas-pipe and optical cable drum. The market covers field of steel industry, shipyard, machinery, power, transportation, mine, construction etc.. Our company has won the ISO9001 and CE certificate.
	 			<br>
	    		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'Mingke Electromagnet' has a dedicated, innovative and excellent technical team. Our corporate culture is ¡°people oriented, technological innovation, top quality and faith management¡±. We insist high standard, strict requirement, continuous improvement and innovation, dedicate to provide product and service of high quality.
 				<br>
	    		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Our company is located alongside the beautiful and fertile Dongting Lake and the ancient famous Yueyang tower. The location is on the line intersection of Yangtze River Gold Channel, Jing-Guang Highway, Jing-Zhu Highway and Jing-Guang Railway. Transportation is very convenient. We are sincerely expectant to establish long-term and close business relationship with all domestic and foreign customers.
	 			<br>
	 		</div>
 		</div>
    </div>
	<jsp:include page="foot.jsp"></jsp:include>
  </body>
</html>
