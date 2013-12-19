package liftingmagnet.com.db;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;

public class DBConfigure {
	private static DBConfigure con = new DBConfigure();

	private String driver = null;
	private String connString = null;
	private String username = null;
	private String password = null;
	
	private DBConfigure(){}
	
	public String getDriver() {
		return driver;
	}
	public void setDriver(String driver) {
		this.driver = driver;
	}
	public String getConnString() {
		return connString;
	}
	public void setConnString(String connString) {
		this.connString = connString;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	private void clear()
	{
		this.connString = null;
		this.driver = null;
		this.password = null;
		this.username = null;
	}
	
	public static DBConfigure getInstance(String filePath)
	{
		con.clear();//清除数据库配置类状态
		
		File file = new File(filePath);
		System.out.println(file.getAbsolutePath());
		BufferedReader br = null;
		try {
			br = new BufferedReader(new InputStreamReader(new FileInputStream(file)));
			String line = null;
			while ( (line = br.readLine()) !=null )
			{
				line = line.trim();
				if (line.startsWith("driver="))
				{
					con.setDriver(line.substring("driver=".length()));
				}
				else if (line.startsWith("connection string="))
				{
					con.setConnString(line.substring("connection string=".length()));
				}
				else if (line.startsWith("username="))
				{
					con.setUsername(line.substring("username=".length()));
				}
				else if (line.startsWith("password="))
				{
					con.setPassword(line.substring("password=".length()));
				}
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (br!=null)
			{
				try {
					br.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return ( con.getDriver()==null||con.getConnString()==null
				 ||con.getPassword()==null||con.getUsername()==null ) ? null : con;
	}
}
