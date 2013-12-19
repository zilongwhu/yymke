package liftingmagnet.com.db.dao;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.StringTokenizer;
import java.sql.*;

import liftingmagnet.com.db.DBManager;

public class VisitInfo {
	private String ip;
	private Date visitTime;
	private int count;
	private String from;
	private boolean english;
	
	public VisitInfo(String ip, int count, String from,boolean english) {
		super();
		this.ip = ip;
		this.visitTime = null;
		this.count = count;
		this.from = from;
		this.english = english;
	}

	public VisitInfo(String ip, Date visitTime,boolean english) {
		super();
		this.ip = ip;
		this.visitTime = visitTime;
		this.count = 0;
		this.from = "";
		this.english = english;
		log();
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public Date getVisitTime() {
		return visitTime;
	}

	public void setVisitTime(Date visitTime) {
		this.visitTime = visitTime;
	}
	
	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public String getFrom() {
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
	}

	public boolean isEnglish() {
		return english;
	}

	public void setEnglish(boolean english) {
		this.english = english;
	}

	public static long getInnerCode(String ip)
	{
		long res = -1;
		int[] ips = new int[4];
		StringTokenizer sz = new StringTokenizer(ip,".");
		if (sz.countTokens()==4)
		{
			for (int i=0;i<4;i++)
			{
				try
				{
					ips[i] = Integer.parseInt(sz.nextToken());
				} 
				catch(NumberFormatException e)
				{
					return -1;
				}
			}
			res = ips[0]<<24|ips[1]<<16|ips[2]<<8|ips[3];
		}
		return res;
	}
	
	public static String getStrFromInnercode(long code)
	{
		return (code>>24&255)+"."+(code>>16&255)+"."+(code>>8&255)+"."+(code&255);
	}

	private void log()
	{
		Connection con = DBManager.getConnection();
		try {
			Statement state = con.createStatement();
			state.executeUpdate("insert into ip_loger(ip,time,english) values("+getInnerCode(ip)+",'"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(visitTime)+"',"+(english?1:0)+")");
			state.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static String getAddr(String ip)
	{
		String addr = "";
		Connection con = DBManager.getConnection();
		try {
			Statement state = con.createStatement();
			ResultSet rs = state.executeQuery("select addr from ip_addr where "+getInnerCode(ip)+" between ip_low and ip_high");
			if (rs.next())
			{
				addr = rs.getString(1);
			}
			rs.close();
			state.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return addr;
	}
}
