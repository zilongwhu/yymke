package liftingmagnet.com.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

public class AuthLoginCode extends HttpServlet {
	private static final long serialVersionUID = -2191624612876391734L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		String code = req.getParameter("code");
		JSONObject obj = new JSONObject();
		Boolean valid = false;
		if (code!=null&&code.equals(req.getSession().getAttribute("auth_code_0")))
		{
			valid = true;
		}
		try {
			obj.put("valid", valid);
			resp.getWriter().write(obj.toString());
			req.getSession().setAttribute("valid", valid);
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
