<%@ page language="java" pageEncoding="UTF-8"%>
  	<%
  		Integer numsPerPage = (Integer)request.getAttribute("numsperpage");
  		Integer total = (Integer)request.getAttribute("total");
  		Integer pageIndex = (Integer)request.getAttribute("page");
  		String target = (String)request.getAttribute("target");
  		Integer type = (Integer)request.getAttribute("type");//专为achievements而设
  		if (numsPerPage==null||total==null||pageIndex==null)
  		{
  			return;
  		}
  		target = response.encodeURL(target);
	%>
<style>
	a.button:link{color: blue;margin: 0px;padding: 0px 3px;border: solid 1px gray;text-decoration: none;}
	a.button:visited{color: blue;margin: 0px;padding: 0px 3px;border: solid 1px gray;text-decoration: none;}
	a.button:hover{color: red;margin: 0px;padding: 0px 3px;border: solid 1px black;text-decoration: none;}
	a.button:active{color: red;margin: 0px;padding: 0px 3px;border: solid 1px black;text-decoration: none;}
</style>
<div style="padding-top:10px;padding-right:10px;">
	<%
  		int pages = total/numsPerPage;
  		pages = total%numsPerPage!=0?pages+1:pages;
  		if (pages==1)
  		{
  	 %>
  	 	<div style="text-align:right;margin-top:10px;">Just 1 page</div>
  	 <%
  	 	}
  	 	else
  	 	{
  	  %>
  	<form action="<%=target %>" id="go" style="padding:0px;margin:0px;">
  		<%
  			if (type!=null)
  			{
  		 %>
  		<input type="hidden" name="type" value="<%=type %>">
  		<%
  			}
  		 %>
  		<table align="right">
  			<tbody>
  				<tr>
  					<td style="padding-right:20px;"><font color="red"><%=total %></font> results,<font color="red"><%=pages %></font> pages,current page:<font color="red"><%=pageIndex+1 %></font></td>
  					<td width="70px" align="center">
  					<%
						if (pageIndex!=0)
						{
					 %>
  						<a class="button" href="<%=target %>?page=0<%=type!=null?"&type="+type:"" %>">First page</a>
  					<%
						}
						else
						{
					 %>
					 	First page
					<%
						}
					 %>
  					</td>
  					<td width="30px" align="center">
					<%
						if (pageIndex>0)
						{
					 %>
					 	<a class="button" href="<%=target %>?page=<%=pageIndex-1 %><%=type!=null?"&type="+type:"" %>">Previous</a>
					<%
						}
						else
						{
					 %>
					 	Previous
					<%
						}
					 %>
					</td>
  					<td width="30px" align="center">
  						<%
						if (pageIndex<pages-1)
						{
					 %>
					 	<a class="button" href="<%=target %>?page=<%=pageIndex+1 %><%=type!=null?"&type="+type:"" %>">Next</a>
					<%
						}
						else
						{
					 %>
					 	Next
					<%
						}
					 %>
					</td>
  					<td width="70px" align="center">
  					<%
						if (pageIndex!=pages-1)
						{
					 %>
  						<a class="button" href="<%=target %>?page=<%=pages-1 %><%=type!=null?"&type="+type:"" %>">Last page</a>
  					<%
						}
						else
						{
					 %>
					 	Last page
					<%
						}
					 %>
  					</td>
  					<td width="60px">
  						Goto page:
  					</td>
  					<td width="30px">
  						<select name="page" onchange="document.getElementById('go').submit();">
  							<%
  								for (int i=0;i<pages;i++)
  								{
  							 %>
  							 <option value="<%=i %>" <%=pageIndex==i?"selected":"" %>><%=i+1 %></option>
  							<%
  								}
  							 %>
  						</select>
  					</td>
  				</tr>
  			</tbody>
  		</table>
  	</form>
  	<%
  		}
  	 %>
</div>