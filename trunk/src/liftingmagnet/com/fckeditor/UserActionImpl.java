package liftingmagnet.com.fckeditor;

import javax.servlet.http.HttpServletRequest;

import liftingmagnet.com.usermanage.Authority;
import liftingmagnet.com.usermanage.User;

import net.fckeditor.requestcycle.UserAction;

public class UserActionImpl implements UserAction {

	public boolean isEnabledForFileBrowsing(HttpServletRequest arg0) {
		User user = (User)arg0.getSession().getAttribute("user");
		System.out.println("***********************  file browsing");
		Authority limits = user.getLimits();
		if (limits.canAddNews()||limits.canAddProduct()
				||limits.canModifyNews()||limits.canModifyProduct()
				||limits.canAnswerFeedback())
		{
			return true;
		}
		return false;
	}

	public boolean isEnabledForFileUpload(HttpServletRequest arg0) {
		User user = (User)arg0.getSession().getAttribute("user");
		System.out.println("***********************  file uploading");
		Authority limits = user.getLimits();
		if (limits.canAddNews()||limits.canAddProduct()
				||limits.canModifyNews()||limits.canModifyProduct()
				||limits.canAnswerFeedback())
		{
			return true;
		}
		return false;
	}

}
