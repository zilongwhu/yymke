package liftingmagnet.com.servlet;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import liftingmagnet.com.db.dao.News;
import liftingmagnet.com.usermanage.User;

public class DeleteNews extends HttpServlet {
	private static final long serialVersionUID = 3249387777980132863L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String idString = req.getParameter("id");
		
		if (idString==null||(idString=idString.trim()).length()==0)
		{
			return;
		}
		int id = -1;
		try
		{
			id = Integer.parseInt(idString);
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
		News news = News.getNews(id);
		if (news==null)
		{
			return;
		}
		File file = new File(req.getSession().getServletContext().getRealPath(news.getPath()));
		if (file.delete())
		{
			User user = (User)req.getSession().getAttribute("user");
			user.deleteNews(id);
		}
		resp.sendRedirect(resp.encodeRedirectURL("news.jsp"));
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		this.doGet(req, resp);
	}
}
