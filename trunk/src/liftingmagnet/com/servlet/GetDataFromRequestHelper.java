package liftingmagnet.com.servlet;

import javax.servlet.http.HttpServletRequest;

import liftingmagnet.com.usermanage.Authority;

public class GetDataFromRequestHelper {
	public static Authority getAuthorityFormRequest(HttpServletRequest req)
	{
		Authority limits = new Authority();
		
		String addUser = req.getParameter("add_user");
		limits.setAddUser(addUser!=null&&addUser.equals("yes"));
		String modifyUser = req.getParameter("modify_user");
		limits.setModifyUser(modifyUser!=null&&modifyUser.equals("yes"));
		String deleteUser = req.getParameter("delete_user");
		limits.setDeleteUser(deleteUser!=null&&deleteUser.equals("yes"));
		
		String superviser = req.getParameter("superviser");
		limits.setSupervise(superviser!=null&&superviser.equals("yes"));
		
		String addNews = req.getParameter("add_news");
		limits.setAddNews(addNews!=null&&addNews.equals("yes"));
		String modifyNews = req.getParameter("modify_news");
		limits.setModifyNews(modifyNews!=null&&modifyNews.equals("yes"));
		String deleteNews = req.getParameter("delete_news");
		limits.setDeleteNews(deleteNews!=null&&deleteNews.equals("yes"));
		
		String addProduct = req.getParameter("add_product");
		limits.setAddProduct(addProduct!=null&&addProduct.equals("yes"));
		String modifyProduct = req.getParameter("modify_product");
		limits.setModifyProduct(modifyProduct!=null&&modifyProduct.equals("yes"));
		String deleteProduct = req.getParameter("delete_product");
		limits.setDeleteProduct(deleteProduct!=null&&deleteProduct.equals("yes"));
		
		String manageProductList = req.getParameter("manage_product_list");
		limits.setManageProductList(manageProductList!=null&&manageProductList.equals("yes"));
		
		String addAchievement = req.getParameter("add_achievement");
		limits.setAddAchievement(addAchievement!=null&&addAchievement.equals("yes"));
		String modifyAchievement = req.getParameter("modify_achievement");
		limits.setModifyAchievement(modifyAchievement!=null&&modifyAchievement.equals("yes"));
		String deleteAchievement = req.getParameter("delete_achievement");
		limits.setDeleteAchievement(deleteAchievement!=null&&deleteAchievement.equals("yes"));
		
		String answerFeedback = req.getParameter("answer_feedback");
		limits.setAnswerFeedback(answerFeedback!=null&&answerFeedback.equals("yes"));
		String deleteFeedback = req.getParameter("delete_feedback");
		limits.setDeleteFeedback(deleteFeedback!=null&&deleteFeedback.equals("yes"));
		
		String manageWorldwide = req.getParameter("manage_worldwide");
		limits.setManageWorldwide(manageWorldwide!=null&&manageWorldwide.equals("yes"));
		
		String manageContactInfo = req.getParameter("manage_contact_info");
		limits.setManageContactInfo(manageContactInfo!=null&&manageContactInfo.equals("yes"));

		String viewVisitors = req.getParameter("view_visitors");
		limits.setViewVisitors(viewVisitors!=null&&viewVisitors.equals("yes"));
		
		return limits;
	}
}
