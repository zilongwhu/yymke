package liftingmagnet.com.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import liftingmagnet.com.usermanage.User;

public class DeleteFeedback extends HttpServlet {
	private static final long serialVersionUID = -936039368466256959L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String idString = req.getParameter("id");
		String pageString = req.getParameter("page");
		
		if (idString==null||(idString=idString.trim()).length()==0)
		{
			return;
		}
		if (pageString==null||(pageString=pageString.trim()).length()==0)
		{
			return;
		}
		int id = -1;
		int page = -1;
		try
		{
			id = Integer.parseInt(idString);
			page = Integer.parseInt(pageString);
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		User user = (User)req.getSession().getAttribute("user");
		user.deleteFeedback(id);
		req.getRequestDispatcher("deleteFeedback.jsp?page="+page).forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		this.doGet(req, resp);
	}
}
