package liftingmagnet.com.util;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;

import liftingmagnet.com.db.dao.Action;
import liftingmagnet.com.db.dao.ActionType;

public class Loger {
	public static void log(Connection con,Action action)
	{
		if (con!=null)
		{
			try {
				con.setAutoCommit(true);
				ActionType type = null;
				for (int i=0;i<ActionType.TYPES.length;i++)
				{
					if (action.getType()==ActionType.TYPES[i].getValue())
					{
						type = ActionType.TYPES[i];
						break;
					}
				}
				if (type!=null)
				{
					Statement sm = con.createStatement();
					String sql = "insert into loger(actioner,type,target,action_time) values('"+action.getActioner()+"',"+action.getType()+",'"+type.transform(action.getTarget())+"','"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(action.getTime())+"')";
					//System.out.println(sql);
					sm.executeUpdate(sql);
					sm.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
