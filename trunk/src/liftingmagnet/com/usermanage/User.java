package liftingmagnet.com.usermanage;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Vector;

import liftingmagnet.com.db.DBManager;
import liftingmagnet.com.db.dao.Action;
import liftingmagnet.com.db.dao.ActionType;
import liftingmagnet.com.db.dao.VisitInfo;
import liftingmagnet.com.db.dao.Worldwide;
import liftingmagnet.com.util.Loger;

public class User {
	private String name;
	private String password;
	private Authority limits;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name==null?"":name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password==null?"":password;
	}
	public Authority getLimits() {
		return limits;
	}
	
	/**
	 * 返回值 0表示成功登录， 1表示用户名不存在， 2表示密码错误。
	 * @return
	 */
	public int login()
	{
		int status = -1;
		
		Connection con = DBManager.getConnection();
		if (con!=null)
		{
			try {
				PreparedStatement sm = con.prepareStatement("select username,password,authority from admins where username=?");
				sm.setString(1, name);
				ResultSet rs = sm.executeQuery();
				if (rs.next())
				{
					if (PasswordMD5.isEqual(password, rs.getBytes("password")))
					{
						limits = new Authority(rs.getInt("authority"));
						status = 0;
						
						Action action = new Action();
						action.setActioner(this.name);
						action.setType(ActionType.TYPES[0].getValue());
						action.setTarget("");
						action.setTime(java.util.Calendar.getInstance().getTime());

						Loger.log(con,action);
					}
					else
					{
						status = 2;
					}
				}
				else
				{
					status = 1;
				}
				rs.close();
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
		
		return status;
	}
	
	public void reload()
	{
		Connection con = DBManager.getConnection();
		if (con!=null)
		{
			try {
				PreparedStatement sm = con.prepareStatement("select authority from admins where username=?");
				sm.setString(1, name);
				ResultSet rs = sm.executeQuery();
				if (rs.next())
				{
					limits = new Authority(rs.getInt(1));
				}
				rs.close();
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
	}
	
	/**
	 * 返回值 0表示成功添加新用户， 1表示用户名已经存在， 2表示用户权限不够。
	 * @return
	 */
	public int addUser(String name,String password,Authority limits)
	{
		int status = -1;
		
		if (name!=null&&password!=null&&limits!=null&&this.limits.canAddUser())
		{
			Connection con = DBManager.getConnection();
			if (con!=null)
			{
				try {
					PreparedStatement sm = con.prepareStatement("insert into admins(username,password,authority) values(?,?,?)");
					sm.setString(1, name);
					sm.setBytes(2, PasswordMD5.encode(password));
					sm.setInt(3, limits.getData());
					try{
						if (sm.executeUpdate()==1)
						{
							status = 0;

							Action action = new Action();
							action.setActioner(this.name);
							action.setType(ActionType.TYPES[2].getValue());
							action.setTarget(name);
							action.setTime(java.util.Calendar.getInstance().getTime());

							Loger.log(con,action);
						}
					}
					catch(Exception e)
					{
						status = 1;//用户名已存在
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
		}
		else
		{
			status = 2;
		}
		return status;
	}
	
	public Vector<User> getAllUsers()
	{
		Vector<User> users = new Vector<User>();
		
		Connection con = DBManager.getConnection();
		if (con!=null)
		{
			try {
				Statement sm = con.createStatement();
				ResultSet rs = sm.executeQuery("select username,authority from admins");
				while (rs.next())
				{
					User user = new User();
					user.setName(rs.getString(1));
					user.limits = new Authority(rs.getInt(2));
					users.add(user);
				}
				rs.close();
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
		return users;
	}
	
	public User getUser(String name)
	{
		User user = null;
		
		Connection con = DBManager.getConnection();
		if (con!=null)
		{
			try {
				PreparedStatement sm = con.prepareStatement("select authority from admins where username=?");
				sm.setString(1, name);
				ResultSet rs = sm.executeQuery();
				while (rs.next())
				{
					user = new User();
					user.setName(name);
					user.limits = new Authority(rs.getInt(1));
				}
				rs.close();
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
		return user;
	}
	
	/**
	 * 返回值 0表示成功修改用户权限， 1表示用户权限不够。
	 * @return
	 */
	public int modifyUserAuthority(String name,Authority limits)
	{
		int status = -1;
		
		if (name!=null&&limits!=null&&this.limits.canModifyUser())
		{
			Connection con = DBManager.getConnection();
			if (con!=null)
			{
				try {
					PreparedStatement sm = con.prepareStatement("update admins set authority=? where username=?");
					sm.setInt(1, limits.getData());
					sm.setString(2, name);
					if (sm.executeUpdate()==1)
					{
						status = 0;

						Action action = new Action();
						action.setActioner(this.name);
						action.setType(ActionType.TYPES[3].getValue());
						action.setTarget(name);
						action.setTime(java.util.Calendar.getInstance().getTime());

						Loger.log(con,action);
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
		}
		else
		{
			status = 1;
		}
		return status;
	}
	
	/**
	 * 返回值 0表示成功修改用户权限， 1表示用户权限不够。
	 * @return
	 */
	public int deleteUser(String name)
	{
		int status = -1;
		
		if (name!=null&&limits!=null&&this.limits.canDeleteUser())
		{
			Connection con = DBManager.getConnection();
			if (con!=null)
			{
				try {
					PreparedStatement sm = con.prepareStatement("delete from admins where username=?");
					sm.setString(1, name);
					if (sm.executeUpdate()==1)
					{
						status = 0;

						Action action = new Action();
						action.setActioner(this.name);
						action.setType(ActionType.TYPES[4].getValue());
						action.setTarget(name);
						action.setTime(java.util.Calendar.getInstance().getTime());

						Loger.log(con,action);
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
		}
		else
		{
			status = 1;
		}
		return status;
	}
	
	/**
	 * 返回值为 0 表示成功，1 表示旧密码错误。
	 * @param oldPassword
	 * @param newPassword
	 * @return
	 */
	public int changePassword(String oldPassword,String newPassword)
	{
		int status = -1;
		Connection con = DBManager.getConnection();
		if (con!=null)
		{
			try {
				PreparedStatement sm = con.prepareStatement("update admins set password=? where username=? and password=?");
				sm.setBytes(1, PasswordMD5.encode(newPassword));
				sm.setString(2, name);
				sm.setBytes(3, PasswordMD5.encode(oldPassword));
				if (sm.executeUpdate()==1)
				{
					status = 0;
				}
				else
				{
					status = 1;
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
		return status;
	}
	
	/**
	 * 返回值为 0 表示成功，1 表示权限不够。
	 * @param oldPassword
	 * @param newPassword
	 * @return
	 */
	public int addWorldwide(Worldwide ww)
	{
		int status = -1;

		if (ww.getArea()!=null&&ww.getAgent()!=null&&this.limits.canManageWorldwide())
		{
			Connection con = DBManager.getConnection();
			if (con!=null)
			{
				try {
					PreparedStatement sm = con.prepareStatement("insert into worldwide(area,agent) values(?,?)");
					sm.setString(1, ww.getArea());
					sm.setString(2, ww.getAgent());
					if (sm.executeUpdate()==1)
					{
						status = 0;

						Action action = new Action();
						action.setActioner(this.name);
						action.setType(ActionType.TYPES[22].getValue());
						action.setTarget(ww.getAgent());
						action.setTime(java.util.Calendar.getInstance().getTime());

						Loger.log(con,action);
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
		}
		else
		{
			status = 1;
		}
		return status;
	}
	
	/**
	 * 返回值 0表示成功删除代理商， 1表示用户权限不够。
	 * @return
	 */
	public int deleteWorldwide(int id)
	{
		int status = -1;
		
		if (this.limits.canManageWorldwide())
		{
			Connection con = DBManager.getConnection();
			if (con!=null)
			{
				try {
					String agent = null;
					Statement sm = con.createStatement();
					ResultSet rs = sm.executeQuery("select agent from worldwide where id="+id);
					if (rs.next())
					{
						agent = rs.getString(1);
					}
					rs.close();
					sm.close();
					
					if (agent!=null)
					{
						sm = con.createStatement();
						if (sm.executeUpdate("delete from worldwide where id="+id)==1)
						{
							status = 0;
	
							Action action = new Action();
							action.setActioner(this.name);
							action.setType(ActionType.TYPES[23].getValue());
							action.setTarget(agent);
							action.setTime(java.util.Calendar.getInstance().getTime());
	
							Loger.log(con,action);
						}
						sm.close();
					}
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
		}
		else
		{
			status = 1;
		}
		return status;
	}
	
	/**
	 * 返回值 0表示成功添加新闻， 1表示用户权限不够。
	 * @return
	 */
	public int addNews(String title,String path)
	{
		int status = -1;
		
		if (title==null||path==null||this.limits.canAddNews())
		{
			Connection con = DBManager.getConnection();
			if (con!=null)
			{
				try {
					PreparedStatement sm = con.prepareStatement("insert into news(title,path,author,submit_time) values(?,?,?,?)");
					sm.setString(1, title);
					sm.setString(2, path);
					sm.setString(3, this.name);
					java.text.SimpleDateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd");
					sm.setString(4, df.format(java.util.Calendar.getInstance().getTime()));
					if (sm.executeUpdate()==1)
					{
						status = 0;
						
						Action action = new Action();
						action.setActioner(this.name);
						action.setType(ActionType.TYPES[5].getValue());
						action.setTarget(title);
						action.setTime(java.util.Calendar.getInstance().getTime());

						Loger.log(con,action);
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
		}
		else
		{
			status = 1;
		}
		return status;
	}
	
	/**
	 * 返回值 0表示成功修改新闻， 1表示用户权限不够。
	 * @return
	 */
	public int modifyNews(int id)
	{
		int status = -1;
		
		if (id<0||this.limits.canModifyNews())
		{
			Connection con = DBManager.getConnection();
			if (con!=null)
			{
				try {
					PreparedStatement sm = con.prepareStatement("update news set author=?,submit_time=? where id=?");
					sm.setString(1, this.name);
					java.text.SimpleDateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd");
					sm.setString(2, df.format(java.util.Calendar.getInstance().getTime()));
					sm.setInt(3, id);
					if (sm.executeUpdate()==1)
					{
						status = 0;

						String title = "";
						Statement s = con.createStatement();
						ResultSet rs = s.executeQuery("select title from news where id="+id);
						if (rs.next())
						{
							title = rs.getString(1);
						}
						rs.close();
						s.close();

						Action action = new Action();
						action.setActioner(this.name);
						action.setType(ActionType.TYPES[6].getValue());
						action.setTarget(title);
						action.setTime(java.util.Calendar.getInstance().getTime());
						
						Loger.log(con,action);
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
		}
		else
		{
			status = 1;
		}
		return status;
	}
	
	/**
	 * 返回值 0表示成功删除新闻， 1表示用户权限不够。
	 * @return
	 */
	public int deleteNews(int id)
	{
		int status = -1;
		
		if (id<0||this.limits.canDeleteNews())
		{
			Connection con = DBManager.getConnection();
			if (con!=null)
			{
				try {
					String title = "";
					Statement sm = con.createStatement();
					ResultSet rs = sm.executeQuery("select title from news where id="+id);
					if (rs.next())
					{
						title = rs.getString(1);
					}
					rs.close();
					sm.close();
					
					sm = con.createStatement();
					if (sm.executeUpdate("delete from news where id="+id)==1)
					{
						status = 0;

						Action action = new Action();
						action.setActioner(this.name);
						action.setType(ActionType.TYPES[7].getValue());
						action.setTarget(title);
						action.setTime(java.util.Calendar.getInstance().getTime());
						
						Loger.log(con,action);
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
		}
		else
		{
			status = 1;
		}
		return status;
	}
	
	/**
	 * 返回构造好的目录结构
	 * @return
	 */
	public Vector<Directory> getAllDirectories()
	{
		Vector<Directory> dirs = new Vector<Directory>();
		if (this.limits.canManageProductList())
		{
			dirs.add(new Directory());
			Connection con = DBManager.getConnection();
			if (con!=null)
			{
				try {
					Statement sm = con.createStatement();
					ResultSet rs = sm.executeQuery("select id,name,parent from product_catalog where type=0 order by parent asc, id asc");
					while (rs.next())
					{
						Directory dir = new Directory();
						dir.setId(rs.getInt(1));
						dir.setPath(rs.getString(2)+"/");
						dir.setParent(rs.getInt(3));
						dirs.add(dir);
					}
					rs.close();
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
			int size = dirs.size();
			Vector<String> paths = new Vector<String>();
			for (int i=0;i<size;i++)
			{
				Directory dir = dirs.get(i);
				Directory child = dir;
				String path = dir.getPath();
				while (child.getParent()>=0)
				{
					Directory parent = null;
					for (int j=0;j<size;j++)
					{
						if (child.getParent()==dirs.get(j).getId())
						{
							parent = dirs.get(j);
							break;
						}
					}
					if (parent==null)
					{
						break;
					}
					else
					{
						path = parent.getPath()+path;
						child = parent;
					}
				}
				paths.add(path);
			}
			for (int i=0;i<size;i++)
			{
				dirs.get(i).setPath(paths.get(i));
			}
			for (int i=0;i<size;i++)
			{
				int min = i;
				int minNum = new java.util.StringTokenizer(dirs.get(min).getPath(),"/",true).countTokens();
				for (int j=i+1;j<size;j++)
				{
					int num = new java.util.StringTokenizer(dirs.get(j).getPath(),"/",true).countTokens();
					if (num<minNum)
					{
						min = j;
						minNum = num;
					}
				}
				if (min!=i)
				{
					Directory dir = dirs.get(i);
					dirs.set(i, dirs.get(min));
					dirs.set(min, dir);
				}
			}
		}
		return dirs;
	}
	
	/**
	 * 添加新产品类型
	 * @return
	 */
	public int addProductType(int parentId,String name)
	{
		int status = -1;
		if (name==null||this.limits.canManageProductList())
		{
			Connection con = DBManager.getConnection();
			if (con!=null)
			{
				try {
					con.setAutoCommit(false);
					if (parentId<=0)
					{
						Statement s = con.createStatement();
						ResultSet rs = s.executeQuery("select priority from product_catalog where parent is null order by priority desc");
						int priority = 1;
						if (rs.next())
						{
							priority = rs.getInt(1)+1;
						}
						rs.close();
						s.close();
						PreparedStatement sm = con.prepareStatement("insert into product_catalog(name,priority,type) values(?,?,?)");
						sm.setString(1, name);
						sm.setInt(2, priority);
						sm.setInt(3, 0);
						if (sm.executeUpdate()==1)
						{
							status = 0;
						}
						sm.close();
					}
					else
					{
						Statement s = con.createStatement();
						ResultSet rs = s.executeQuery("select priority from product_catalog where parent="+parentId+" order by priority desc");
						int priority = 1;
						if (rs.next())
						{
							priority = rs.getInt(1)+1;
						}
						rs.close();
						s.close();
						PreparedStatement sm = con.prepareStatement("insert into product_catalog(name,priority,type,parent) values(?,?,?,?)");
						sm.setString(1, name);
						sm.setInt(2, priority);
						sm.setInt(3, 0);
						sm.setInt(4, parentId);
						if (sm.executeUpdate()==1)
						{
							status = 0;
						}
						sm.close();
					}
					con.commit();
					
					Action action = new Action();
					action.setActioner(this.name);
					action.setType(ActionType.TYPES[8].getValue());
					action.setTarget(name);
					action.setTime(java.util.Calendar.getInstance().getTime());
					
					Loger.log(con,action);
				} catch (SQLException e) {
					e.printStackTrace();
					try {
						con.rollback();
					} catch (SQLException e1) {
						e1.printStackTrace();
					}
				} finally {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
		else
		{
			status = 1;
		}
		return status;
	}
	
	/**
	 * 移动产品
	 * @return
	 */
	public int moveCatalog(int[] ids,int target)
	{
		int status = -1;
		if (ids==null||this.limits.canManageProductList())
		{
			Connection con = DBManager.getConnection();
			if (con!=null)
			{
				try {
					con.setAutoCommit(false);
					if (target<=0)
					{
						PreparedStatement sm = con.prepareStatement("update product_catalog set parent=null where id=?");
						for (int i=0;i<ids.length;i++)
						{
							sm.setInt(1, ids[i]);
							if (sm.executeUpdate()==1)
							{
								status = 0;
							}
							else
							{
								status = -1;
							}
						}
						sm.close();
					}
					else
					{
						PreparedStatement sm = con.prepareStatement("update product_catalog set parent=? where id=?");
						for (int i=0;i<ids.length;i++)
						{
							if (ids[i]==target)//不能自我包含
							{
								status = 2;
								break;
							}
							sm.setInt(1, target);
							sm.setInt(2, ids[i]);
							if (sm.executeUpdate()==1)
							{
								status = 0;
							}
							else
							{
								status = -1;
							}
						}
						sm.close();
					}
					if (status==0)//维护产品关键字
					{
						Vector<Integer[]> products = new Vector<Integer[]>();//需要维护的产品。元素第一个为product_catalog的id，第二个为product的id。
						Statement s = con.createStatement();
						ResultSet r = s.executeQuery("select id,parent,product from product_catalog where type=2");
						PreparedStatement psm = con.prepareStatement("select parent from product_catalog where id=?");
						while (r.next())
						{
							int id = r.getInt(1);
							int parent = r.getInt(2);
							int product = r.getInt(3);
							
							boolean matched = false;
							for (int i=0;i<ids.length;i++)//判断自己本身是否为产品
							{
								if (ids[i]==id)
								{
									matched = true;
									break;
								}
							}
							if (!matched)//判断产品是否属于某个目录
							{
								int parentCopy = parent;
								while (!matched)
								{
									for (int i=0;i<ids.length;i++)
									{
										if (ids[i]==parentCopy)
										{
											matched = true;
											break;
										}
									}
									if (!matched)
									{
										psm.setInt(1, parentCopy);
										ResultSet rr = psm.executeQuery();
										if (rr.next())
										{
											parentCopy = rr.getInt(1);
											rr.close();
										}
										else
										{
											rr.close();
											break;
										}
									}
								}
							}
							
							if (matched)
							{
								products.add(new Integer[]{id,product});
							}
						}
						psm.close();
						r.close();
						s.close();
						
						psm = con.prepareStatement("update product set keyword=? where id=?");
						for (int i=0;i<products.size();i++)
						{
							Integer[] is = products.get(i);
							String keyword = User.getProductKeyword(con,is[0]);
							psm.setString(1, keyword);
							psm.setInt(2, is[1]);
							if (psm.executeUpdate()!=1)
							{
								status = 2;
								break;
							}
						}
						psm.close();
					}
					if (status!=0)
					{
						con.rollback();
					}
					else
					{
						con.commit();
					}
				} catch (SQLException e) {
					e.printStackTrace();
					try {
						con.rollback();
					} catch (SQLException e1) {
						e1.printStackTrace();
					}
				} finally {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
		else
		{
			status = 1;
		}
		return status;
	}
	
	/**
	 * 获取父亲
	 * @return
	 */
	public int getParentCatalog(int id)
	{
		int parent = -1;
		if (this.limits.canManageProductList())
		{
			Connection con = DBManager.getConnection();
			if (con!=null)
			{
				try {
					PreparedStatement sm = con.prepareStatement("select parent from product_catalog where id=?");
					sm.setInt(1, id);
					ResultSet rs = sm.executeQuery();
					if (rs.next())
					{
						parent = rs.getInt(1);
					}
					rs.close();
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
		}
		return parent;
	}
	
	/**
	 * 调整顺序
	 * @return
	 */
	public boolean placeAfter(int pid,int sid,int tid)
	{
		boolean status = false;
		if (this.limits.canManageProductList())
		{
			Connection con = DBManager.getConnection();
			if (con!=null)
			{
				try {
					con.setAutoCommit(false);
					Vector<Integer> brothers = new Vector<Integer>();
					if (pid<=0)
					{
						PreparedStatement sm = con.prepareStatement("select id from product_catalog where parent is null order by priority");
						ResultSet rs = sm.executeQuery();
						while (rs.next())
						{
							brothers.add(rs.getInt(1));
						}
						rs.close();
						sm.close();
					}
					else
					{
						PreparedStatement sm = con.prepareStatement("select id from product_catalog where parent=? order by priority");
						sm.setInt(1, pid);
						ResultSet rs = sm.executeQuery();
						while (rs.next())
						{
							brothers.add(rs.getInt(1));
						}
						rs.close();
						sm.close();
					}
					
					boolean removed = false;
					int size = brothers.size();
					for (int i=0;i<size;i++)
					{
						if (brothers.get(i).intValue()==sid)
						{
							brothers.remove(i);
							removed = true;
							break;
						}
					}
					boolean inserted = false;
					if (removed)
					{
						size--;
						for (int i=0;i<size;i++)
						{
							if (brothers.get(i).intValue()==tid)
							{
								brothers.insertElementAt(new Integer(sid), i+1);
								inserted = true;
								break;
							}
						}
					}
					if (inserted)
					{
						status = true;
						PreparedStatement sm = con.prepareStatement("update product_catalog set priority=? where id=?");
						size++;
						for (int i=0;i<size;i++)
						{
							sm.setInt(1, i+1);
							sm.setInt(2, brothers.get(i));
							if (sm.executeUpdate()!=1)
							{
								status = false;
								break;
							}
						}
						sm.close();
						if (status)
						{
							con.commit();
						}
						else
						{
							con.rollback();
						}
					}
					else
					{
						con.rollback();
					}
				} catch (SQLException e) {
					e.printStackTrace();
					try {
						con.rollback();
					} catch (SQLException e1) {
						e1.printStackTrace();
					}
				} finally {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
		return status;
	}
	
	/**
	 * 删除产品类型
	 * @return
	 */
	public int deleteProductCatalog(int id)
	{
		int status = -1;
		if (this.limits.canManageProductList())
		{
			Connection con = DBManager.getConnection();
			if (con!=null)
			{
				try {
					con.setAutoCommit(false);
					Statement sm = con.createStatement();
					ResultSet rs = sm.executeQuery("select count(*) from product_catalog where parent="+id);
					int count = 0;
					if (rs.next())
					{
						count = rs.getInt(1);
					}
					rs.close();
					sm.close();

					String name = "";
					if (count>0)
					{
						status = 2;
					}
					else
					{
						sm = con.createStatement();
						rs = sm.executeQuery("select name from product_catalog where id="+id);
						if (rs.next())
						{
							name = rs.getString(1);
						}
						rs.close();
						sm.close();
						
						sm = con.createStatement();
						if (sm.executeUpdate("delete from product_catalog where type=0 and id="+id)==1)
						{
							status = 0;
						}
						sm.close();
					}
					if (status!=0)
					{
						con.rollback();
					}
					else
					{
						con.commit();

						Action action = new Action();
						action.setActioner(this.name);
						action.setType(ActionType.TYPES[9].getValue());
						action.setTarget(name);
						action.setTime(java.util.Calendar.getInstance().getTime());
						
						Loger.log(con,action);
					}
				} catch (SQLException e) {
					e.printStackTrace();
					try {
						con.rollback();
					} catch (SQLException e1) {
						e1.printStackTrace();
					}
				} finally {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
		else
		{
			status = 1;
		}
		return status;
	}
	
	public int toggleProductCatalogState(int id)
	{
		int status = -1;
		if (this.limits.canManageProductList())
		{
			Connection con = DBManager.getConnection();
			if (con!=null)
			{
				try {
					con.setAutoCommit(false);
					Statement sm = con.createStatement();
					ResultSet rs = sm.executeQuery("select opened from product_catalog where type=0 and id="+id);
					int opened = -1;
					if (rs.next())
					{
						opened = rs.getInt(1);
					}
					rs.close();
					sm.close();
					if (opened<0)
					{
						status = 2;//id不存在或者不是目录
					}
					else
					{
						sm = con.createStatement();
						if (sm.executeUpdate("update product_catalog set opened="+(opened==0?1:0)+" where id="+id)==1)
						{
							status = 0;//状态是关闭
						}
						sm.close();
					}
					if (status!=0)
					{
						con.rollback();
					}
					else
					{
						con.commit();
						if (opened==0)
						{
							status = 3;//状态是打开
						}
					}
				} catch (SQLException e) {
					e.printStackTrace();
					try {
						con.rollback();
					} catch (SQLException e1) {
						e1.printStackTrace();
					}
				} finally {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
		else
		{
			status = 1;
		}
		return status;
	}
	
	private static String getProductKeyword(Connection con,int id)
	{
		StringBuffer keyword = new StringBuffer();
		if (con!=null)
		{
			try {
				PreparedStatement sm = con.prepareStatement("select name,parent from product_catalog where id=?");
				while (id>0)
				{
					sm.setInt(1, id);
					ResultSet rs = sm.executeQuery();
					if (rs.next())
					{
						keyword.append(rs.getString(1)+" ");
						id = rs.getInt(2);
						rs.close();
					}
					else
					{
						rs.close();
						break;
					}
				}
				sm.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return keyword.toString();
	}
	
	public int addProduct(String name,int parentId,String features,String imgPath,String contentPath,String date,boolean isPromoted,boolean isOnHomepage)
	{
		int status = -1;
		if (this.limits.canAddProduct()&&name!=null&&imgPath!=null&&contentPath!=null&&date!=null&&features!=null)
		{
			Connection con = DBManager.getConnection();
			if (con!=null)
			{
				try {
					con.setAutoCommit(false);
					int id = -1;
					PreparedStatement sm = con.prepareStatement("insert into product(features,path,img_path,is_strongly_promoted,is_on_homepage,produce_date) values(?,?,?,?,?,?)");
					sm.setString(1, features);
					sm.setString(2, contentPath);
					sm.setString(3, imgPath);
					sm.setBoolean(4, isPromoted);
					sm.setBoolean(5, isOnHomepage);
					sm.setString(6, date);
					if (sm.executeUpdate()==1)
					{
						ResultSet rs = sm.getGeneratedKeys();
						if (rs.next())
						{
							id = rs.getInt(1);
						}
						rs.close();
					}
					sm.close();
					if (id>0)
					{
						int pcId = -1;
						if (parentId<=0)
						{
							Statement s = con.createStatement();
							ResultSet rs = s.executeQuery("select priority from product_catalog where parent is null order by priority desc");
							int priority = 1;
							if (rs.next())
							{
								priority = rs.getInt(1)+1;
							}
							rs.close();
							s.close();
							sm = con.prepareStatement("insert into product_catalog(name,priority,type,product) values(?,?,?,?)");
							sm.setString(1, name);
							sm.setInt(2, priority);
							sm.setInt(3, 2);
							sm.setInt(4, id);
							if (sm.executeUpdate()==1)
							{
								status = 0;
								rs = sm.getGeneratedKeys();
								if (rs.next())
								{
									pcId = rs.getInt(1);
								}
								rs.close();
							}
							else
							{
								status = 2;
							}
							sm.close();
						}
						else
						{
							Statement s = con.createStatement();
							ResultSet rs = s.executeQuery("select priority from product_catalog where parent="+parentId+" order by priority desc");
							int priority = 1;
							if (rs.next())
							{
								priority = rs.getInt(1)+1;
							}
							rs.close();
							s.close();
							sm = con.prepareStatement("insert into product_catalog(name,priority,type,product,parent) values(?,?,?,?,?)");
							sm.setString(1, name);
							sm.setInt(2, priority);
							sm.setInt(3, 2);
							sm.setInt(4, id);
							sm.setInt(5, parentId);
							if (sm.executeUpdate()==1)
							{
								status = 0;
								rs = sm.getGeneratedKeys();
								if (rs.next())
								{
									pcId = rs.getInt(1);
								}
								rs.close();
							}
							else
							{
								status = 2;
							}
							sm.close();
						}
						
						if (status==0)
						{
							sm = con.prepareStatement("update product set keyword=? where id=?");
							String keyword = User.getProductKeyword(con,pcId);
							sm.setString(1, keyword);
							sm.setInt(2, id);
							if (sm.executeUpdate()!=1)
							{
								status = 2;
							}
							sm.close();
						}
					}
					else
					{
						status = 2;
					}
					if (status!=0)
					{
						con.rollback();
					}
					else
					{
						con.commit();
						
						Action action = new Action();
						action.setActioner(this.name);
						action.setType(ActionType.TYPES[13].getValue());
						action.setTarget(name);
						action.setTime(java.util.Calendar.getInstance().getTime());
						
						Loger.log(con,action);
					}
				} catch (SQLException e) {
					e.printStackTrace();
					try {
						con.rollback();
					} catch (SQLException e1) {
						e1.printStackTrace();
					}
				} finally {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
		else
		{
			status = 1;
		}
		return status;
	}
	
	public int modifyProduct(int id, String name,int parentId,String features,String imgPath,String date,boolean isPromoted,boolean isOnHomepage)
	{
		int status = -1;
		if (this.limits.canModifyProduct()&&name!=null&&imgPath!=null&&date!=null&&id>0&&features!=null)
		{
			Connection con = DBManager.getConnection();
			if (con!=null)
			{
				try {
					con.setAutoCommit(false);
					if (parentId<=0)
					{
						PreparedStatement sm = con.prepareStatement("update product_catalog set name=?,parent=null where id=?");
						sm.setString(1, name);
						sm.setInt(2, id);
						if (sm.executeUpdate()==1)
						{
							status = 0;
						}
						else
						{
							status = 2;
						}
						sm.close();
					}
					else
					{
						PreparedStatement sm = con.prepareStatement("update product_catalog set name=?,parent=? where id=?");
						sm.setString(1, name);
						sm.setInt(2, parentId);
						sm.setInt(3, id);
						if (sm.executeUpdate()==1)
						{
							status = 0;
						}
						else
						{
							status = 2;
						}
						sm.close();
					}
					if (status==0)
					{
						int productId = -1;
						Statement s = con.createStatement();
						ResultSet rs = s.executeQuery("select product from product_catalog where id="+id);
						if (rs.next())
						{
							productId = rs.getInt(1);
						}
						rs.close();
						s.close();
						PreparedStatement sm = con.prepareStatement("update product set features=?,img_path=?,is_strongly_promoted=?,is_on_homepage=?,produce_date=? where id=?");
						sm.setString(1, features);
						sm.setString(2, imgPath);
						sm.setBoolean(3, isPromoted);
						sm.setBoolean(4, isOnHomepage);
						sm.setString(5, date);
						sm.setInt(6, productId);
						if (sm.executeUpdate()!=1)
						{
							status = 2;
						}
						sm.close();
						
						if (status==0)
						{
							sm = con.prepareStatement("update product set keyword=? where id=?");
							String keyword = User.getProductKeyword(con,id);
							sm.setString(1, keyword);
							sm.setInt(2, productId);
							if (sm.executeUpdate()!=1)
							{
								status = 2;
							}
							sm.close();
						}
					}
					if (status!=0)
					{
						con.rollback();
					}
					else
					{
						con.commit();

						Action action = new Action();
						action.setActioner(this.name);
						action.setType(ActionType.TYPES[14].getValue());
						action.setTarget(name);
						action.setTime(java.util.Calendar.getInstance().getTime());
						
						Loger.log(con,action);
//						
//						con = DBManager.getConnection();
//						con.setAutoCommit(false);
//						Statement s = con.createStatement();
//						ResultSet r = s.executeQuery("select id,product from product_catalog where type=2");
//						
//						PreparedStatement sm = con.prepareStatement("update product set keyword=? where id=?");
//						while (r.next())
//						{
//							String keyword = Product.getProductKeyword(r.getInt(1));
//							sm.setString(1, keyword);
//							sm.setInt(2, r.getInt(2));
//							if (sm.executeUpdate()!=1)
//							{
//								status = 2;
//								break;
//							}
//						}
//						sm.close();
//						
//						r.close();
//						s.close();
//						
//						if (status==0)
//						{
//							con.commit();
//						}
//						else
//						{
//							con.rollback();
//						}
					}
				} catch (SQLException e) {
					e.printStackTrace();
					try {
						con.rollback();
					} catch (SQLException e1) {
						e1.printStackTrace();
					}
				} finally {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
		else
		{
			status = 1;
		}
		return status;
	}
	
	public int addIntroductionInfo(String name,int parentId,String contentPath)
	{
		int status = -1;
		if (this.limits.canAddProduct()&&name!=null&&contentPath!=null)
		{
			Connection con = DBManager.getConnection();
			if (con!=null)
			{
				try {
					con.setAutoCommit(false);
					int id = -1;
					PreparedStatement sm = con.prepareStatement("insert into introduction(path) values(?)");
					sm.setString(1, contentPath);
					if (sm.executeUpdate()==1)
					{
						ResultSet rs = sm.getGeneratedKeys();
						if (rs.next())
						{
							id = rs.getInt(1);
						}
						rs.close();
					}
					sm.close();
					if (id>0)
					{
						if (parentId<=0)
						{
							Statement s = con.createStatement();
							ResultSet rs = s.executeQuery("select priority from product_catalog where parent is null order by priority desc");
							int priority = 1;
							if (rs.next())
							{
								priority = rs.getInt(1)+1;
							}
							rs.close();
							s.close();
							sm = con.prepareStatement("insert into product_catalog(name,priority,type,normal) values(?,?,?,?)");
							sm.setString(1, name);
							sm.setInt(2, priority);
							sm.setInt(3, 1);
							sm.setInt(4, id);
							if (sm.executeUpdate()==1)
							{
								status = 0;
							}
							else
							{
								status = 2;
							}
							sm.close();
						}
						else
						{
							Statement s = con.createStatement();
							ResultSet rs = s.executeQuery("select priority from product_catalog where parent="+parentId+" order by priority desc");
							int priority = 1;
							if (rs.next())
							{
								priority = rs.getInt(1)+1;
							}
							rs.close();
							s.close();
							sm = con.prepareStatement("insert into product_catalog(name,priority,type,normal,parent) values(?,?,?,?,?)");
							sm.setString(1, name);
							sm.setInt(2, priority);
							sm.setInt(3, 1);
							sm.setInt(4, id);
							sm.setInt(5, parentId);
							if (sm.executeUpdate()==1)
							{
								status = 0;
							}
							else
							{
								status = 2;
							}
							sm.close();
						}
					}
					else
					{
						status = 2;
					}
					if (status!=0)
					{
						con.rollback();
					}
					else
					{
						con.commit();

						Action action = new Action();
						action.setActioner(this.name);
						action.setType(ActionType.TYPES[10].getValue());
						action.setTarget(name);
						action.setTime(java.util.Calendar.getInstance().getTime());
						
						Loger.log(con,action);
					}
				} catch (SQLException e) {
					e.printStackTrace();
					try {
						con.rollback();
					} catch (SQLException e1) {
						e1.printStackTrace();
					}
				} finally {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
		else
		{
			status = 1;
		}
		return status;
	}
	
	/**
	 * 删除产品
	 * @return
	 */
	public int deleteProduct(int id)
	{
		int status = -1;
		if (this.limits.canDeleteProduct())
		{
			Connection con = DBManager.getConnection();
			if (con!=null)
			{
				try {
					con.setAutoCommit(false);
					Statement sm = con.createStatement();
					ResultSet rs = sm.executeQuery("select name,product from product_catalog where type=2 and id="+id);
					String name = "";
					int productId = 0;
					if (rs.next())
					{
						name = rs.getString(1);
						productId = rs.getInt(2);
					}
					rs.close();
					sm.close();
					
					if (productId<=0)
					{
						status = 2;
					}
					else
					{
						sm = con.createStatement();
						if (sm.executeUpdate("delete from product_catalog where id="+id)==1)
						{
							status = 0;
						}
						else
						{
							status = 2;
						}
						sm.close();
						if (status==0)
						{
							sm = con.createStatement();
							if (sm.executeUpdate("delete from product where id="+productId)==1)
							{
								status = 0;
							}
							else
							{
								status = 2;
							}
							sm.close();
						}
					}
					if (status!=0)
					{
						con.rollback();
					}
					else
					{
						con.commit();
						
						Action action = new Action();
						action.setActioner(this.name);
						action.setType(ActionType.TYPES[15].getValue());
						action.setTarget(name);
						action.setTime(java.util.Calendar.getInstance().getTime());
						
						Loger.log(con,action);
					}
				} catch (SQLException e) {
					e.printStackTrace();
					try {
						con.rollback();
					} catch (SQLException e1) {
						e1.printStackTrace();
					}
				} finally {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
		else
		{
			status = 1;
		}
		return status;
	}
	
	/**
	 * 删除信息
	 * @return
	 */
	public int deleteIntroductionInfo(int id)
	{
		int status = -1;
		if (this.limits.canDeleteProduct())
		{
			Connection con = DBManager.getConnection();
			if (con!=null)
			{
				try {
					con.setAutoCommit(false);
					Statement sm = con.createStatement();
					ResultSet rs = sm.executeQuery("select name,normal from product_catalog where type=1 and id="+id);
					String name = "";
					int infoId = 0;
					if (rs.next())
					{
						name = rs.getString(1);
						infoId = rs.getInt(2);
					}
					rs.close();
					sm.close();
					
					if (infoId<=0)
					{
						status = 2;
					}
					else
					{
						sm = con.createStatement();
						if (sm.executeUpdate("delete from product_catalog where id="+id)==1)
						{
							status = 0;
						}
						else
						{
							status = 2;
						}
						sm.close();
						if (status==0)
						{
							sm = con.createStatement();
							if (sm.executeUpdate("delete from introduction where id="+infoId)==1)
							{
								status = 0;
							}
							else
							{
								status = 2;
							}
							sm.close();
						}
					}
					if (status!=0)
					{
						con.rollback();
					}
					else
					{
						con.commit();

						Action action = new Action();
						action.setActioner(this.name);
						action.setType(ActionType.TYPES[12].getValue());
						action.setTarget(name);
						action.setTime(java.util.Calendar.getInstance().getTime());
						
						Loger.log(con,action);
					}
				} catch (SQLException e) {
					e.printStackTrace();
					try {
						con.rollback();
					} catch (SQLException e1) {
						e1.printStackTrace();
					}
				} finally {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
		else
		{
			status = 1;
		}
		return status;
	}
	
	public int modifyIntroduction(int id, String name,int parentId)
	{
		int status = -1;
		if (this.limits.canModifyProduct()&&name!=null&&id>0)
		{
			Connection con = DBManager.getConnection();
			if (con!=null)
			{
				try {
					con.setAutoCommit(false);
					if (parentId<=0)
					{
						PreparedStatement sm = con.prepareStatement("update product_catalog set name=?,parent=null where id=?");
						sm.setString(1, name);
						sm.setInt(2, id);
						if (sm.executeUpdate()==1)
						{
							status = 0;
						}
						else
						{
							status = 2;
						}
						sm.close();
					}
					else
					{
						PreparedStatement sm = con.prepareStatement("update product_catalog set name=?,parent=? where id=?");
						sm.setString(1, name);
						sm.setInt(2, parentId);
						sm.setInt(3, id);
						if (sm.executeUpdate()==1)
						{
							status = 0;
						}
						else
						{
							status = 2;
						}
						sm.close();
					}
					if (status!=0)
					{
						con.rollback();
					}
					else
					{
						con.commit();

						Action action = new Action();
						action.setActioner(this.name);
						action.setType(ActionType.TYPES[11].getValue());
						action.setTarget(name);
						action.setTime(java.util.Calendar.getInstance().getTime());
						
						Loger.log(con,action);
					}
				} catch (SQLException e) {
					e.printStackTrace();
					try {
						con.rollback();
					} catch (SQLException e1) {
						e1.printStackTrace();
					}
				} finally {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
		else
		{
			status = 1;
		}
		return status;
	}
	
	public int addAchievement(String dest,String date,int type,Vector<Object[]> orders)
	{
		int status = -1;
		if (this.limits.canAddAchievement()&&dest!=null&&date!=null&&orders!=null&&orders.size()>0&&type>0)
		{
			Connection con = DBManager.getConnection();
			if (con!=null)
			{
				try {
					con.setAutoCommit(false);
					PreparedStatement sm = con.prepareStatement("insert into achievements(deal_time,distribution,belongs_to) values(?,?,?)");
					sm.setString(1, date);
					sm.setString(2, dest);
					sm.setInt(3, type);
					int id = -1;
					if (sm.executeUpdate()==1)
					{
						ResultSet rs = sm.getGeneratedKeys();
						if (rs.next())
						{
							id = rs.getInt(1);
							status = 0;
						}
						else
						{
							status = 2;
						}
						rs.close();
					}
					else
					{
						status = 2;
					}
					sm.close();
					if (status==0)
					{
						PreparedStatement psm = con.prepareStatement("insert into orders(belongs_to,product,quantity,model) values(?,?,?,?)");
						int size = orders.size();
						for (int i=0;i<size;i++)
						{
							Object[] objs = orders.get(i);
							psm.setInt(1, id);
							psm.setInt(2, (Integer)objs[0]);
							psm.setInt(3, (Integer)objs[1]);
							psm.setString(4, (String)objs[2]);
							if (psm.executeUpdate()!=1)
							{
								status = 2;
								break;
							}
						}
					}
					
					if (status!=0)
					{
						con.rollback();
					}
					else
					{
						con.commit();

						Action action = new Action();
						action.setActioner(this.name);
						action.setType(ActionType.TYPES[16].getValue());
						action.setTarget("目的地："+dest+"; 时间："+date);
						action.setTime(java.util.Calendar.getInstance().getTime());
						
						Loger.log(con,action);
					}
				} catch (SQLException e) {
					e.printStackTrace();
					try {
						con.rollback();
					} catch (SQLException e1) {
						e1.printStackTrace();
					}
				} finally {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
		else
		{
			status = 1;
		}
		return status;
	}
	
	public int modifyAchievement(int id,String dest,String date,int type,Vector<Object[]> orders)
	{
		int status = -1;
		if (this.limits.canModifyAchievement()&&dest!=null&&date!=null&&orders!=null&&orders.size()>0&&type>0&&id>0)
		{
			Connection con = DBManager.getConnection();
			if (con!=null)
			{
				try {
					con.setAutoCommit(false);
					PreparedStatement sm = con.prepareStatement("update achievements set deal_time=?,distribution=?,belongs_to=? where id=?");
					sm.setString(1, date);
					sm.setString(2, dest);
					sm.setInt(3, type);
					sm.setInt(4, id);
					if (sm.executeUpdate()==1)
					{
						status = 0;
					}
					else
					{
						status = 2;
					}
					sm.close();
					if (status==0)
					{
						Statement s = con.createStatement();
						s.executeUpdate("delete from orders where belongs_to="+id);
						s.close();
						
						PreparedStatement psm = con.prepareStatement("insert into orders(belongs_to,product,quantity,model) values(?,?,?,?)");
						int size = orders.size();
						for (int i=0;i<size;i++)
						{
							Object[] objs = orders.get(i);
							psm.setInt(1, id);
							psm.setInt(2, (Integer)objs[0]);
							psm.setInt(3, (Integer)objs[1]);
							psm.setString(4, (String)objs[2]);
							if (psm.executeUpdate()!=1)
							{
								status = 2;
								break;
							}
						}
					}
					
					if (status!=0)
					{
						con.rollback();
					}
					else
					{
						con.commit();

						Action action = new Action();
						action.setActioner(this.name);
						action.setType(ActionType.TYPES[17].getValue());
						action.setTarget("目的地："+dest+"; 时间："+date);
						action.setTime(java.util.Calendar.getInstance().getTime());
						
						Loger.log(con,action);
					}
				} catch (SQLException e) {
					e.printStackTrace();
					try {
						con.rollback();
					} catch (SQLException e1) {
						e1.printStackTrace();
					}
				} finally {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
		else
		{
			status = 1;
		}
		return status;
	}
	
	public int deleteAchievement(int id)
	{
		int status = -1;
		if (this.limits.canDeleteAchievement()&&id>0)
		{
			Connection con = DBManager.getConnection();
			if (con!=null)
			{
				try {
					con.setAutoCommit(false);
					Statement sm = con.createStatement();
					ResultSet rs = sm.executeQuery("select distribution, deal_time from achievements where id="+id);
					String dest = "";
					String date = "";
					if (rs.next())
					{
						dest = rs.getString(1);
						date = rs.getString(2);
					}
					rs.close();
					sm.close();
					
					sm = con.createStatement();
					sm.executeUpdate("delete from orders where belongs_to="+id);
					sm.close();
					
					sm = con.createStatement();
					if (sm.executeUpdate("delete from achievements where id="+id)==1)
					{
						status = 0;
					}
					sm.close();
					
					if (status!=0)
					{
						con.rollback();
					}
					else
					{
						con.commit();

						Action action = new Action();
						action.setActioner(this.name);
						action.setType(ActionType.TYPES[18].getValue());
						action.setTarget("目的地："+dest+"; 时间："+date);
						action.setTime(java.util.Calendar.getInstance().getTime());
						
						Loger.log(con,action);
					}
				} catch (SQLException e) {
					e.printStackTrace();
					try {
						con.rollback();
					} catch (SQLException e1) {
						e1.printStackTrace();
					}
				} finally {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
		else
		{
			status = 1;
		}
		return status;
	}
	
	public int answerFeedback(int id,String answerPath,String answerTime)
	{
		int status = -1;
		if (this.limits.canAnswerFeedback()&&id>0&&answerPath!=null&&answerTime!=null)
		{
			Connection con = DBManager.getConnection();
			if (con!=null)
			{
				try {
					Statement s = con.createStatement();
					ResultSet rs = s.executeQuery("select ip,submit_time from feedback where id="+id);
					String ip = "";
					String submitTime = "";
					if (rs.next())
					{
						ip = rs.getString(1);
						submitTime = rs.getString(2);
					}
					rs.close();
					s.close();
					
					PreparedStatement sm = con.prepareStatement("update feedback set hidden=?,answer=?, answer_time=? where id=?");
					sm.setBoolean(1, false);
					sm.setString(2, answerPath);
					sm.setString(3, answerTime);
					sm.setInt(4, id);
					if (sm.executeUpdate()==1)
					{
						status = 0;
					}
					else
					{
						status = 2;
					}
					sm.close();
					
					if (status==0)
					{
						Action action = new Action();
						action.setActioner(this.name);
						action.setType(ActionType.TYPES[20].getValue());
						action.setTarget("来自："+ip+"; 时间："+submitTime);
						action.setTime(java.util.Calendar.getInstance().getTime());
						
						Loger.log(con,action);
					}
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
		}
		else
		{
			status = 1;
		}
		return status;
	}
	
	public int hiddenFeedback(int id)
	{
		int status = -1;
		if (this.limits.canAnswerFeedback()&&id>0)
		{
			Connection con = DBManager.getConnection();
			if (con!=null)
			{
				try {
					Statement s = con.createStatement();
					ResultSet rs = s.executeQuery("select ip,submit_time from feedback where id="+id);
					String ip = "";
					String submitTime = "";
					if (rs.next())
					{
						ip = rs.getString(1);
						submitTime = rs.getString(2);
					}
					rs.close();
					s.close();
					
					Statement sm = con.createStatement();
					if (sm.executeUpdate("update feedback set hidden=1 where id="+id+" and answer is null")==1)
					{
						status = 0;
					}
					else
					{
						status = 2;
					}
					sm.close();
					
					if (status==0)
					{
						Action action = new Action();
						action.setActioner(this.name);
						action.setType(ActionType.TYPES[19].getValue());
						action.setTarget("来自："+ip+"; 时间："+submitTime);
						action.setTime(java.util.Calendar.getInstance().getTime());
						
						Loger.log(con,action);
					}
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
		}
		else
		{
			status = 1;
		}
		return status;
	}
	
	public int deleteFeedback(int id)
	{
		int status = -1;
		if (this.limits.canDeleteFeedback()&&id>0)
		{
			Connection con = DBManager.getConnection();
			if (con!=null)
			{
				try {
					Statement s = con.createStatement();
					ResultSet rs = s.executeQuery("select ip,submit_time from feedback where id="+id);
					String ip = "";
					String submitTime = "";
					if (rs.next())
					{
						ip = rs.getString(1);
						submitTime = rs.getString(2);
					}
					rs.close();
					s.close();
					
					Statement sm = con.createStatement();
					if (sm.executeUpdate("delete from feedback where id="+id)==1)
					{
						status = 0;
					}
					else
					{
						status = 2;
					}
					sm.close();
					
					if (status==0)
					{
						Action action = new Action();
						action.setActioner(this.name);
						action.setType(ActionType.TYPES[21].getValue());
						action.setTarget("来自："+ip+"; 时间："+submitTime);
						action.setTime(java.util.Calendar.getInstance().getTime());
						
						Loger.log(con,action);
					}
				} catch (SQLException e) {
					e.printStackTrace();
					try {
						con.rollback();
					} catch (SQLException e1) {
						e1.printStackTrace();
					}
				} finally {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
		else
		{
			status = 1;
		}
		return status;
	}
	
	public Vector<Action> getAction(String actioner,String start,String end)
	{
		Vector<Action> actions = new Vector<Action>();
		if (this.limits.canSupervise())
		{
			Connection con = DBManager.getConnection();
			if (con!=null)
			{
				try {
					PreparedStatement s = con.prepareStatement("select target,action_time from loger where actioner=? and action_time between ? and ? order by action_time desc");
					s.setString(1,actioner);
					s.setString(2, start);
					s.setString(3, end);
					ResultSet rs = s.executeQuery();
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					while (rs.next())
					{
						Action action = new Action();
						action.setTarget(rs.getString(1));
						try {
							action.setTime(sdf.parse(rs.getString(2)));
						} catch (ParseException e) {}
						actions.add(action);
					}
					rs.close();
					s.close();
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
		}
		return actions;
	}
	
	public Vector<VisitInfo> getVisitors(String start,String end,int type,int nums)
	{
		Vector<VisitInfo> visitors = new Vector<VisitInfo>();
		if (this.limits.canViewVisitors())
		{
			Connection con = DBManager.getConnection();
			if (con!=null)
			{
				try {
					String sql = "select ip,english,count(*) as c from ip_loger where time between ? and ? ";
					if (type==0)
					{
						sql += "and english=1 ";
					}
					else if (type==1)
					{
						sql += "and english=0 ";
					}
					sql += "group by ip having c>? order by c desc";
					PreparedStatement s = con.prepareStatement(sql);
					s.setString(1, start);
					s.setString(2, end);
					s.setInt(3, nums);
					ResultSet rs = s.executeQuery();
					while (rs.next())
					{
						VisitInfo info = new VisitInfo(VisitInfo.getStrFromInnercode(rs.getLong(1)),rs.getInt(3),null,rs.getBoolean(2));
						visitors.add(info);
					}
					rs.close();
					s.close();
					s = con.prepareStatement("select addr from ip_addr where ? between ip_low and ip_high");
					int size = visitors.size();
					for (int i=0;i<size;i++)
					{
						long code = VisitInfo.getInnerCode(visitors.get(i).getIp());
						s.setLong(1, code);
						ResultSet rss = s.executeQuery();
						if (rss.next())
						{
							visitors.get(i).setFrom(rss.getString(1));
						}
						else
						{
							visitors.get(i).setFrom("请到网上查询该IP！");
						}
						rss.close();
					}
					s.close();
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
		}
		return visitors;
	}
}
