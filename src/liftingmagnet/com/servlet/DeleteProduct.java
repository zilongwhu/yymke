package liftingmagnet.com.servlet;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import liftingmagnet.com.app.HomepageProducts;
import liftingmagnet.com.db.dao.Catalog;
import liftingmagnet.com.db.dao.Product;
import liftingmagnet.com.usermanage.User;

public class DeleteProduct extends HttpServlet {
	private static final long serialVersionUID = 3198848325269289792L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String idString = req.getParameter("id");
		
		if (idString==null||(idString=idString.trim()).length()==0)
		{
			return;
		}
		int id = -1;
		try
		{
			id = Integer.parseInt(idString);
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		User user = (User)req.getSession().getAttribute("user");
		Catalog catalog = Catalog.getFullInfoById(id);
		Catalog parentCatalog = Catalog.getParent(catalog.getId());
		int parentId = parentCatalog==null?0:parentCatalog.getId();
		if (catalog==null||catalog.getType()==0)
		{
			return;
		}
		int status = -1;
		if (catalog.getType()==1)
		{
			File content = new File(req.getSession().getServletContext().getRealPath(Catalog.getIntroductionPath(catalog.getTarget())));
			if(content.delete())
			{
				status = user.deleteIntroductionInfo(id);
			}
		}
		else
		{
			Product product = Product.getProductById(catalog.getId());
			File img = new File(req.getSession().getServletContext().getRealPath(product.getImgPath()));
			File content = new File(req.getSession().getServletContext().getRealPath(product.getPath()));
			if(img.delete()&&content.delete())
			{
				status = user.deleteProduct(id);
				if (status==0)
				{
					HomepageProducts pros = (HomepageProducts)req.getSession().getServletContext().getAttribute("homepageproducts");
					if (pros!=null)
					{
						pros.remove(id);
					}
				}
			}
		}
		if (status==0)
		{
			req.getSession().getServletContext().removeAttribute("product_list");
		}
		
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		JSONObject obj = new JSONObject();
		try {
			obj.put("status", status);
			obj.put("parent_id", parentId);
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
