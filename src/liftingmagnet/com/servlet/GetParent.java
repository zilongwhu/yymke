package liftingmagnet.com.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import liftingmagnet.com.usermanage.User;

public class GetParent extends HttpServlet {
	private static final long serialVersionUID = -2782357948880647267L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String idString = req.getParameter("id");

		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		if (idString==null||(idString = idString.trim()).length()==0)
		{
			return;
		}
		int id = -1;
		try
		{
			id = Integer.parseInt(idString);
		}catch(Exception e){e.printStackTrace();}
		
		User user = (User)req.getSession().getAttribute("user");
		
		int parent = user.getParentCatalog(id);

		JSONObject obj = new JSONObject();
		try {
			obj.put("parent", parent);
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
