package liftingmagnet.com.db.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import liftingmagnet.com.db.DBManager;

public class Worldwide {
	private int id;
	private String area;
	private String agent;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getAgent() {
		return agent;
	}
	public void setAgent(String agent) {
		this.agent = agent;
	}
	
	public static Vector<Worldwide> getAll()
	{
		Vector<Worldwide> all = new Vector<Worldwide>();
		Connection con = DBManager.getConnection();
		if (con!=null)
		{
			try {
				Statement sm = con.createStatement();
				ResultSet rs = sm.executeQuery("select id,area,agent from worldwide");
				while (rs.next())
				{
					Worldwide ww = new Worldwide();
					ww.setId(rs.getInt(1));
					ww.setArea(rs.getString(2));
					ww.setAgent(rs.getString(3));
					all.add(ww);
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
		return all;
	}
}
