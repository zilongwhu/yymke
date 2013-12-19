package liftingmagnet.com.db.pool;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Vector;

public class ConnectionPool {
	private static ConnectionPool pool = null;
	public static final int MIN = 5;
	public static final int MAX = 10;
	
	private Vector<ConnectionImpl> cons;
	
	private ConnectionPool()
	{
		cons = new Vector<ConnectionImpl>();
	}
	
	public synchronized void clear()
	{
		int size = cons.size();
		for (int i=0;i<size;i++)
		{
			cons.get(i).close();
		}
		cons.clear();
	}
	
	public synchronized boolean add(Connection con) throws SQLException
	{
		if (con!=null&&!con.isClosed()&&cons.size()<MAX)
		{
			cons.add(new ConnectionImpl(con));
			return true;
		}
		else
		{
			return false;
		}
	}
	
	public synchronized Connection getConnection()
	{
		ConnectionImpl con = null;
		for (int i=0;i<cons.size();)
		{
			con = cons.get(i);
			if (!con.isUsing())
			{
				try {
					Connection conn = con.getRealOne();
					if (conn.isClosed())
					{
						cons.remove(i);
						continue;
					}
					else
					{
						con.setUsing(true);
						return conn;
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			i++;
		}
		return null;
	}
	
	public synchronized Connection getConnection(Connection con) throws SQLException
	{
		if (add(con))
		{
			ConnectionImpl conImpl = cons.get(cons.size()-1);
			conImpl.setUsing(true);
			return conImpl.getProxy();
		}
		else
		{
			return null;
		}
	}
	
	public static ConnectionPool getInstance()
	{
		if (pool==null)
		{
			pool = new ConnectionPool();
		}
		return pool;
	}
}
