package liftingmagnet.com.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import liftingmagnet.com.usermanage.User;

public class ChangePosition extends HttpServlet {
	private static final long serialVersionUID = 2048713486823084435L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String pId = req.getParameter("p_id");
		String sId = req.getParameter("s_id");
		String tId = req.getParameter("t_id");

		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		if(pId==null||(pId=pId.trim()).length()==0)
		{
			return;
		}
		if(sId==null||(sId=sId.trim()).length()==0)
		{
			return;
		}
		if(tId==null||(tId=tId.trim()).length()==0)
		{
			return;
		}
		int p = -1;
		int s = -1;
		int t = -1;
		try
		{
			p = Integer.parseInt(pId);
			s = Integer.parseInt(sId);
			t = Integer.parseInt(tId);
		}catch(Exception e){
			return;
		}
		User user = (User)req.getSession().getAttribute("user");
		
		JSONObject obj = new JSONObject();
		try {
			boolean status = user.placeAfter(p, s, t);
			obj.put("status", status);
			if (status)
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
