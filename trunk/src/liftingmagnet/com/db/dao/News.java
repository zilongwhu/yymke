package liftingmagnet.com.db.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import liftingmagnet.com.db.DBManager;

public class News {
	private int id;
	private String title;
	private String path;
	private String author;
	private String submitDate;
	private int viewedNums;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getSubmitDate() {
		return submitDate;
	}
	public void setSubmitDate(String submitDate) {
		this.submitDate = submitDate;
	}
	public int getViewedNums() {
		return viewedNums;
	}
	public void setViewedNums(int viewedNums) {
		this.viewedNums = viewedNums;
	}
	
	public static Vector<News> getFirst10()
	{
		Vector<News> all = new Vector<News>();
		Connection con = DBManager.getConnection();
		if (con!=null)
		{
			try {
				Statement sm = con.createStatement();
				ResultSet rs = sm.executeQuery("select id,title,author,submit_time,viewed_nums from news order by submit_time desc limit 0,10");
				while (rs.next())
				{
					News news = new News();
					news.setId(rs.getInt(1));
					news.setTitle(rs.getString(2));
					news.setPath("");
					news.setAuthor(rs.getString(3));
					news.setSubmitDate(rs.getString(4));
					news.setViewedNums(rs.getInt(5));
					all.add(news);
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
	
	public static Vector<News> getAll()
	{
		Vector<News> all = new Vector<News>();
		Connection con = DBManager.getConnection();
		if (con!=null)
		{
			try {
				Statement sm = con.createStatement();
				ResultSet rs = sm.executeQuery("select id,title,author,submit_time,viewed_nums from news order by submit_time desc");
				while (rs.next())
				{
					News news = new News();
					news.setId(rs.getInt(1));
					news.setTitle(rs.getString(2));
					news.setPath("");
					news.setAuthor(rs.getString(3));
					news.setSubmitDate(rs.getString(4));
					news.setViewedNums(rs.getInt(5));
					all.add(news);
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
	
	public static News getNews(int id)
	{
		News news = null;
		Connection con = DBManager.getConnection();
		if (con!=null)
		{
			try {
				PreparedStatement sm = con.prepareStatement("select title,path,author,submit_time,viewed_nums from news where id=? order by submit_time desc");
				sm.setInt(1, id);
				ResultSet rs = sm.executeQuery();
				if (rs.next())
				{
					news = new News();
					news.setId(id);
					news.setTitle(rs.getString(1));
					news.setPath(rs.getString(2));
					news.setAuthor(rs.getString(3));
					news.setSubmitDate(rs.getString(4));
					news.setViewedNums(rs.getInt(5));
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
		return news;
	}
	
	public static void increment(int id)
	{
		Connection con = DBManager.getConnection();
		if (con!=null)
		{
			try {
				Statement sm = con.createStatement();
				sm.executeUpdate("update news set viewed_nums=viewed_nums+1 where id="+id);
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
}
