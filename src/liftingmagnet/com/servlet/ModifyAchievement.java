package liftingmagnet.com.servlet;

import java.io.IOException;
import java.util.Enumeration;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import liftingmagnet.com.usermanage.User;

public class ModifyAchievement extends HttpServlet {
	private static final long serialVersionUID = -7195317533356105618L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String id = req.getParameter("id");
		String type = req.getParameter("type");
		String dest = req.getParameter("destination");
		String year = req.getParameter("year");
		String month = req.getParameter("month");

		int idValue = -1;
		int typeValue = -1;
		int yearValue = -1;
		int monthValue = -1;

		if (id==null||(id=id.trim()).length()==0)
		{
			return;
		}
		if (dest==null||(dest=dest.trim()).length()==0)
		{
			return;
		}
		if (type==null||(type=type.trim()).length()==0)
		{
			return;
		}
		try
		{
			idValue = Integer.parseInt(id);
			typeValue = Integer.parseInt(type);
			yearValue = Integer.parseInt(year);
			monthValue = Integer.parseInt(month);
		}catch(Exception e){
			return;
		}
		Enumeration en = req.getParameterNames();
		Vector<Object[]> orders = new Vector<Object[]>();
		while (en.hasMoreElements())
		{
			String name = (String)en.nextElement();
			if (name.startsWith("product_"))
			{
				String product = req.getParameter(name);
				String quantity = req.getParameter("quantity_"+name.substring("product_".length()));
				String model = req.getParameter("model_"+name.substring("product_".length()));
				if (model==null||model.trim().length()==0)
				{
					return;
				}
				try
				{
					int pid = Integer.parseInt(product);
					int num = Integer.parseInt(quantity);
					Object[] order = new Object[3];
					order[0] = new Integer(pid);
					order[1] = new Integer(num);
					order[2] = model;
					orders.add(order);
				}
				catch(Exception e){}
			}
		}
		if (orders.size()==0)
		{
			return;
		}
		
		User user = (User)req.getSession().getAttribute("user");
		int status = user.modifyAchievement(idValue, dest, yearValue+"-"+monthValue+"-01",typeValue , orders);

		resp.setContentType("text/html");
		resp.setCharacterEncoding("UTF-8");

		this.echo(status, typeValue, resp);
	}
	
	private void echo(int status,int type,HttpServletResponse resp)
		throws ServletException, IOException
	{
		resp.getWriter().write("<script type=\"text/javascript\">parent.callback("+status+","+type+");</script>");
	}
}
