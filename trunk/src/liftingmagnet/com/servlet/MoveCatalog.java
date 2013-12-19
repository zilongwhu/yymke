package liftingmagnet.com.servlet;

import java.io.IOException;
import java.util.StringTokenizer;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import liftingmagnet.com.usermanage.User;

import org.json.JSONException;
import org.json.JSONObject;

public class MoveCatalog extends HttpServlet{
	private static final long serialVersionUID = 8208930652246333562L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String ids = req.getParameter("ids");
		String target = req.getParameter("target");
		String parent = req.getParameter("parent");

		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		if (ids==null||(ids = ids.trim()).length()==0)
		{
			return;
		}
		if (target==null||(target = target.trim()).length()==0)
		{
			return;
		}
		if (parent==null||(parent = parent.trim()).length()==0)
		{
			return;
		}
		int[] idArray = null;
		int targetId = 0;
		int parentId = 0;
		try
		{
			StringTokenizer st = new StringTokenizer(ids,"_");
			idArray = new int[st.countTokens()];
			for (int i=0;i<idArray.length;i++)
			{
				idArray[i] = Integer.parseInt(st.nextToken());
			}
			targetId = Integer.parseInt(target);
			parentId = Integer.parseInt(parent);
		}catch(Exception e)
		{
			e.printStackTrace();
			return;
		}
		
		User user = (User)req.getSession().getAttribute("user");
		
		int status = user.moveCatalog(idArray, targetId);
		if (status==0)
		{
			req.getSession().getServletContext().removeAttribute("product_list");
		}

		JSONObject obj = new JSONObject();
		try {
			obj.put("status", status);
			obj.put("parent", parentId);
			obj.put("target", targetId);
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
