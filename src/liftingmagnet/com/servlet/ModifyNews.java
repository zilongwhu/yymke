package liftingmagnet.com.servlet;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import liftingmagnet.com.db.dao.News;
import liftingmagnet.com.usermanage.User;

public class ModifyNews extends HttpServlet {
	private static final long serialVersionUID = -3668038755787369737L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String idString = req.getParameter("id");
		String content = req.getParameter("news");
		
		if (idString==null||(idString=idString.trim()).length()==0)
		{
			return;
		}
		if (content==null||content.length()==0)
		{
			this.echo(2, 0, resp);
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
		String path = req.getSession().getServletContext().getRealPath(news.getPath());
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(new File(path))));
		bw.write(content);
		bw.close();
		
		User user = (User)req.getSession().getAttribute("user");
		int status = user.modifyNews(id);
		this.echo(status, id, resp);
	}
	
	private void echo(int status,int id,HttpServletResponse resp)
		throws ServletException, IOException
	{
		resp.getWriter().write("<script type=\"text/javascript\">parent.callback("+status+","+id+");</script>");
	}
}
