package liftingmagnet.com.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import liftingmagnet.com.usermanage.User;

public class DeleteProductCatalog extends HttpServlet{
	private static final long serialVersionUID = -9095557479660638145L;

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
		User user = (User)req.getSession().getAttribute("user");
		int status = user.deleteProductCatalog(id);
		if (status==0)
		{
			req.getSession().getServletContext().removeAttribute("product_list");
		}
		
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		JSONObject obj = new JSONObject();
		try {
			obj.put("status", status);
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
