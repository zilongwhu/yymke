package liftingmagnet.com.db.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import liftingmagnet.com.db.DBManager;

public class Feedback {
	private int id;
	private String question;
	private String email;
	private String submitTime;
	private String ip;
	private boolean isHidden;
	private String answerPath;
	private String answerTime;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getSubmitTime() {
		return submitTime;
	}
	public void setSubmitTime(String submitTime) {
		this.submitTime = submitTime;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public boolean isHidden() {
		return isHidden;
	}
	public void setHidden(boolean isHidden) {
		this.isHidden = isHidden;
	}
	public String getAnswerPath() {
		return answerPath;
	}
	public void setAnswerPath(String answerPath) {
		this.answerPath = answerPath;
	}
	public String getAnswerTime() {
		return answerTime;
	}
	public void setAnswerTime(String answerTime) {
		this.answerTime = answerTime;
	}
	
	public boolean insertToDB()
	{
		boolean success = false;
		Connection con = DBManager.getConnection();
		if (con!=null&&question!=null&&submitTime!=null&&ip!=null)
		{
			try {
				PreparedStatement sm = con.prepareStatement("insert into feedback(question,submit_time,email,ip) values(?,?,?,?)");
				sm.setString(1, question);
				sm.setString(2, submitTime);
				sm.setString(3, email);
				sm.setString(4, ip);
				if (sm.executeUpdate()==1)
				{
					success = true;
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
		return success;
	}
	
	public static Vector<Feedback> getAll()
	{
		Vector<Feedback> fbs = new Vector<Feedback>();
		Connection con = DBManager.getConnection();
		if (con!=null)
		{
			try {
				Statement sm = con.createStatement();
				ResultSet rs = sm.executeQuery("select id,question,submit_time,ip,answer,answer_time from feedback where answer is not null and hidden=0 order by submit_time desc");
				while (rs.next())
				{
					Feedback fb = new Feedback();
					fb.setId(rs.getInt(1));
					fb.setQuestion(rs.getString(2));
					fb.setSubmitTime(rs.getString(3));
					fb.setIp(rs.getString(4));
					fb.setAnswerPath(rs.getString(5));
					fb.setAnswerTime(rs.getString(6));
					fbs.add(fb);
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
		return fbs;
	}
	
	public static Vector<Feedback> getAllWaitingForAnswer()
	{
		Vector<Feedback> fbs = new Vector<Feedback>();
		Connection con = DBManager.getConnection();
		if (con!=null)
		{
			try {
				Statement sm = con.createStatement();
				ResultSet rs = sm.executeQuery("select id,question,submit_time,ip,email from feedback where answer is null and hidden=0 order by submit_time");
				while (rs.next())
				{
					Feedback fb = new Feedback();
					fb.setId(rs.getInt(1));
					fb.setQuestion(rs.getString(2));
					fb.setSubmitTime(rs.getString(3));
					fb.setIp(rs.getString(4));
					fb.setEmail(rs.getString(5));
					fbs.add(fb);
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
		return fbs;
	}
	
	public static Feedback getById(int id)
	{
		Feedback fb = null;
		Connection con = DBManager.getConnection();
		if (con!=null)
		{
			try {
				Statement sm = con.createStatement();
				ResultSet rs = sm.executeQuery("select question,submit_time,ip,email from feedback where answer is null and hidden=0 and id="+id);
				if (rs.next())
				{
					fb = new Feedback();
					fb.setQuestion(rs.getString(1));
					fb.setSubmitTime(rs.getString(2));
					fb.setIp(rs.getString(3));
					fb.setEmail(rs.getString(4));
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
		return fb;
	}
}