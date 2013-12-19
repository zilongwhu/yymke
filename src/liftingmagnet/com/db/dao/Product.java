package liftingmagnet.com.db.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import liftingmagnet.com.db.DBManager;
import liftingmagnet.com.util.StringHelper;

public class Product {
	int id;
	String name;
	int productId;
	int parent;
	String features;
	String imgPath;
	String path;
	boolean isPromoted;
	boolean isOnHomepage;
	String produceDate;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public int getParent() {
		return parent;
	}
	public void setParent(int parent) {
		this.parent = parent;
	}
	public String getImgPath() {
		return imgPath;
	}
	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public boolean isPromoted() {
		return isPromoted;
	}
	public void setPromoted(boolean isPromoted) {
		this.isPromoted = isPromoted;
	}
	public boolean isOnHomepage() {
		return isOnHomepage;
	}
	public void setOnHomepage(boolean isOnHomepage) {
		this.isOnHomepage = isOnHomepage;
	}
	public String getProduceDate() {
		return produceDate;
	}
	public void setProduceDate(String produceDate) {
		this.produceDate = produceDate;
	}
	public String getFeatures() {
		return features;
	}
	public void setFeatures(String features) {
		this.features = features;
	}
	
	public static Product getProductById(int id)
	{
		Product product = null;
		Connection con = DBManager.getConnection();
		if (con!=null)
		{
			try {
				Statement sm = con.createStatement();
				String sql = "select pc.id,pc.name,pc.product,pc.parent,p.features,p.path,p.img_path,p.is_strongly_promoted,p.is_on_homepage,p.produce_date" +
					" from product_catalog as pc, product as p where pc.id="+id+" and pc.type=2 and pc.product=p.id";
				ResultSet rs = sm.executeQuery(sql);
				if (rs.next())
				{
					product = new Product();
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
				}
				rs.close();
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
		return product;
	}
	
	public static Vector<Product> getProductsByParent(int parentId)
	{
		Vector<Product> products = new Vector<Product>();
		Connection con = DBManager.getConnection();
		if (con!=null)
		{
			try {
				Statement sm = con.createStatement();
				String sql = "select pc.id,pc.name,pc.product,pc.parent,p.features,p.path,p.img_path,p.is_strongly_promoted,p.is_on_homepage,p.produce_date" +
					" from product_catalog as pc, product as p where pc.parent="+parentId+" and pc.type=2 and pc.product=p.id order by p.produce_date desc";
				if (parentId<=0)
				{
					sql = "select pc.id,pc.name,pc.product,pc.parent,p.features,p.path,p.img_path,p.is_strongly_promoted,p.is_on_homepage,p.produce_date" +
					" from product_catalog as pc, product as p where pc.parent is null and pc.type=2 and pc.product=p.id order by p.produce_date desc";
				}
				
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
					products.add(product);
				}
				rs.close();
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
		return products;
	}
	
	public static Vector<Product> search(String name,int id)
	{
		Vector<Product> products = new Vector<Product>();
		Connection con = DBManager.getConnection();
		if (con!=null)
		{
			try {
				String sql = "select pc.id,pc.name,pc.product,pc.parent,p.features,p.path,p.img_path,p.is_strongly_promoted,p.is_on_homepage,p.produce_date" +
					" from product_catalog as pc, product as p where pc.type=2 and p.keyword like '%"
					+StringHelper.transform(name,'\'',"''")+"%' and pc.product=p.id order by p.produce_date desc";
				Statement sm = con.createStatement();
				ResultSet rs = sm.executeQuery(sql);
				if (id<=0)
				{
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
						products.add(product);
					}
				}
				else
				{
					PreparedStatement sm1 = con.prepareStatement("select p.id from product_catalog as p, product_catalog as c where c.parent=p.id and c.id=?");
					while (rs.next())
					{
						int type = rs.getInt(1);
						boolean found = false;
						while (!found)
						{
							sm1.setInt(1, type);
							ResultSet rs1 = sm1.executeQuery();
							if (rs1.next())
							{
								type = rs1.getInt(1);
							}
							else
							{
								found = true;
							}
							rs1.close();
						}
						if (id!=type)
						{
							continue;
						}
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
						products.add(product);
					}
					sm1.close();
				}
				
				rs.close();
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
		return products;
	}
}
