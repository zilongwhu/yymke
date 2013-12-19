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

import liftingmagnet.com.usermanage.User;

public class AddNews extends HttpServlet {
	private static final long serialVersionUID = -2479985983428510658L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String title = req.getParameter("title");
		String content = req.getParameter("news");
		
		resp.setContentType("text/html");
		resp.setCharacterEncoding("UTF-8");
		
		if (title==null||(title=title.trim()).length()==0)
		{
			return;
		}
		if (content==null||content.length()==0)
		{
			this.echo(2, resp);
			return;
		}
		User user = (User)req.getSession().getAttribute("user");
		long time = System.currentTimeMillis();
		String path = req.getSession().getServletContext().getRealPath("/news_files")+"/"+time+".txt";
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(new File(path))));
		bw.write(content);
		bw.close();
		int status = user.addNews(title, "/news_files/"+time+".txt");
		this.echo(status, resp);
	}
	
	private void echo(int status,HttpServletResponse resp)
		throws ServletException, IOException
	{
		resp.getWriter().write("<script type=\"text/javascript\">parent.callback("+status+");</script>");
	}
}
