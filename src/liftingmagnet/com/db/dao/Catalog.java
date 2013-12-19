package liftingmagnet.com.db.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Vector;

import liftingmagnet.com.db.DBManager;

public class Catalog {
	private int id;
	private String name;
	private int priority;
	private int type;
	private int target;
	private boolean opened;
	
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
	public int getPriority() {
		return priority;
	}
	public void setPriority(int priority) {
		this.priority = priority;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getTarget() {
		return target;
	}
	public void setTarget(int target) {
		this.target = target;
	}
	public boolean isOpened() {
		return opened;
	}
	public void setOpened(boolean opened) {
		this.opened = opened;
	}
	
	public static Vector<Catalog> loadChildsFromDB(int parentId)
	{
		Vector<Catalog> list = new Vector<Catalog>();
		Connection con = DBManager.getConnection();
		if (con!=null)
		{
			try {
				Statement sm = con.createStatement();
				String sql = "select id,name,priority,type,opened,normal,product from product_catalog where parent="+parentId+" order by priority";
				if (parentId<=0)
				{
					sql = "select id,name,priority,type,opened,normal,product from product_catalog where parent is null order by priority";
				}
				ResultSet rs = sm.executeQuery(sql);
				while (rs.next())
				{
					Catalog catlog = new Catalog();
					catlog.setId(rs.getInt(1));
					catlog.setName(rs.getString(2));
					catlog.setPriority(rs.getInt(3));
					catlog.setType(rs.getInt(4));
					catlog.setOpened(rs.getBoolean(5));
					if (catlog.getType()==1)//是介绍信息
					{
						catlog.setTarget(rs.getInt(6));
					}
					else if (catlog.getType()==2)//是产品
					{
						catlog.setTarget(rs.getInt(7));
					}
					list.add(catlog);
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
		return list;
	}
	
	public static String getLocation(int id,String separator)
	{
		String name = "";
		boolean first = true;
		Connection con = DBManager.getConnection();
		if (con!=null)
		{
			try {
				PreparedStatement sm = con.prepareStatement("select name,parent from product_catalog where id=?");
				while (id>0)
				{
					sm.setInt(1, id);
					ResultSet rs = sm.executeQuery();
					if(rs.next())
					{
						if (first)
						{
							name = rs.getString(1);
							first = false;
						}
						else
						{
							name = rs.getString(1) + separator + name;
						}
						id = rs.getInt(2);
					}
					rs.close();
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
		return name;
	}
	
	public static Catalog getParent(int id)
	{
		Catalog parent = null;
		Connection con = DBManager.getConnection();
		if (con!=null)
		{
			try {
				PreparedStatement sm = con.prepareStatement("select p.id,p.name from product_catalog as p, product_catalog as c where c.parent=p.id and c.id=?");
				sm.setInt(1, id);
				ResultSet rs = sm.executeQuery();
				if (rs.next())
				{
					parent = new Catalog();
					parent.setId(rs.getInt(1));
					parent.setName(rs.getString(2));
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
		return parent;
	}
	
	public static Catalog getShortInfoById(int id)
	{
		Catalog catlog = null;
		Connection con = DBManager.getConnection();
		if (con!=null)
		{
			try {
				PreparedStatement sm = con.prepareStatement("select id,name from product_catalog where id=?");
				sm.setInt(1, id);
				ResultSet rs = sm.executeQuery();
				if (rs.next())
				{
					catlog = new Catalog();
					catlog.setId(rs.getInt(1));
					catlog.setName(rs.getString(2));
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
		return catlog;
	}
	
	public static Catalog getFullInfoById(int id)
	{
		Catalog catlog = null;
		Connection con = DBManager.getConnection();
		if (con!=null)
		{
			try {
				PreparedStatement sm = con.prepareStatement("select id,name,priority,type,opened,normal,product from product_catalog where id=?");
				sm.setInt(1, id);
				ResultSet rs = sm.executeQuery();
				if (rs.next())
				{
					catlog = new Catalog();
					catlog.setId(rs.getInt(1));
					catlog.setName(rs.getString(2));
					catlog.setPriority(rs.getInt(3));
					catlog.setType(rs.getInt(4));
					catlog.setOpened(rs.getBoolean(5));
					if (catlog.getType()==1)//是介绍信息
					{
						catlog.setTarget(rs.getInt(6));
					}
					else if (catlog.getType()==2)//是产品
					{
						catlog.setTarget(rs.getInt(7));
					}
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
		return catlog;
	}
	
	public static String getIntroductionPath(int id)
	{
		String path = "";
		Connection con = DBManager.getConnection();
		if (con!=null)
		{
			try {
				PreparedStatement sm = con.prepareStatement("select path from introduction where id=?");
				sm.setInt(1, id);
				ResultSet rs = sm.executeQuery();
				if (rs.next())
				{
					path = rs.getString(1);
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
		return path;
	}
	
	public static HashMap<Integer,Vector<Catalog>> getAllChildProducts()
	{
		HashMap<Integer,Vector<Catalog>> maps = new HashMap<Integer,Vector<Catalog>>();
		Vector<Catalog> ps = new Vector<Catalog>(); 
		Connection con = DBManager.getConnection();
		if (con!=null)
		{
			try {
				Statement sm = con.createStatement();
				String sql = "select id,name from product_catalog where type=2 order by name asc";
				sm.executeQuery(sql);
				ResultSet rs = sm.executeQuery(sql);
				while (rs.next())
				{
					Catalog product = new Catalog();
					product.setId(rs.getInt(1));
					product.setName(rs.getString(2));
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
							Vector<Catalog> v = maps.get(new Integer(child));
							if (v==null)
							{
								v = new Vector<Catalog>();
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
		return maps;
	}
}
