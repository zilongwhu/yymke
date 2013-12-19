import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.*;

import liftingmagnet.com.usermanage.Authority;
import liftingmagnet.com.usermanage.PasswordMD5;

public class Admin {

	public static boolean generateSuperAdmin(String name,String password,String path)
	{
		boolean success = false;
		
		Authority limits = new Authority();
		limits.setAddAchievement(true);
		limits.setAddNews(true);
		limits.setAddProduct(true);
		limits.setAddUser(true);
		limits.setAnswerFeedback(true);
		limits.setDeleteAchievement(true);
		limits.setDeleteFeedback(true);
		limits.setDeleteNews(true);
		limits.setDeleteProduct(true);
		limits.setDeleteUser(true);
		limits.setManageContactInfo(true);
		limits.setManageProductList(true);
		limits.setManageWorldwide(true);
		limits.setModifyAchievement(true);
		limits.setModifyNews(true);
		limits.setModifyProduct(true);
		limits.setModifyUser(true);
		limits.setSupervise(true);
		limits.setViewVisitors(true);
		
		try {
			Class.forName("com.mysql.jdbc.Driver");

			Connection con = DriverManager.getConnection("jdbc:mysql://121.199.61.196:3306/zp5041_db?useUnicode=true&characterEncoding=UTF-8", "zp5041", "h9z4s7t6");

			if (con!=null)
			{
				try {
					PreparedStatement sm = con.prepareStatement("insert into admins(username,password,authority) values(?,?,?)");
					sm.setString(1, name);
					sm.setBytes(2, PasswordMD5.encode(password));
					sm.setInt(3, limits.getData());
					success = sm.executeUpdate()==1;
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
			
		} catch (ClassNotFoundException e1) {
			e1.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return success;
	}
	
	public static void setAuthority(String name)
	{
		Authority limits = new Authority();
		limits.setAddAchievement(true);
		limits.setAddNews(true);
		limits.setAddProduct(true);
		limits.setAddUser(true);
		limits.setAnswerFeedback(true);
		limits.setDeleteAchievement(true);
		limits.setDeleteFeedback(true);
		limits.setDeleteNews(true);
		limits.setDeleteProduct(true);
		limits.setDeleteUser(true);
		limits.setManageContactInfo(true);
		limits.setManageProductList(true);
		limits.setManageWorldwide(true);
		limits.setModifyAchievement(true);
		limits.setModifyNews(true);
		limits.setModifyProduct(true);
		limits.setModifyUser(true);
		limits.setSupervise(true);
		limits.setViewVisitors(true);
		
		try {
			Class.forName("com.mysql.jdbc.Driver");

			Connection con = DriverManager.getConnection("jdbc:mysql://121.199.61.196:3306/zp5041_db?useUnicode=true&characterEncoding=UTF-8", "zp5041", "h9z4s7t6");

			if (con!=null)
			{
				try {
					PreparedStatement sm = con.prepareStatement("update admins set authority=? where username=?");
					sm.setInt(1, limits.getData());
					sm.setString(2, name);
					sm.executeUpdate();
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
			
		} catch (ClassNotFoundException e1) {
			e1.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void updatePassword(String name,String password)
	{
		try {
			Class.forName("com.mysql.jdbc.Driver");

			Connection con = DriverManager.getConnection("jdbc:mysql://121.199.61.196:3306/zp5041_db?useUnicode=true&characterEncoding=UTF-8", "zp5041", "h9z4s7t6");

			if (con!=null)
			{
				try {
					PreparedStatement sm = con.prepareStatement("update admins set password=? where username=?");
					sm.setBytes(1, PasswordMD5.encode(password));
					sm.setString(2, name);
					sm.executeUpdate();
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
			
		} catch (ClassNotFoundException e1) {
			e1.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static Object[] convert(String str)
	{
		StringBuffer sb = new StringBuffer();
		int len = str.length();
		boolean started = false;
		Boolean changed = false;
		for (int i=0;i<len;i++)
		{
			char ch = str.charAt(i);
			if (ch=='\'')
			{
				if (started)
				{
					if ((i+1<len)&&str.charAt(i+1)!=')')
					{
						sb.append('\'');
						changed = true;
					}
				}
				else
				{
					started = true;
				}
			}
			sb.append(ch);
		}
		return new Object[]{sb.toString(),changed};
	}
	
	public static void ipUpload()
	{
		try {
			Class.forName("com.mysql.jdbc.Driver");

			Connection con = DriverManager.getConnection("jdbc:mysql://121.199.61.196:3306/zp5041_db?useUnicode=true&characterEncoding=UTF-8", "zp5041", "h9z4s7t6");
			
			BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream("D:\\dest.txt")));
			String line = br.readLine();
			int i=0;
			Statement state = con.createStatement();
			while (line!=null&&(line=line.trim()).length()>0)
			{
				Object[] objs = convert(line);
				if ((Boolean)objs[1]==true)
				{
					try
					{
						state.executeUpdate((String)objs[0]);
					} catch(Exception e)
					{
						e.printStackTrace();
					}
					System.out.println(++i);
				}
				line = br.readLine();
			}
			state.close();
			br.close();
			
			con.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args)
	{
		//generateSuperAdmin("htt","125913",args[0]);
		//updatePassword("Öì×ÓÁú","125913");
		//updatePassword("ºîæÃæÃ","125913");
		//updatePassword("Ð¡Ñù","125913");
		//updatePassword("htt","125913");
		//setAuthority("ql_admin99");
		ipUpload();
	}
}
