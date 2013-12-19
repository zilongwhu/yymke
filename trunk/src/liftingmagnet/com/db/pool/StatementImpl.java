package liftingmagnet.com.db.pool;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.sql.SQLException;
import java.sql.Statement;

public class StatementImpl implements InvocationHandler{
	private Statement state;
	private boolean using;
	
	public StatementImpl(Statement state) {
		super();
		this.state = state;
		this.using = false;
	}

	public boolean isUsing() {
		return using;
	}

	public void setUsing(boolean using) {
		this.using = using;
	}
	
	public Statement getProxy()
	{
		return (Statement)Proxy.newProxyInstance(state.getClass().getClassLoader(), new Class[]{Statement.class}, this);
	}
	
	public void close()
	{
		try {
			state.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public Object invoke(Object proxy, Method method, Object[] args)
			throws Throwable {
		if ("close".equals(method.getName()))
		{
			state.clearBatch();
			this.setUsing(false);
			return null;
		}
		else if ("isClosed".equals(method.getName()))
		{
			return !this.isUsing();
		}
		else
		{
			return method.invoke(state, args);
		}
	}

}
