package liftingmagnet.com.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import liftingmagnet.com.app.ContactInfo;
import liftingmagnet.com.app.HomepageProducts;
import liftingmagnet.com.app.ProductList;
import liftingmagnet.com.db.DBManager;

public class InitListener implements ServletContextListener {

	public void contextDestroyed(ServletContextEvent arg0) {
		DBManager.destroyDB();
	}

	public void contextInitialized(ServletContextEvent arg0) {
		ServletContext context = arg0.getServletContext();
		
		String filePath = context.getRealPath(context.getInitParameter("ContactInfoPath"));
		context.setAttribute("contact_info", ContactInfo.loadFromFile(filePath));

		filePath = context.getRealPath(context.getInitParameter("DBPath"));
		DBManager.initDB(filePath);
		
		context.setAttribute("homepageproducts", new HomepageProducts());
		
		new ProductList().generateList(context);
	}

}
