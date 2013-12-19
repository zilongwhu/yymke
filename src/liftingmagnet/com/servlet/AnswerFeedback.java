package liftingmagnet.com.servlet;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import liftingmagnet.com.usermanage.User;

public class AnswerFeedback extends HttpServlet {
	private static final long serialVersionUID = 3534290689904562412L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String idString = req.getParameter("id");
		String content = req.getParameter("content");

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
		if (content==null||(content = content.trim()).length()==0)
		{
			this.echo(3, resp);
			return;
		}
		
		User user = (User)req.getSession().getAttribute("user");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		java.util.Date date = java.util.Calendar.getInstance().getTime();
		long time = System.currentTimeMillis();
		String path = req.getSession().getServletContext().getRealPath("/feedback_files")+"/"+time+".txt";
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(new File(path))));
		bw.write(content);
		bw.close();
		int status = user.answerFeedback(id, "/feedback_files/"+time+".txt", sdf.format(date));
		if (status!=0)
		{
			File file = new File(path);
			file.delete();
		}
		this.echo(status, resp);
	}
	
	private void echo(int status,HttpServletResponse resp)
		throws ServletException, IOException
	{
		resp.getWriter().write("<script type=\"text/javascript\">parent.callback("+status+");</script>");
	}
}
