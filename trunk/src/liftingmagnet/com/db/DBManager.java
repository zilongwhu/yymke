package liftingmagnet.com.db;

import java.sql.*;

import liftingmagnet.com.db.pool.ConnectionPool;

public class DBManager {
	private static boolean driverAvailable = false;
	private static DBConfigure configure = null;
	private static ConnectionPool pool = null;
//	private static long count = 0;
	
	public static void initDB(String filePath)
	{
		configure = DBConfigure.getInstance(filePath);
		if (configure!=null)
		{
			try {
				Class.forName(configure.getDriver());
				driverAvailable = true;
				pool = ConnectionPool.getInstance();
				for (int i=0;i<ConnectionPool.MIN;i++)
				{
					try {
						Connection con = DriverManager.getConnection(configure.getConnString(), configure.getUsername(), configure.getPassword());
						pool.add(con);
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static Connection getConnection()
	{
		if (!driverAvailable)
		{
			return null;
		}
		try {
//			long start = System.currentTimeMillis();
			Connection con = pool.getConnection();
			if (con==null)
			{
				Connection con1 = DriverManager.getConnection(configure.getConnString(), configure.getUsername(), configure.getPassword());
				con = pool.getConnection(con1);
				if (con==null)
				{
					return con1;
				}
			}
//			long end = System.currentTimeMillis();
//			System.out.println((end-start)+"ms");
//			count += end - start;
			return con;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public static void destroyDB()
	{
		pool.clear();
//		System.out.println(count+"ms");
	}
	
	public static DBConfigure getConfigure()
	{
		return configure;
	}
	
/*	public static void main(String[] args)
	{
		Connection con = getConnection();
		if (con!=null)
		{
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
*/
}
