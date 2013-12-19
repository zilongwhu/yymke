package liftingmagnet.com.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UserFilter implements Filter {
	private FilterConfig config = null;
	
	public void destroy() {
		
	}

	public void doFilter(ServletRequest arg0, ServletResponse arg1,
			FilterChain arg2) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)arg0;
		if (req.getSession().getAttribute("user")!=null)
		{
			req.getSession().setMaxInactiveInterval(15*60);
			arg2.doFilter(arg0, arg1);
		}
		else
		{
			HttpServletResponse resp = (HttpServletResponse)arg1;
			String loginPath = resp.encodeRedirectURL("/admin/login.jsp");
			resp.sendRedirect(loginPath);
		}
	}

	public void init(FilterConfig arg0) throws ServletException {
		config = arg0;
	}

}
