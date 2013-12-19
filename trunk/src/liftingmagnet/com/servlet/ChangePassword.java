package liftingmagnet.com.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import liftingmagnet.com.usermanage.User;

public class ChangePassword extends HttpServlet {
	private static final long serialVersionUID = -6746144728300611401L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String oldPassword = req.getParameter("old_password");
		String newPassword = req.getParameter("new_password");
		
		resp.setContentType("text/html");
		resp.setCharacterEncoding("UTF-8");
		if(oldPassword==null||(oldPassword=oldPassword.trim()).length()==0)//用户密码未提供
		{
			this.echo(1, resp);
			return;
		}
		if(newPassword==null||(newPassword=newPassword.trim()).length()==0)//用户密码未提供
		{
			this.echo(1, resp);
			return;
		}
		User user = (User)req.getSession().getAttribute("user");
		int status = user.changePassword(oldPassword, newPassword);
		if (status==0)//修改密码成功
		{
			req.getSession().removeAttribute("user");
		}
		this.echo(status, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		this.doGet(req, resp);
	}
	
	private void echo(int status,HttpServletResponse resp)
		throws ServletException, IOException
	{
		resp.getWriter().write("<script type=\"text/javascript\">parent.callback("+status+");</script>");
	}
}
