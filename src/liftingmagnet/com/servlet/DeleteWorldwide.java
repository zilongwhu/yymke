package liftingmagnet.com.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import liftingmagnet.com.usermanage.User;

public class DeleteWorldwide extends HttpServlet {
	private static final long serialVersionUID = -5912651808138790412L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String idString = req.getParameter("id");

		resp.setContentType("text/html");
		resp.setCharacterEncoding("UTF-8");
		if (idString==null||(idString = idString.trim()).length()==0)
		{
			return;
		}
		
		int id = -1;
		try
		{
			id = Integer.parseInt(idString);
		}
		catch(Exception e)
		{
			return;
		}
		
		User user = (User)req.getSession().getAttribute("user");
		
		Integer status = user.deleteWorldwide(id);
		
		req.setAttribute("delete_status", status);
		String path = resp.encodeURL("worldwides.jsp");
		req.getRequestDispatcher(path).forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		this.doGet(req, resp);
	}
}
