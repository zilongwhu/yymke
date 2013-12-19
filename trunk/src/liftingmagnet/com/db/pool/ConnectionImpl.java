package liftingmagnet.com.db.pool;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.SQLException;
import java.util.Vector;

public class ConnectionImpl implements InvocationHandler{
	public static final int MIN = 1;
	public static final int MAX = 3;
	private Connection con;
	private Vector<StatementImpl> statements;
	private boolean using;
	
	public ConnectionImpl(Connection con) {
		super();
		this.con = con;
		this.using = false;
		statements = new Vector<StatementImpl>();
		for (int i=0;i<MIN;i++)
		{
			try {
				Statement state = con.createStatement();
				statements.add(new StatementImpl(state));
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public boolean isUsing() {
		return using;
	}

	public void setUsing(boolean using) {
		this.using = using;
	}
	
	public Connection getRealOne()
	{
		return this.con;
	}
	
	public Connection getProxy()
	{
		return (Connection)Proxy.newProxyInstance(con.getClass().getClassLoader(), new Class[]{Connection.class}, this);
	}
	
	public void close()
	{
		try {
			for (int i=0;i<statements.size();i++)
			{
				statements.get(i).close();
			}
			statements.clear();
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public Object invoke(Object proxy, Method method, Object[] args)
			throws Throwable {
		if ("close".equals(method.getName()))
		{
			con.clearWarnings();
			con.setAutoCommit(true);
			this.setUsing(false);
			return null;
		}
		else if ("isClosed".equals(method.getName()))
		{
			return !this.isUsing();
		}
		else if("createStatement".equals(method.getName()))
		{
			int size = statements.size();
			StatementImpl state = null;
			for (int i=0;i<size;i++)
			{
				state = statements.get(i);
				if (!state.isUsing())
				{
					state.setUsing(true);
					return state.getProxy();
				}
			}
			if (size<MAX)
			{
				statements.add(new StatementImpl((Statement)method.invoke(con, args)));
				StatementImpl stateImpl = statements.get(size);
				stateImpl.setUsing(true);
				return stateImpl.getProxy();
			}
			else
			{
				return method.invoke(con, args);
			}
		}
		else
		{
			Object obj = method.invoke(con, args);
			return obj;
		}
	}

}
