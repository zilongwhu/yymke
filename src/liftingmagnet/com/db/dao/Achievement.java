package liftingmagnet.com.db.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import liftingmagnet.com.db.DBManager;

public class Achievement {
	private int id;
	private String destination;
	private String date;
	private int type;
	private Vector<Object[]> orders;
	public String getDestination() {
		return destination;
	}
	public void setDestination(String destination) {
		this.destination = destination;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public Vector<Object[]> getOrders() {
		return orders;
	}
	public void setOrders(Vector<Object[]> orders) {
		this.orders = orders;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public static Vector<Achievement> getByType(int id)
	{
		Vector<Achievement> va = new Vector<Achievement>();
		Connection con = DBManager.getConnection();
		if (con!=null)
		{
			try {
				Statement sm = con.createStatement();
				ResultSet rs = sm.executeQuery("select id,deal_time,distribution,belongs_to from achievements where belongs_to="+id+" order by deal_time desc, id desc");
				while (rs.next())
				{
					Achievement a = new Achievement();
					a.setId(rs.getInt(1));
					a.setDate(rs.getString(2).substring(0, rs.getString(2).length()-3));
					a.setDestination(rs.getString(3));
					a.setType(rs.getInt(4));
					Statement sm1 = con.createStatement();
					ResultSet rs1 = sm1.executeQuery("select p.id,p.name,o.quantity,o.model from orders as o, product_catalog as p where o.belongs_to="+a.getId()+" and o.product=p.id and p.type=2 order by p.name");
					Vector<Object[]> vo = new Vector<Object[]>();
					while (rs1.next())
					{
						Object[] objs = new Object[4];
						objs[0] = rs1.getInt(1);
						objs[1] = rs1.getString(2);
						objs[2] = rs1.getString(4);
						objs[3] = new Integer(rs1.getInt(3));
						vo.add(objs);
					}
					a.setOrders(vo);
					va.add(a);
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
		return va;
	}
	
	public static Achievement getById(int id)
	{
		Achievement a = null;
		Connection con = DBManager.getConnection();
		if (con!=null)
		{
			try {
				Statement sm = con.createStatement();
				ResultSet rs = sm.executeQuery("select id,deal_time,distribution,belongs_to from achievements where id="+id);
				if (rs.next())
				{
					a = new Achievement();
					a.setId(rs.getInt(1));
					a.setDate(rs.getString(2));
					a.setDestination(rs.getString(3));
					a.setType(rs.getInt(4));
					Statement sm1 = con.createStatement();
					ResultSet rs1 = sm1.executeQuery("select p.id,p.name,o.quantity,o.model from orders as o, product_catalog as p where o.belongs_to="+a.getId()+" and o.product=p.id and p.type=2 order by p.name");
					Vector<Object[]> vo = new Vector<Object[]>();
					while (rs1.next())
					{
						Object[] objs = new Object[4];
						objs[0] = rs1.getInt(1);
						objs[1] = rs1.getString(2);
						objs[2] = rs1.getString(4);
						objs[3] = new Integer(rs1.getInt(3));
						vo.add(objs);
					}
					a.setOrders(vo);
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
		return a;
	}
}
