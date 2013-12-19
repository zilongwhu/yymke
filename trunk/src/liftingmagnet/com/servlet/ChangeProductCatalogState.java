package liftingmagnet.com.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import liftingmagnet.com.usermanage.User;

public class ChangeProductCatalogState extends HttpServlet {
	private static final long serialVersionUID = 5902540240284603517L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String id = req.getParameter("id");

		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		if(id==null||(id=id.trim()).length()==0)
		{
			return;
		}
		int pId = -1;
		try
		{
			pId = Integer.parseInt(id);
		}catch(Exception e){
			return;
		}
		User user = (User)req.getSession().getAttribute("user");
		
		JSONObject obj = new JSONObject();
		try {
			int status = user.toggleProductCatalogState(pId);
			obj.put("opened", status==3);
			status = status==3?0:status;
			obj.put("status", status);
			obj.put("id", pId);
			if (status==0)
			{
				req.getSession().getServletContext().removeAttribute("product_list");
			}
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
