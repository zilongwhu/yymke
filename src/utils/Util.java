package utils;
import java.sql.*;

public class Util {
	public static Connection getConnection()
	{
		try {
			Class.forName("com.mysql.jdbc.Driver");
			//DBConfigure configure = DBManager.getConfigure();
			//return DriverManager.getConnection(configure.getConnString(), configure.getUsername(), configure.getPassword());
			return DriverManager.getConnection("jdbc:mysql://localhost:3306/ql_db?useUnicode=true&characterEncoding=UTF-8", "root", "125913");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public static void closeConnection(Connection con)
	{
		try {
			if (con!=null&&!con.isClosed())
			{
				con.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static String getParent(int cid)
	{
		String location = "";
		String sql1 = "SELECT typename FROM t_product_type WHERE typeid=(SELECT pid FROM t_product_type WHERE typeid="+cid+")";
		String sql2 = "SELECT typename FROM t_product_type WHERE typeid="+cid;
		Connection con = Util.getConnection();
		try {
			Statement state1 = con.createStatement();
			ResultSet rs1 = state1.executeQuery(sql1);
			if (rs1.next())
			{
				location += rs1.getString(1)+"&gt;&gt;&gt;";
				Statement state2 = con.createStatement();
				ResultSet rs2 = state2.executeQuery(sql2);
				if (rs2.next())
				{
					location += rs2.getString(1);
				}
				rs2.close();
				state2.close();
			}
			rs1.close();
			state1.close();
		} catch (SQLException e) {
			e.printStackTrace();
			location = "";
		}
		Util.closeConnection(con);
		return location;
	}
	
	public static String getSafeStr(String str)
	{
		return str.replaceAll("'", "\"");
	}
	
	
//	public static void main(String[] args)
//	{
//		Connection con = getConnection();
//		try {
//			Vector<String[]> buf = new Vector<String[]>();
//			Statement s = con.createStatement();
//			ResultSet rs = s.executeQuery("select id,content from t_product");
//			while (rs.next())
//			{
//				buf.add(new String[]{rs.getString(1),rs.getString(2)});
//			}
//			rs.close();
//			s.close();
//			
//			for (int i=0;i<buf.size();i++)
//			{
//				String str = buf.get(i)[1];
//				String str1 = str.replaceAll("Uploads/µç´Å½Á°è×°ÖÃ(ÖÐÎÄ)/", "Uploads/stirrer_zh/");
//				//str1 = str1.replaceAll("Uploads/µç´ÅÌú/", "Uploads/liftingmagnet_zh/");
//				//str1 = str1.replaceAll("Uploads/³ýÌúÆ÷ÖÐÎÄ/", "Uploads/separator_zh/");
//				//str1 = str1.replaceAll("Uploads/³ýÌúÆ÷/", "Uploads/separator/");
//				//str1 = str1.replaceAll("Uploads/µç ÀÂ ¾í Í²/", "Uploads/cable_zh/");
//				buf.get(i)[1] = str1;
//			}
//			
//			PreparedStatement ps = con.prepareStatement("update t_product set content=? where id=?");
//			for (int i=0;i<buf.size();i++)
//			{
//				ps.setString(1, buf.get(i)[1]);
//				ps.setString(2, buf.get(i)[0]);
//				ps.executeUpdate();
//			}
//			ps.close();
//			
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		closeConnection(con);
//	}
}
