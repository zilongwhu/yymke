package liftingmagnet.com.fckeditor;

import javax.servlet.http.HttpServletRequest;

import liftingmagnet.com.usermanage.Authority;
import liftingmagnet.com.usermanage.User;

import net.fckeditor.requestcycle.UserPathBuilder;


public class UserPathBuilderImpl implements UserPathBuilder {

	public String getUserFilesPath(HttpServletRequest arg0) {
		User user = (User)arg0.getSession().getAttribute("user");
		System.out.println(arg0.getSession().getAttribute("manage_command"));
		Authority limits = user.getLimits();
		if ((limits.canAddNews()||limits.canModifyNews())
				&&"news".equals(arg0.getSession().getAttribute("manage_command")))
		{
			return "/news";
		}
		else if ((limits.canAddProduct()||limits.canModifyProduct())
				&&"products".equals(arg0.getSession().getAttribute("manage_command")))
		{
			return "/products";
		}
		else if ((limits.canAnswerFeedback())
				&&"feedbacks".equals(arg0.getSession().getAttribute("manage_command")))
		{
			return "/feedbacks";
		}
		return null;
	}

}
