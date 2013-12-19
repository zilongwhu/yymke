package liftingmagnet.com.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import liftingmagnet.com.usermanage.User;

public class UserLogin extends HttpServlet{
	private static final long serialVersionUID = -2552642389236504637L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String name = req.getParameter("name");
		String password = req.getParameter("password");
		
		resp.setContentType("text/html");
		resp.setCharacterEncoding("UTF-8");
		Boolean valid = (Boolean)req.getSession().getAttribute("valid");
		if (valid==null || !valid)//没有通过验证码验证的请求
		{
			return;
		}
		if (name==null||(name=name.trim()).length()==0)//用户名字未提供
		{
			this.echo(1, resp);
			return;
		}
		else if(password==null||(password=password.trim()).length()==0)//用户密码未提供
		{
			this.echo(2, resp);
			return;
		}
		User user = new User();
		user.setName(name);
		user.setPassword(password);
		int status = user.login();
		if (status==0)//登录成功
		{
			req.getSession().setAttribute("user", user);
			req.getSession().removeAttribute("rand");
			req.getSession().removeAttribute("valid");
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
