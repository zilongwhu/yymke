package liftingmagnet.com.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import liftingmagnet.com.app.ContactInfo;
import liftingmagnet.com.usermanage.User;

public class ModifyContactInfo extends HttpServlet {
	private static final long serialVersionUID = -4036562902286656087L;
	
	

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html");
		
		User user = (User)request.getSession().getAttribute("user");
		if (!user.getLimits().canManageContactInfo())
		{
			response.getWriter().write("<script type=\"text/javascript\">alert('对不起，您的权限不够，请与管理员联系！');</script>");
			return;
		}
		String address = request.getParameter("address");
		String postcode = request.getParameter("postcode");
		String phone1 = request.getParameter("phone1");
		String phone2 = request.getParameter("phone2");
		String fax1 = request.getParameter("fax1");
		String fax2 = request.getParameter("fax2");
		String email = request.getParameter("email");
		String msn1 = request.getParameter("msn1");
		String msn2 = request.getParameter("msn2");
		
		if (address==null||(address=address.trim()).length()==0)
		{
			response.getWriter().write("<script type=\"text/javascript\">alert('地址必须填写！');</script>");
			return;
		}
		if (postcode==null||(postcode=postcode.trim()).length()==0||!CheckHelper.checkPostcodeValid(postcode))
		{
			response.getWriter().write("<script type=\"text/javascript\">alert('邮编填写错误！');</script>");
			return;
		}
		if (phone1==null||(phone1=phone1.trim()).length()==0||!CheckHelper.checkPhoneValid(phone1))
		{
			response.getWriter().write("<script type=\"text/javascript\">alert('电话填写错误！');</script>");
			return;
		}
		if (phone2==null||(phone2=phone2.trim()).length()==0||!CheckHelper.checkPhoneValid(phone2))
		{
			response.getWriter().write("<script type=\"text/javascript\">alert('电话填写错误！');</script>");
			return;
		}
		if (fax1==null||(fax1=fax1.trim()).length()==0||!CheckHelper.checkPhoneValid(fax1))
		{
			response.getWriter().write("<script type=\"text/javascript\">alert('传真填写错误！');</script>");
			return;
		}
		if (fax2==null||(fax2=fax2.trim()).length()==0||!CheckHelper.checkPhoneValid(fax2))
		{
			response.getWriter().write("<script type=\"text/javascript\">alert('传真填写错误！');</script>");
			return;
		}
		if (email==null||(email=email.trim()).length()==0||!CheckHelper.checkEmailValid(email))
		{
			response.getWriter().write("<script type=\"text/javascript\">alert('电子邮件填写错误！');</script>");
			return;
		}
		if (msn1==null||(msn1=msn1.trim()).length()==0||!CheckHelper.checkEmailValid(msn1))
		{
			response.getWriter().write("<script type=\"text/javascript\">alert('MSN填写错误！');</script>");
			return;
		}
		if (msn2==null||(msn2=msn2.trim()).length()==0||!CheckHelper.checkEmailValid(msn2))
		{
			response.getWriter().write("<script type=\"text/javascript\">alert('MSN填写错误！');</script>");
			return;
		}
		
		ContactInfo contactInfo = (ContactInfo)this.getServletContext().getAttribute("contact_info");
		contactInfo.setAddress(address);
		contactInfo.setEmail(email);
		contactInfo.setFax1(fax1);
		contactInfo.setFax2(fax2);
		contactInfo.setPhone1(phone1);
		contactInfo.setPhone2(phone2);
		contactInfo.setPostcode(postcode);
		contactInfo.setMsn1(msn1);
		contactInfo.setMsn2(msn2);
		ContactInfo.saveToFile(this.getServletContext().getRealPath(this.getServletContext().getInitParameter("ContactInfoPath")));
		
		response.getWriter().write("<script type=\"text/javascript\">parent.ok();</script>");
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doGet(request, response);
	}

}
