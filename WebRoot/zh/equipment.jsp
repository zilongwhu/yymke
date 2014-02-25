<%@ page language="java" import="java.sql.*,utils.*,liftingmagnet.com.db.dao.*" pageEncoding="UTF-8"%>
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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<base href="<%=basePath+"zh/" %>"/>
		<title>岳阳明科电气有限公司---YUEYANG MINGKE ELECTROMAGNET CO.,LTD</title>
		<link href="css/css.css" rel="stylesheet" type="text/css" />
		<style type="text/css">
			<!--
			td           { font-size: 12px }
			.tdov        {cursor:hand;color: #000000; background-color: #0033CC }
			.tdout        {cursor:hand;color: #000000; background-color: #DCEADB }
			.navbar	{position:relative;left:244;top:6ox;width:531;height:37px;}
			.Menu 	{padding:0; font-size:12px;visibility:hidden;BORDER: 1px solid #666666;POSITION: absolute; background-color:#DCEADB}
			.news	{border-bottom:1px dotted rgb(204,204,204);width:192;height:16px;overflow:hidden; text-overflow:ellipsis;white-space:nowrap;cursor:hand}
			a            { color: #453748; text-decoration: none }
			a:hover      { color: #FF7D42 }
			.cla	{width:200;height:16px;overflow:hidden; text-overflow:ellipsis;white-space:nowrap;cursor:hand}

		.equip_des
		{
			font-size: 13px;
			line-height: 20px;
			color: #09257e;
			text-align: center;
			padding: 5px;
		}
			-->
		</style>
		<script type="text/javascript" src="stmenu.js"></script>
		<script src="Scripts/swfobject_modified.js" type="text/javascript"></script>
		<script language="javascript">
			<!--
			function open_news(id){
				window.open('news_view.jsp?id='+id,'gby_news','width=543,height=520,location=no,resizable=no,toolbar=no,menubar=no,scrollbars=yes');
			}
			function open_prod(id){
				window.open('product_view.jsp?id='+id,'gby_news','width=620,height=520,location=no,resizable=no,toolbar=no,menubar=no,scrollbars=yes');
			}
			//-->
		</script>
	</head>
	
	<body style="margin:0px; background-color:#F3F3F3;">
		<center>
			<div class="top style1">
				  <table width="100%" cellpadding="0" cellspacing="0" border="0">
				    <tr>
				      <td align=left><img src="images/logo.png" /></td>
				      <td><div style="position:relative; text-align:right; margin-top:55px; margin-right:8px;">
				      	<span onclick="var strHref=window.location.href;this.style.behavior='url(#default#homepage)';this.setHomePage('http://www.yymke.com');" style="CURSOR: hand">设为首页</span>
				      	|
				      	<span style="CURSOR: hand" onclick="window.external.addFavorite('http://www.yymke.com','岳阳明科电气有限公司')" title="岳阳明科电气有限公司">收藏本站</span>
						|
						<a href="lxwm.jsp">联系方式</a></div>
				      </td>
				    </tr>
				  </table>
				</div>
				<div class="style1 top_flash">
				<div class="flash_photo style1">
					<a target=_self href="javascript:goUrl()">
						<span class="f14b">
						<script type="text/javascript">
							imgUrl1="images/001.jpg";
							imgtext1="MW04-40T-1吊薄钢板"
							imgLink1=escape("http://www.yymke.com");
							imgUrl2="images/002.jpg";
							imgtext2="MW84吊运中厚钢板"
							imgLink2=escape("http://www.yymke.com");
							imgUrl3="images/003.jpg";
							imgtext3="超高温吊钢板吊攀式"
							imgLink3=escape("http://www.yymke.com");
							imgUrl4="images/004.jpg";
							imgtext4="吊捆扎棒材电磁铁"
							imgLink4=escape("http://www.yymke.com");
							imgUrl5="images/005.jpg";
							imgtext5="MW04工具电磁铁"
							imgLink5=escape("http://www.yymke.com");
							
							 var focus_width=884
							 var focus_height=279
							 var text_height=0
							 var swf_height = focus_height+text_height
							 
							 var pics=imgUrl1+"|"+imgUrl2+"|"+imgUrl3+"|"+imgUrl4+"|"+imgUrl5
							 var links=imgLink1+"|"+imgLink2+"|"+imgLink3+"|"+imgLink4+"|"+imgLink5
							 var texts=imgtext1+"|"+imgtext2+"|"+imgtext3+"|"+imgtext4+"|"+imgtext5
							 
							 document.write('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="'+ focus_width +'" height="'+ swf_height +'">');
							 document.write('<param name="allowScriptAccess" value="sameDomain"><param name="movie" value="focus.swf"><param name="quality" value="high"><param name="bgcolor" value="#F0F0F0">');
							 document.write('<param name="menu" value="false"><param name=wmode value="opaque">');
							 document.write('<param name="FlashVars" value="pics='+pics+'&links='+links+'&texts='+texts+'&borderwidth='+focus_width+'&borderheight='+focus_height+'&textheight='+text_height+'">');
							 document.write('<embed src="pixviewer.swf" wmode="opaque" FlashVars="pics='+pics+'&links='+links+'&texts='+texts+'&borderwidth='+focus_width+'&borderheight='+focus_height+'&textheight='+text_height+'" menu="false" bgcolor="#F0F0F0" quality="high" width="'+ focus_width +'" height="'+ focus_height +'" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />');  document.write('</object>');
						 </script>
						 </span>
					</a>
				</div>
				</div>
				<div class="cd style1">
				  <table width="100%" cellpadding="0"  cellspacing="0" border="0">
				    <tr>
				      <td width="210">&nbsp;</td>
				      <td>
				      	<script type="text/javascript" src="js/menu.js"></script>
				      </td>
				      <td width="100">
				      	<a href="/index.jsp" target="_blank"><img src="images/englisg.gif" width="100" height="30" border="0" /></a>
				      </td>
				    </tr>
				  </table>
				</div>
				<div class="main style1">
				  <table width="100%" cellpadding="0" cellspacing="0" border="0">
				    <tr valign="top">
				      <td width="210" style="background-color:#FFF;">
					      <table width="100%" cellpadding="0" cellspacing="0" border="0">
					        <tr>
					          <td height="28" style="padding-left:10px; padding-top:3px;">
					          	<img src="images/p_s.gif" width="210" height="28" />
					          </td>
					        </tr>
					        <tr>
					          <td style="text-align:right; line-height:180%; padding-left:8px;">
					           <table width="100%" border="0" cellspacing="3" cellpadding="0">
						          <tr>
						            <td valign="bottom">
							            <select size="1" name="Filed" style="width:200px;" id="Filed">
								            <option value="topic" selected>产品名称</option>
								            <option value="content">产品说明</option>
							            </select>
							        </td>
						          </tr>
						          <tr>
						            <td>
						            	<script language="javascript">
										<!--
										<%
											Connection con = Util.getConnection();
											try {
												Statement state = con.createStatement();
												ResultSet rs = state.executeQuery("SELECT * FROM t_product_type");
										%>
												var tname=new Array();var typeid=new Array();var pid=new Array();
										<%
												int i = 0;
												while (rs.next())
												{
										%>
												tname["<%=i %>"]='<%=rs.getString("typename")%>';
												typeid["<%=i %>"]='<%=rs.getString("typeid")%>';
												pid["<%=i %>"]='<%=rs.getString("pid")%>';
										<%			
													i++;
												}
												rs.close();
												state.close();
											} catch (SQLException e) {
												e.printStackTrace();
											}
											Util.closeConnection(con);
										%>
										function FillSubClass(val){
										var s=0;
											document.all.ddl_type.length=0;
											document.all.ddl_type.add(new Option('所有小类',0));
											for(s=0;s<tname.length;s++){
												if(pid[s]==val){
													document.all.ddl_type.add(new Option(tname[s],typeid[s]));
												}
											}
										}
										function Search(){
											var F=document.all.Filed.options[document.all.Filed.selectedIndex].value;
											var P=document.all.ddl_ptype.options[document.all.ddl_ptype.selectedIndex].value;
											var S=document.all.ddl_type.options[document.all.ddl_type.selectedIndex].value;
											var K=document.all.txtName.value;
											document.location='product.jsp?Filed='+F+'&ddl_ptype='+P+'&ddl_type='+S+'&txtName='+K;
										}
										//-->
										</script>
										<select size="1" name="ddl_ptype" id="ddl_ptype" style="width:200px;" onchange="FillSubClass(this.options[this.selectedIndex].value)">
											<option selected value="0">所有大类</option>
										</select>
									</td>
								  </tr>
								  <tr>
									<td>
										<select size="1"  name="ddl_type" id="ddl_type" style="width:200px;">
											<option selected value="0">所有小类</option>
										</select>
										<script language="javascript">
										<!--
											for(i=0;i<tname.length;i++){
												if(pid[i]==0){
													document.all.ddl_ptype.add(new Option(tname[i],typeid[i]));
												}
											}
										//-->
										</script>
									</td>
						          </tr>
						          <tr>
						            <td>
						            	<input type="text" name="txtName" id="txtName" style="width:195px;" value="关键字" size="20" onfocus="if(this.value=='关键字')this.value='';" onblur="if(this.value=='')this.value='关键字';" />
						            </td>
						          </tr>
						          <tr>
						            <td align="center">
						            	<input type="submit" value=" 搜   索 " onclick="Search()" style="width:200px;" />
						            </td>
						      	  </tr>
						       </table>
				              </td>
				            </tr>
				            <tr>
				              <td height="32" style="padding-left:10px; padding-top:3px;">
				          		<img src="images/p_l.gif" width="210" height="28" />
				          	  </td>
				      		</tr>
				      		<tr>
				          	  <td style="text-align:left; padding-left:10px;">
					            <style type="text/css">
					            	<!--
									A:link { COLOR: #000000; FONT-SIZE: 12px; TEXT-DECORATION: none}
									A:visited { COLOR: #000000; FONT-SIZE: 12px; TEXT-DECORATION: none}
									A:hover { COLOR: #006CD9; FONT-SIZE: 12px; TEXT-DECORATION: none}
									BODY { FONT-SIZE: 12px;}
									TD { FONT-SIZE: 12px; line-height: 150%}
									-->
								</style>
								<script language="JavaScript">
									<!--
									function showitem(id,name)
									{
										return ("<span><a href='"+id+"' target=_blank>"+name+"</a></span><br>")
									}
									function switchoutlookBar(number)
									{
										var i = outlookbar.opentitle;
										outlookbar.opentitle=number;
										var id1,id2,id1b,id2b
										if (number!=i && outlooksmoothstat==0){
											if (number!=-1)
											{
												if (i==-1){
													id2="blankdiv";
													id2b="blankdiv";
												}
												else{
													id2="outlookdiv"+i;
													id2b="outlookdivin"+i;
													document.all("outlooktitle"+i).style.border="1px none navy";
													document.all("outlooktitle"+i).style.background=outlookbar.maincolor;
													document.all("outlooktitle"+i).style.color="#000000";
													document.all("outlooktitle"+i).style.textalign="center";
												}
												id1="outlookdiv"+number
												id1b="outlookdivin"+number
												document.all("outlooktitle"+number).style.border="1px none white";
												document.all("outlooktitle"+number).style.background=outlookbar.maincolor; //title
												document.all("outlooktitle"+number).style.color="#000000";
												document.all("outlooktitle"+number).style.textalign="center";
												smoothout(id1,id2,id1b,id2b,0);
											}
											else
											{
												document.all("blankdiv").style.display="";
												document.all("blankdiv").sryle.height="100%";
												document.all("outlookdiv"+i).style.display="none";
												document.all("outlookdiv"+i).style.height="0%";
												document.all("outlooktitle"+i).style.border="1px none navy";
												document.all("outlooktitle"+i).style.background=outlookbar.maincolor;
												document.all("outlooktitle"+i).style.color="#000000";
												document.all("outlooktitle"+i).style.textalign="center";
											}
										}
									}
									function smoothout(id1,id2,id1b,id2b,stat)
									{
										if(stat==0){
											tempinnertext1=document.all(id1b).innerHTML;
											tempinnertext2=document.all(id2b).innerHTML;
											document.all(id1b).innerHTML="";
											document.all(id2b).innerHTML="";
											outlooksmoothstat=1;
											document.all(id1b).style.overflow="hidden";
											document.all(id2b).style.overflow="hidden";
											document.all(id1).style.height="0%";
											document.all(id1).style.display="";
											setTimeout("smoothout('"+id1+"','"+id2+"','"+id1b+"','"+id2b+"',"+outlookbar.inc+")",outlookbar.timedalay);
										}
										else
										{
											stat+=outlookbar.inc;
											if (stat>100)
												stat=100;
											document.all(id1).style.height=stat+"%";
											document.all(id2).style.height=(100-stat)+"%";
											if (stat<100) 
												setTimeout("smoothout('"+id1+"','"+id2+"','"+id1b+"','"+id2b+"',"+stat+")",outlookbar.timedalay);
											else
											{
												document.all(id1b).innerHTML=tempinnertext1;
												document.all(id2b).innerHTML=tempinnertext2;
												outlooksmoothstat=0;
												document.all(id1b).style.overflow="auto";
												document.all(id2).style.display="none";
											}
										}
									}
									function getOutLine()
									{
										outline="<table "+outlookbar.otherclass+">";
										for (i=0;i<(outlookbar.titlelist.length);i++)
										{
											outline+="<tr><td name=outlooktitle"+i+" id=outlooktitle"+i+" "; 
											if (i!=outlookbar.opentitle) 
												outline+=" nowrap align=center style='cursor:hand;background-color:"+outlookbar.maincolor+";color:#000000;height:20;text-align:CENTER;border:1 none navy' ";
											else
												outline+=" nowrap align=center style='cursor:hand;background-color:"+outlookbar.maincolor+";color:white;height:20;border:1 none white' ";
											outline+=outlookbar.titlelist[i].otherclass
											outline+=" onclick='switchoutlookBar("+i+")'><span class=smallFont>";
											outline+=outlookbar.titlelist[i].title+"</span></td></tr>";
											outline+="<tr><td name=outlookdiv"+i+" valign=top align=left id=outlookdiv"+i+" style='width:100%"
											if (i!=outlookbar.opentitle) 
												outline+=";display:none;height:0%;";
											else
												outline+=";display:;height:100%;";
											outline+="'><div name=outlookdivin"+i+" id=outlookdivin"+i+" style='overflow:auto;width:100%;height:100%'>";
											for (j=0;j<outlookbar.itemlist[i].length;j++)
												outline+=showitem(outlookbar.itemlist[i][j].key,outlookbar.itemlist[i][j].title);
											outline+="</div></td></tr>"
										}
										outline+="</table>"
										return outline
									}
									function show()
									{
										var outline;
										outline="<div id=outLookBarDiv name=outLookBarDiv style='width=100%;height:100%'>"
										outline+=outlookbar.getOutLine();
										outline+="</div>"
										document.write(outline);
									}
									function theitem(intitle,instate,inkey)
									{
										this.state=instate;
										this.otherclass=" nowrap ";
										this.key=inkey;
										this.title=intitle;
									}
									function addtitle(intitle)
									{
										outlookbar.itemlist[outlookbar.titlelist.length]=new Array();
										outlookbar.titlelist[outlookbar.titlelist.length]=new theitem(intitle,1,0);
										return(outlookbar.titlelist.length-1);
									}
									function additem(intitle,parentid,inkey)
									{
										if (parentid>=0 && parentid<=outlookbar.titlelist.length)
										{
											outlookbar.itemlist[parentid][outlookbar.itemlist[parentid].length]=new theitem(intitle,2,inkey);
											outlookbar.itemlist[parentid][outlookbar.itemlist[parentid].length-1].otherclass=" nowrap align=left style='height:5' ";
											return(outlookbar.itemlist[parentid].length-1);
										}
										else
											additem=-1;
									}
									function outlook()
									{
										this.titlelist=new Array();
										this.itemlist=new Array();
										this.divstyle="style='height:100%;width:100%;overflow:auto' align=center";
										this.otherclass="border=0 cellspacing='0' cellpadding='0' style='height:100%;width:100%'valign=middle align=center ";
										this.addtitle=addtitle;
										this.additem=additem;
										this.starttitle=-1;
										this.show=show;
										this.getOutLine=getOutLine;
										this.opentitle=this.starttitle;
										this.reflesh=outreflesh;
										this.timedelay=50;
										this.inc=10;
										this.maincolor = "#F1F1F1"
									}
									function outreflesh()
									{
										document.all("outLookBarDiv").innerHTML=outlookbar.getOutLine();
									}
									function locatefold(foldname)
									{
										if (foldname=="")
											foldname = outlookbar.titlelist[0].title
										for (var i=0;i<outlookbar.titlelist.length;i++)
										{
											if(foldname==outlookbar.titlelist[i].title)
											{
												outlookbar.starttitle=i;
												outlookbar.opentitle=i;
											}
										}
									}
									var outlookbar=new outlook();
									var tempinnertext1,tempinnertext2,outlooksmoothstat
									outlooksmoothstat = 0;
									
									var t;
									t=outlookbar.addtitle('<b><span style="text-align:left; color:#000;">---起重电磁铁及电控---</span></b>')
									outlookbar.additem('１、产品型号的意义、用途',t,'xl1.jsp')
									outlookbar.additem('２、吊运废钢用',t,'product.jsp?id=2')
									outlookbar.additem('３、吊运钢坯、板坯用',t,'product.jsp?id=10')
									outlookbar.additem('４、板坯吊运翻转用',t,'product.jsp?id=14')
									outlookbar.additem('５、吊运钢锭、钢坯用',t,'product.jsp?id=15')
									outlookbar.additem('６、吊运初扎钢、型钢用',t,'product.jsp?id=16')
									outlookbar.additem('７、吊运钢坯、圆钢用',t,'product.jsp?id=17')
									outlookbar.additem('８、吊运初扎钢、线材、方坯用',t,'product.jsp?id=18')
									outlookbar.additem('９、吊运钢带卷用',t,'product.jsp?id=19')
									outlookbar.additem('１０、吊运大型钢管用',t,'product.jsp?id=20')
									outlookbar.additem('１１、电磁辊',t,'product.jsp?id=23')
									outlookbar.additem('１２、吊运钢板用',t,'product.jsp?id=24')
									outlookbar.additem('１３、吊运薄钢板、长钢板用、电缆连接器',t,'product.jsp?id=25')
									outlookbar.additem('１４、圆形、矩形、MW1、MW2系列',t,'product.jsp?id=26')
									outlookbar.additem('１５、永磁吸吊器',t,'product.jsp?id=27')
									outlookbar.additem('１６、电控方式的选定',t,'product.jsp?id=28')
									outlookbar.additem('１７、停电保磁设备',t,'product.jsp?id=29')
									outlookbar.additem('１８、GLMA-230系列整流控制设备',t,'product.jsp?id=30')
									t=outlookbar.addtitle('<b>-----除铁器及电控-----</b>')
									outlookbar.additem('１、产品概述、安装位置',t,'xl3.jsp')
									outlookbar.additem('２、MC03系列圆形电磁除铁器',t,'product.jsp?id=47')
									outlookbar.additem('３、MC23系列矩形电磁除铁器',t,'product.jsp?id=48')
									outlookbar.additem('４、MC22系列自卸式电磁除铁器',t,'product.jsp?id=49')
									outlookbar.additem('５、MC12系列自卸式电磁除铁器',t,'product.jsp?id=50')
									outlookbar.additem('６、MC12系列节能型自卸式电磁除铁器',t,'product.jsp?id=51')
									outlookbar.additem('７、RCDD-Q系列超强新型风冷自卸式电磁除铁器',t,'product.jsp?id=52')
									outlookbar.additem('８、RCYD系列自卸式永磁除铁器',t,'product.jsp?id=53')
									outlookbar.additem('９、MC01系列矿石自动回收式电磁除铁器',t,'product.jsp?id=54')
									outlookbar.additem('１０、ML1系列电磁式磁轮、ZCDL系列振动式电磁分离器',t,'product.jsp?id=55')
									outlookbar.additem('１１、YL1系列永磁式磁轮',t,'product.jsp?id=57')
									outlookbar.additem('１２、YG2系列永磁式磁辊（干式）',t,'product.jsp?id=58')
									outlookbar.additem('１３、KC53系列矿石粉磁选机',t,'product.jsp?id=59')
									outlookbar.additem('１３、SSTM（Q）－□D，SSTM（Q）2－口S系列整流控制设备',t,'product.jsp?id=60')
									outlookbar.additem('１３、SSTM（Q）－口D1T，SSTQO－口D1系列整流控制设备',t,'product.jsp?id=64')
									outlookbar.additem('１３、JT2000系列金属探测器',t,'product.jsp?id=65')
									outlookbar.additem('１３、GJK口-口/PC系列整流控制设备',t,'product.jsp?id=66')
									outlookbar.additem('１３、非磁性平托辊',t,'product.jsp?id=67')
									t=outlookbar.addtitle('<b>-------电缆卷筒-------</b>')
									outlookbar.additem('１、产品分类、安装方式示意图',t,'xl2.jsp')
									outlookbar.additem('２、弹力、力矩电机式电缆卷筒',t,'product.jsp?id=35')
									outlookbar.additem('３、弹力电缆卷筒滑环内装式',t,'product.jsp?id=36')
									outlookbar.additem('４、弹力电缆卷筒水平地面卷取式',t,'product.jsp?id=37')
									outlookbar.additem('５、弹力电缆卷筒滑环外装式',t,'product.jsp?id=38')
									outlookbar.additem('６、弹力电缆卷筒悬臂式',t,'product.jsp?id=39')
									outlookbar.additem('７、电缆卷筒信号式',t,'product.jsp?id=40')
									outlookbar.additem('８、电缆卷筒力矩电机式',t,'product.jsp?id=41')
									outlookbar.additem('９、重锤式电缆卷筒',t,'product.jsp?id=42')
									outlookbar.additem('１０、长期堵转力矩电机式电缆卷筒',t,'product.jsp?id=43')
									outlookbar.additem('１１、磁泄式电力电缆卷筒',t,'product.jsp?id=44')
									outlookbar.additem('１２、软管卷筒',t,'product.jsp?id=45')
									outlookbar.additem('１３、特型号电缆卷筒',t,'product.jsp?id=46')
									t=outlookbar.addtitle('<b> ---连铸电磁搅拌装置---</b>')
									outlookbar.additem('１、连铸电磁搅拌装置概述及原理',t,'product_view.jsp?id=118')
									outlookbar.additem('２、成套装置的配置及基本要求',t,'product_view.jsp?id=116')
									outlookbar.additem('３、电磁搅拌器的分类及安装位置',t,'product_view.jsp?id=119')
									outlookbar.additem('４、可供选择的电磁搅拌器一览表',t,'product_view.jsp?id=120')
									outlookbar.additem('５、结晶器外置式电磁搅拌器(内冷)',t,'product_view.jsp?id=117')
									outlookbar.additem('６、结晶器外置式电磁搅拌器(外冷)',t,'product_view.jsp?id=122')
									outlookbar.additem('７、结晶器内置式电磁搅拌器(外冷)',t,'product_view.jsp?id=123')
									outlookbar.additem('８、结晶器内置式电磁搅拌器(模块)',t,'product_view.jsp?id=124')
									outlookbar.additem('９、结晶器内置式电磁搅拌器(两相两极)',t,'product_view.jsp?id=125')
									outlookbar.additem('１０、双线圈结晶器电磁搅拌器',t,'product_view.jsp?id=126')
									outlookbar.additem('１１、凝固末端电磁搅拌器(强磁式)',t,'product_view.jsp?id=127')
									outlookbar.additem('１２、凝固末端电磁搅拌器(广域式)',t,'product_view.jsp?id=128')
									outlookbar.additem('１３、辊式板坯电磁搅拌器',t,'product_view.jsp?id=129')
									outlookbar.additem('１４、对装式板坯电磁搅拌器',t,'product_view.jsp?id=130')
									outlookbar.additem('１５、电磁搅拌效果及其应用',t,'product_view.jsp?id=131')
									outlookbar.additem('１６、高炭钢方坯搅拌对比试样',t,'product_view.jsp?id=132')
									outlookbar.additem('１７、中炭钢方坯搅拌对比试样',t,'product_view.jsp?id=133')
									outlookbar.additem('１８、中炭钢厚板搅拌对比试样',t,'product_view.jsp?id=134')
									outlookbar.additem('１９、低频电源及控制系统',t,'product_view.jsp?id=135')
									outlookbar.additem('２０、电磁搅拌器主要技术参数',t,'product_view.jsp?id=136')
									outlookbar.additem('２１、低频电源技术参数',t,'product_view.jsp?id=137')
									-->
								</script>
								<table width="210" border=0 align="left" cellpadding=0 cellspacing=0 id=mnuList style="WIDTH:210px;">
								  <tr> 
										<td width="210" align="left" valign="top" id=outLookBarShow style="HEIGHT: 100%" name="outLookBarShow">
											<script language="JavaScript">
											<!--
											locatefold("")
											outlookbar.show() 
											-->
											</script>
										</td>
									</tr>
								</table>
				          	  </td>
				     	 	</tr>
				      		<tr>
				      		  <td>&nbsp;</td>
				      		</tr>
				          </table>
				      </td>
				      <td width="19" style="background-image:url(images/bg2.gif);">&nbsp;</td>
				      <td width="">
				      	<table width="100%" border="0">
					        <tr>
					          <td><div style="width:92% auto; height:20px; position:relative;background-image:url(images/s.gif); background-repeat:no-repeat; background-color:#E1E2E6; margin-left:3px;"></div></td>
					        </tr>
					        <tr>
					          <td style="text-align:left; line-height:200%; padding-left:8px;">
    	<div style="padding:10px;">
    		<table class="boxer" width="600px" cellspacing="0" cellpadding="0">
    			<tbody>
    				<tr>
    					<td valign="top">
    						<div><img style="border:solid 1px black;" src="/images/equipments/DSC03177.gif"></div>
    						<div class="equip_des">龙门铣床</div>
    					</td>
    					<td valign="top">
    						<div><img style="border:solid 1px black;" src="/images/equipments/DSC03178.gif"></div>
    						<div class="equip_des">数控立式车床</div>
    					</td>
    				</tr>
    				<tr>
    					<td valign="top">
    						<div><img style="border:solid 1px black;" src="/images/equipments/DSC03179.gif"></div>
    						<div class="equip_des">卧式车床</div>
    					</td>
    					<td valign="top">
    						<div><img style="border:solid 1px black;" src="/images/equipments/DSC03182.gif"></div>
    						<div class="equip_des">三辊卷板机</div>
    					</td>
    				</tr>
    				<tr>
    					<td valign="top">
    						<div><img style="border:solid 1px black;" src="/images/equipments/DSC03183.gif"></div>
    						<div class="equip_des">自动焊接机</div>
    					</td>
    					<td valign="top">
    						<div><img style="border:solid 1px black;" src="/images/equipments/DSC03184.gif"></div>
    						<div class="equip_des">数控切割机</div>
    					</td>
    				</tr>
    				<tr>
    					<td valign="top">
    						<div><img style="border:solid 1px black;" src="/images/equipments/DSC03185.gif"></div>
    						<div class="equip_des">绕线机</div>
    					</td>
    					<td valign="top">
    						<div><img style="border:solid 1px black;" src="/images/equipments/DSC03186.gif"></div>
    						<div class="equip_des">耐压机</div>
    					</td>
    				</tr>
    			</tbody>
    		</table>
	</div>
<!--
					          	<table width="100%" border="0">
							        <tr>
							          <td width="250"><div align="center">
							          	<div>
								            <p><img border="0" src="images/s2.jpg" width="198" height="135"/></p>
								            <p><img border="0" src="images/s3.jpg" width="198" height="135"/></p>
								            <p><img border="0" src="images/s4.jpg" width="198" height="135"/></p>
								        </div>
								      </td>
							          <td valign="top"><span style="line-height: 290%"> 　　本公司从国外引入先进生产技术和生产工艺。为适应市场需要，本公司还引入了从日本神钢电机株式会社学成归来的电磁铁专业人士和企业管理硕士，为打造一个全新的品牌‘明科电气’。本公司已经将所有设备都进行了适当的维护和保养，正处于良好运行状态。<br/>
							              <font color="#ff6600">生产管理</font><br/>
							              我们深知，只有先进的设备，没有合格的操作工人和科学的操作规程，生产不出优良的产品。因此我们制定了严格的操作规程，并十分注重对操作工人的技术培训，确保生产流程顺畅，交货满足客户要求。<br/>
							              <font color="#ff6600">品质管理</font><br/>
							              为确保产品质量，明科电气完全按照现代企业制度运作，已通过ISO9001体系认证。产品质量达到国际先进水平 ， 明科电气的主要产品有 起重电磁铁及电控；电磁除铁器及电控；弹力、电动电缆卷筒；水缆 、气缆卷筒；阀门、仪表等 产品质量完全符合国家有关标准。</span>
									  </td>
							        </tr>
							      </table>
-->
							  </td>
					        </tr>
					        <tr>
					          <td>&nbsp;</td>
					        </tr>
					        <tr>
					          <td>&nbsp;</td>
					        </tr>
					      </table>
					  </td>
					</tr>
				</table>
			</div>
		<div class="Copyright style1">
			<table width="100%" border="0">
			  <tr>
			    <td width="220">&nbsp;</td>
			    <td>
			    	<p align="center" style="line-height: 200%">
			    		岳阳明科电气有限公司　Copyright@2001-2005版权所有　邮编：414000　 <script src='http://s53.cnzz.com/stat.php?id=204658&web_id=204658&show=pic' language='JavaScript' charset='gb2312'></script>
			        	<br/>
						电话：0730-7832001(</span>总机<span lang="en-us">)&nbsp;&nbsp;&nbsp;</span>传真：0730-7832011&nbsp;&nbsp;&nbsp;&nbsp; 地址：湖南省岳阳市麻塘镇洞庭村
						<br/>
						<a href="mailto:starwang@liftingmagnet.com.cn">Email：starwang@liftingmagnet.com.cn</a>
					</p>
				</td>
			    <td width="130" style="text-align:center; line-height:300%;">
			    	<a href="http://www.miibeian.gov.cn" target="_blank"><img src="images/gv.gif" width="35" height="43" border="0" /></a>
			    	<br/>
			    	<a href="http://www.miibeian.gov.cn" target="_blank">湘ICP05012675</a>
			    </td>
			  </tr>
			</table>
		</div>
	</center>
	<script type="text/javascript">
	<!--
	swfobject.registerObject("FlashID");
	//-->
	</script>
	<jsp:include page="bd_foot.jsp"></jsp:include>
	</body>
</html>
