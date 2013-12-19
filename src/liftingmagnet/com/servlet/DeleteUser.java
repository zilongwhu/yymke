package liftingmagnet.com.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import liftingmagnet.com.usermanage.User;

public class DeleteUser extends HttpServlet {
	private static final long serialVersionUID = 1577892124393312048L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String name = req.getParameter("name");

		resp.setContentType("text/html");
		resp.setCharacterEncoding("UTF-8");
		if (name==null||(name = name.trim()).length()==0)
		{
			return;
		}
		
		User user = (User)req.getSession().getAttribute("user");
		
		Integer status = user.deleteUser(name);
		
		req.setAttribute("delete_status", status);
		String path = resp.encodeURL("users.jsp");
		req.getRequestDispatcher(path).forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		this.doGet(req, resp);
	}
}
