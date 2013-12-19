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

import liftingmagnet.com.app.HomepageProducts;
import liftingmagnet.com.usermanage.User;

public class AddProduct extends HttpServlet {
	private static final long serialVersionUID = -8193566920413459240L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String type = req.getParameter("type");
		String name = req.getParameter("name");
		String catalog = req.getParameter("catalog");
		String imgPath = req.getParameter("img_path");
		String promoted = req.getParameter("promoted");
		String homepage = req.getParameter("homepage");
		String year = req.getParameter("year");
		String month = req.getParameter("month");
		String features = req.getParameter("features");
		String content = req.getParameter("content");
		
		if (type==null||(type=type.trim()).length()==0)
		{
			return;
		}
		if (!(type.equals("0")||type.equals("1")))
		{
			return;
		}
		if (name==null||(name=name.trim()).length()==0)
		{
			return;
		}
		int parentId = -1;
		int yearValue = -1;
		int monthValue = -1;
		int thisYear = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
		
		if (catalog==null||(catalog=catalog.trim()).length()==0)
		{
			return;
		}
		try
		{
			parentId = Integer.parseInt(catalog);
		}catch(Exception e){}
		
		if (type.equals("0"))
		{
			if (imgPath==null||(imgPath=imgPath.trim()).length()==0)
			{
				return;
			}
			if (promoted!=null&&!promoted.equals("yes"))
			{
				return;
			}
			if (homepage!=null&&!homepage.equals("yes"))
			{
				return;
			}
			if (year==null||(year=year.trim()).length()==0)
			{
				return;
			}
			try
			{
				yearValue = Integer.parseInt(year);
				if (yearValue>thisYear||yearValue<1996)
				{
					return;
				}
			}catch(Exception e){
				return;
			}
			if (month==null||(month=month.trim()).length()==0)
			{
				return;
			}
			try
			{
				monthValue = Integer.parseInt(month);
				if (monthValue>12||yearValue<1)
				{
					return;
				}
			}catch(Exception e){
				return;
			}
			if (features==null||features.length()==0)
			{
				return;
			}
		}
		if (content==null||content.length()==0)
		{
			resp.setContentType("text/html");
			resp.setCharacterEncoding("UTF-8");
			resp.getWriter().write("<script type=\"text/javascript\">parent.callback(1);</script>");
			return;
		}
		User user = (User)req.getSession().getAttribute("user");
		long time = System.currentTimeMillis();
		int status = -1;
		if (type.equals("0"))
		{
			String path = req.getSession().getServletContext().getRealPath("/product_files")+"/"+time+".txt";
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(new File(path))));
			bw.write(content);
			bw.close();
			status = user.addProduct(name, parentId, features, imgPath, "/product_files"+"/"+time+".txt", yearValue+"-"+monthValue+"-1", promoted!=null, homepage!=null);
			if (status!=0)
			{
				File file = new File(path);
				file.delete();
			}
			else if (status==0&&homepage!=null)
			{
				HomepageProducts pros = (HomepageProducts)req.getSession().getServletContext().getAttribute("homepageproducts");
				if (pros!=null)
				{
					pros.reload();
				}
			}
				
		}
		else
		{
			String path = req.getSession().getServletContext().getRealPath("/info_files")+"/"+time+".txt";
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(new File(path))));
			bw.write(content);
			bw.close();
			status = user.addIntroductionInfo(name, parentId, "/info_files"+"/"+time+".txt");
			if (status!=0)
			{
				File file = new File(path);
				file.delete();
			}
		}
		if (status==0)
		{
			req.getSession().getServletContext().removeAttribute("product_list");
		}
		req.getRequestDispatcher("products.jsp?id="+parentId).forward(req, resp);
	}
}
