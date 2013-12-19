package liftingmagnet.com.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import liftingmagnet.com.usermanage.User;

public class AddProductType extends HttpServlet {
	private static final long serialVersionUID = 480741843054312087L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String name = req.getParameter("type");
		String parent = req.getParameter("parent");

		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		if (name==null||(name = name.trim()).length()==0)
		{
			return;
		}
		if (parent==null||(parent = parent.trim()).length()==0)
		{
			return;
		}
		int parentId = -1;
		try
		{
			parentId = Integer.parseInt(parent);
		}catch(Exception e){e.printStackTrace();}
		
		User user = (User)req.getSession().getAttribute("user");
		
		int status = user.addProductType(parentId, name);
		if (status==0)
		{
			req.getSession().getServletContext().removeAttribute("product_list");
		}
		
		JSONObject obj = new JSONObject();
		try {
			obj.put("status", status);
			obj.put("parent", parentId);
			resp.getWriter().write(obj.toString());
		} catch (JSONException e) {
			e.printStackTrace();
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		this.doGet(req, resp);
	}
}
