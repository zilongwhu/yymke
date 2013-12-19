package liftingmagnet.com.servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import liftingmagnet.com.db.dao.Feedback;

public class AddFeedback extends HttpServlet {
	private static final long serialVersionUID = -4780002527443865348L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String question = req.getParameter("question");
		String code = req.getParameter("code");
		String email = req.getParameter("email");

		resp.setContentType("text/html");
		resp.setCharacterEncoding("UTF-8");
		if (question==null||(question = question.trim()).length()==0)
		{
			this.echo(1, resp);
			return;
		}
		else if (question.length()>1000)
		{
			this.echo(2, resp);
			return;
		}
		if (code==null||(code = code.trim()).length()==0)
		{
			this.echo(3, resp);
			return;
		}
		if (!code.equals(req.getSession().getAttribute("auth_code_1")))
		{
			this.echo(4, resp);
			return;
		}
		if (question.length()<20)
		{
			this.echo(5, resp);
			return;
		}
		req.getSession().removeAttribute("auth_code_1");
		
		Feedback fb = new Feedback();
		fb.setQuestion(question);
		fb.setEmail(email);
		fb.setIp(req.getRemoteAddr());
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		fb.setSubmitTime(sdf.format(java.util.Calendar.getInstance().getTime()));
		this.echo(fb.insertToDB()?0:6, resp);
	}
	
	private void echo(int status,HttpServletResponse resp)
		throws ServletException, IOException
	{
		resp.getWriter().write("<script type=\"text/javascript\">parent.callback("+status+");</script>");
	}
}
