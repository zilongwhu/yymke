package liftingmagnet.com.servlet;

import java.io.IOException;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import liftingmagnet.com.db.dao.Catalog;
import liftingmagnet.com.usermanage.Authority;
import liftingmagnet.com.usermanage.User;

public class GetCatalogChilds extends HttpServlet {
	private static final long serialVersionUID = 5262177069757008598L;

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
		}catch(Exception e){
			e.printStackTrace();
			return;
		}
		
		User user = (User)req.getSession().getAttribute("user");
		Authority limits = user.getLimits();
		if (limits.canAddProduct()||limits.canModifyProduct())
		{
			Vector<Catalog> childs = Catalog.loadChildsFromDB(id);
			int size = childs.size();
			JSONArray arr = new JSONArray();
			for (int i=0;i<size;i++)
			{
				if (childs.get(i).getType()==0)
				{
					try {
						JSONObject obj = new JSONObject();
						obj.put("id", childs.get(i).getId());
						obj.put("name", childs.get(i).getName());
						arr.put(obj);
					} catch (JSONException e) {
						e.printStackTrace();
					}
				}
			}
			resp.getWriter().write(arr.toString());
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		this.doGet(req, resp);
	}
}
