package liftingmagnet.com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import liftingmagnet.com.db.DBManager;
import liftingmagnet.com.db.dao.Action;
import liftingmagnet.com.db.dao.ActionType;
import liftingmagnet.com.usermanage.User;
import liftingmagnet.com.util.Loger;

public class UserLogout extends HttpServlet {
	private static final long serialVersionUID = -2095531096579760666L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		User user = ((User)req.getSession().getAttribute("user"));
		
		req.getSession().removeAttribute("user");
		resp.sendRedirect(resp.encodeRedirectURL("/admin/login.jsp"));
		
		Action action = new Action();
		action.setActioner(user.getName());
		action.setType(ActionType.TYPES[1].getValue());
		action.setTarget("");
		action.setTime(java.util.Calendar.getInstance().getTime());
		
		Connection con = DBManager.getConnection();
		Loger.log(con,action);
		try {
			con.close();
		} catch (SQLException e) {}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		this.doGet(req, resp);
	}
}
