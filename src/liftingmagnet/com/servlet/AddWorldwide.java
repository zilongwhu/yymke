package liftingmagnet.com.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import liftingmagnet.com.db.dao.Worldwide;
import liftingmagnet.com.usermanage.User;

public class AddWorldwide extends HttpServlet {
	private static final long serialVersionUID = 8285952209460077660L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String area = req.getParameter("area");
		String agent = req.getParameter("agent");

		resp.setContentType("text/html");
		resp.setCharacterEncoding("UTF-8");
		if (area==null||(area = area.trim()).length()==0)
		{
			return;
		}
		if (agent==null||(agent = agent.trim()).length()==0)
		{
			return;
		}
		
		User user = (User)req.getSession().getAttribute("user");
		Worldwide ww = new Worldwide();
		ww.setArea(area);
		ww.setAgent(agent);
		int status = user.addWorldwide(ww);
		this.echo(status, resp);
	}
	
	private void echo(int status,HttpServletResponse resp)
		throws ServletException, IOException
	{
		resp.getWriter().write("<script type=\"text/javascript\">parent.callback("+status+");</script>");
	}
}
