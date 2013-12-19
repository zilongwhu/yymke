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

import liftingmagnet.com.db.dao.Catalog;
import liftingmagnet.com.usermanage.User;

public class ModifyInfo extends HttpServlet {
	private static final long serialVersionUID = 3730629296117974458L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String id = req.getParameter("id");
		String name = req.getParameter("name");
		String catalog = req.getParameter("catalog");
		String content = req.getParameter("content");
		
		if (id==null||(id=id.trim()).length()==0)
		{
			return;
		}
		if (name==null||(name=name.trim()).length()==0)
		{
			return;
		}
		int idValue = -1;
		int parentId = -1;
		try
		{
			idValue = Integer.parseInt(id);
		}catch(Exception e){}
		if (catalog==null||(catalog=catalog.trim()).length()==0)
		{
			return;
		}
		try
		{
			parentId = Integer.parseInt(catalog);
		}catch(Exception e){}
		if (content==null||content.length()==0)
		{
			resp.setContentType("text/html");
			resp.setCharacterEncoding("UTF-8");
			resp.getWriter().write("<script type=\"text/javascript\">parent.callback(1);</script>");
			return;
		}
		
		User user = (User)req.getSession().getAttribute("user");
		int status = -1;
		Catalog info = Catalog.getFullInfoById(idValue);
		if (info==null||info.getType()!=1)
		{
			return;
		}
		String path = req.getSession().getServletContext().getRealPath(Catalog.getIntroductionPath(info.getTarget()));
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(new File(path))));
		bw.write(content);
		bw.close();
		status = user.modifyIntroduction(idValue, name, parentId);
		req.getRequestDispatcher("products.jsp?id="+parentId).forward(req, resp);
		if (status==0)
		{
			req.getSession().getServletContext().removeAttribute("product_list");
		}
	}
}
