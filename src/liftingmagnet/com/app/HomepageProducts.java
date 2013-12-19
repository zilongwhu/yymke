package liftingmagnet.com.app;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Vector;
import java.util.Set;
import java.util.Iterator;

import liftingmagnet.com.db.DBManager;
import liftingmagnet.com.db.dao.*;

public class HomepageProducts {
	private HashMap<Integer,Vector<Product>> maps;
	
	public HomepageProducts()
	{
		load();
	}
	
	private void load()
	{
		maps = new HashMap<Integer,Vector<Product>>();
		
		Vector<Product> ps = new Vector<Product>(); 
		Connection con = DBManager.getConnection();
		if (con!=null)
		{
			try {
				Statement sm = con.createStatement();
				String sql = "select pc.id,pc.name,pc.product,pc.parent,p.features,p.path,p.img_path,p.is_strongly_promoted,p.is_on_homepage,p.produce_date" +
					" from product_catalog as pc, product as p where pc.type=2 and pc.product=p.id and p.is_on_homepage=1";
				sm.executeQuery(sql);
				ResultSet rs = sm.executeQuery(sql);
				while (rs.next())
				{
					Product product = new Product();
					product.setId(rs.getInt(1));
					product.setName(rs.getString(2));
					product.setProductId(rs.getInt(3));
					product.setParent(rs.getInt(4));
					product.setFeatures(rs.getString(5));
					product.setPath(rs.getString(6));
					product.setImgPath(rs.getString(7));
					product.setPromoted(rs.getBoolean(8));
					product.setOnHomepage(rs.getBoolean(9));
					product.setProduceDate(rs.getString(10).substring(0,10));
					ps.add(product);
				}
				rs.close();
				sm.close();
				PreparedStatement psm = con.prepareStatement("select p.id from product_catalog as p, product_catalog as c where c.parent=p.id and c.id=?");
				for (int i=0;i<ps.size();i++)
				{
					int child = ps.get(i).getId();
					boolean found = false;
					while (!found)
					{
						psm.setInt(1, child);
						rs = psm.executeQuery();
						if (rs.next())
						{
							child = rs.getInt(1);
						}
						else
						{
							Vector<Product> v = maps.get(new Integer(child));
							if (v==null)
							{
								v = new Vector<Product>();
								maps.put(new Integer(child), v);
							}
							v.add(ps.get(i));
							found = true;
						}
						rs.close();
					}
				}
				sm.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	public void reload()
	{
		load();
	}

	public HashMap<Integer, Vector<Product>> getMaps() {
		return maps;
	}

	public void setMaps(HashMap<Integer, Vector<Product>> maps) {
		this.maps = maps;
	}
	
	public void remove(int id)
	{
		Set<Integer> keys = this.maps.keySet();
		Iterator<Integer> itr = keys.iterator();
		while (itr.hasNext())
		{
			Vector<Product> v = this.maps.get(itr.next());
			for (int i=0;i<v.size();i++)
			{
				if (v.get(i).getId()==id)
				{
					v.remove(i);
					return ;
				}
			}
		}
	}
}
