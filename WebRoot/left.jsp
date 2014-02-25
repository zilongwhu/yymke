<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="liftingmagnet.com.db.dao.Catalog"%>
<%@page import="liftingmagnet.com.app.ProductList"%>
<%@page import="java.util.Vector"%>
<form style="margin-bottom:10px;" action="search.jsp">
	<div class="box_lb_blue">
		<div class="box_rb_blue">
			<div class="left_panel_title_bg">
  				<div class="box_lbc_blue">
  					<div class="box_rbc_blue">
  						<div class="left_panel_content">
   							<img src="images/product_search.gif"><span class="left_panel_title">Product Search</span>
	    					<div style="padding-top:10px;">
	    						<table style="font-size:12px;" cellspacing="0" cellpadding="1px">
	    							<tbody>
	    								<tr>
	    									<td height="26px">Keyword:</td>
	    									<td height="26px"><input style="width:120px;" type="text" name="name"></td>
	    								</tr>
	    								<tr>
	    									<td height="26px">Type:</td>
	    									<td height="26px">
						    					<select style="width:120px;" name="type">
													   	<option value="-1">All products</option>
						    						<%
						    							Vector<Catalog> types = Catalog.loadChildsFromDB(0);
						    							for (int i=0;i<types.size();i++)
						    							{
						    								Catalog cat = types.get(i);
						    						 %>
													   	<option value="<%=cat.getId() %>"><%=cat.getName() %></option>
													<%
														}
													 %>
												</select>
	    									</td>
	    									<td><input type="submit" value="search" style="width:55px;"></td>
	    								</tr>
	    							</tbody>
	    						</table>
								<img style="display:block;" src="images/img-pad-5.gif">
							</div>
						</div>
  					</div>
  				</div>
  			</div>
 		</div>
 	</div>	
</form>
<div class="box_lb_blue">
	<div class="box_rb_blue">
		<div class="left_panel_title_bg">
 			<div class="box_lbc_blue">
 				<div class="box_rbc_blue">
 					<div class="left_panel_content">
	  					<img src="images/product.gif"><span class="left_panel_title">Product List</span>
	    				<div style="padding-top:10px;" id="product_list_div">
	    					<%
	    						String list = (String)application.getAttribute("product_list");
	    						if (list==null)
	    						{
	    							new ProductList().generateList(application);
	    							list = (String)application.getAttribute("product_list");
	    						}
	    						out.print(list);
	    					 %>
						</div>
						<img style="display:block;" src="images/img-pad-5.gif">
					</div>
	 			</div>
	 		</div>
	 	</div>
	</div>
</div>