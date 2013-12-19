package liftingmagnet.com.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import liftingmagnet.com.usermanage.Authority;
import liftingmagnet.com.usermanage.User;

public class AddUser extends HttpServlet {
	private static final long serialVersionUID = 1172820428462881811L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String name = req.getParameter("name");
		String password = req.getParameter("password");

		resp.setContentType("text/html");
		resp.setCharacterEncoding("UTF-8");
		if (name==null||(name = name.trim()).length()==0)
		{
			return;
		}
		if (password==null||(password = password.trim()).length()==0)
		{
			return;
		}
		
		User user = (User)req.getSession().getAttribute("user");
		
		int status = user.addUser(name, password, new Authority(GetDataFromRequestHelper.getAuthorityFormRequest(req).getData()&user.getLimits().getData()));
		this.echo(status, resp);
	}
	
	private void echo(int status,HttpServletResponse resp)
		throws ServletException, IOException
	{
		resp.getWriter().write("<script type=\"text/javascript\">parent.callback("+status+");</script>");
	}
}
