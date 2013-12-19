package liftingmagnet.com.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import liftingmagnet.com.usermanage.User;

public class DeleteAchievement extends HttpServlet {
	private static final long serialVersionUID = 8602946346202742743L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String idString = req.getParameter("id");
		String typeString = req.getParameter("type");
		String pageString = req.getParameter("page");
		
		if (idString==null||(idString=idString.trim()).length()==0)
		{
			return;
		}
		if (typeString==null||(typeString=typeString.trim()).length()==0)
		{
			return;
		}
		if (pageString==null||(pageString=pageString.trim()).length()==0)
		{
			return;
		}
		int id = -1;
		int type = -1;
		int page = -1;
		try
		{
			id = Integer.parseInt(idString);
			type = Integer.parseInt(typeString);
			page = Integer.parseInt(pageString);
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		User user = (User)req.getSession().getAttribute("user");
		user.deleteAchievement(id);
		req.getRequestDispatcher("achievements.jsp?type="+type+"&page="+page).forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		this.doGet(req, resp);
	}
}
