package liftingmagnet.com.filter;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import liftingmagnet.com.usermanage.Authority;
import liftingmagnet.com.usermanage.User;

public class UploadFilter implements Filter {
	private FilterConfig config = null;
	
	public void destroy() {
		
	}

	public void doFilter(ServletRequest arg0, ServletResponse arg1,
			FilterChain arg2) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)arg0;
		User user = (User)req.getSession().getAttribute("user");
		Authority limits = user.getLimits();
		if ((limits.canAddNews()||limits.canModifyNews()
				||limits.canAddProduct()||limits.canModifyProduct()
				||limits.canAnswerFeedback())&&req.getSession().getAttribute("manage_command")!=null)
		{
			arg2.doFilter(arg0, arg1);
		}
		else
		{
			System.out.println("invalid user:\t"+user.getName()+"\t"+req.getRemoteAddr()+"\t"+req.getRemoteHost()+"\t"+new SimpleDateFormat("yyyy-mm-dd HH:MM:SS").format(new Date(System.currentTimeMillis())));
		}
	}

	public void init(FilterConfig arg0) throws ServletException {
		config = arg0;
	}

}