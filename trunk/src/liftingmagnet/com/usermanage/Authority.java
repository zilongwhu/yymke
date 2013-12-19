package liftingmagnet.com.usermanage;

/**
 * 用户权限管理类
 * 创建时间： 2009-7-21 12:53
 * @author zzl
 */
public class Authority {
	private static int ADD_NEWS=1,MODIFY_NEWS=1<<1,DELETE_NEWS=1<<2,
						ADD_PRODUCT=1<<3,MODIFY_PRODUCT=1<<4,DELETE_PRODUCT=1<<5,
						ADD_ACHIEVEMENT=1<<6,MODIFY_ACHIEVEMENT=1<<7,DELETE_ACHIEVEMENT=1<<8,
						MANAGE_PRODUCT_LIST=1<<9,MANAGE_WORLDWIDE=1<<10,
						ANSWER_FEEDBACK=1<<11,DELETE_FEEDBACK=1<<12,
						MANAGE_CONTACT_INFO=1<<13,
						ADD_USER=1<<14,MODIFY_USER=1<<15,DELETE_USER=1<<16,
						SUPERVISE=1<<17,VIEW_VISITORS=1<<18;
	
	private int data;
	
	public Authority()
	{
		this.data = 0;
	}
	
	public Authority(int data)
	{
		this.data = data;
	}
	
	public int getData() {
		return data;
	}

	/**
	 * 新闻管理权限
	 */
	public boolean canAddNews()
	{
		return ( data & ADD_NEWS ) > 0;
	}
	public void setAddNews(boolean flag)
	{
		if (flag)
		{
			data |= ADD_NEWS;
		}
		else
		{
			data &= ~ADD_NEWS;
		}
	}
	public boolean canModifyNews()
	{
		return ( data & MODIFY_NEWS ) > 0;
	}
	public void setModifyNews(boolean flag)
	{
		if (flag)
		{
			data |= MODIFY_NEWS;
		}
		else
		{
			data &= ~MODIFY_NEWS;
		}
	}
	public boolean canDeleteNews()
	{
		return ( data & DELETE_NEWS ) > 0;
	}
	public void setDeleteNews(boolean flag)
	{
		if (flag)
		{
			data |= DELETE_NEWS;
		}
		else
		{
			data &= ~DELETE_NEWS;
		}
	}
	
	/**
	 * 产品管理权限
	 */
	public boolean canAddProduct()
	{
		return ( data & ADD_PRODUCT ) > 0;
	}
	public void setAddProduct(boolean flag)
	{
		if (flag)
		{
			data |= ADD_PRODUCT;
		}
		else
		{
			data &= ~ADD_PRODUCT;
		}
	}
	public boolean canModifyProduct()
	{
		return ( data & MODIFY_PRODUCT ) > 0;
	}
	public void setModifyProduct(boolean flag)
	{
		if (flag)
		{
			data |= MODIFY_PRODUCT;
		}
		else
		{
			data &= ~MODIFY_PRODUCT;
		}
	}
	public boolean canDeleteProduct()
	{
		return ( data & DELETE_PRODUCT ) > 0;
	}
	public void setDeleteProduct(boolean flag)
	{
		if (flag)
		{
			data |= DELETE_PRODUCT;
		}
		else
		{
			data &= ~DELETE_PRODUCT;
		}
	}

	/**
	 * 公司业绩管理权限
	 */
	public boolean canAddAchievement()
	{
		return ( data & ADD_ACHIEVEMENT ) > 0;
	}
	public void setAddAchievement(boolean flag)
	{
		if (flag)
		{
			data |= ADD_ACHIEVEMENT;
		}
		else
		{
			data &= ~ADD_ACHIEVEMENT;
		}
	}
	public boolean canModifyAchievement()
	{
		return ( data & MODIFY_ACHIEVEMENT ) > 0;
	}
	public void setModifyAchievement(boolean flag)
	{
		if (flag)
		{
			data |= MODIFY_ACHIEVEMENT;
		}
		else
		{
			data &= ~MODIFY_ACHIEVEMENT;
		}
	}
	public boolean canDeleteAchievement()
	{
		return ( data & DELETE_ACHIEVEMENT ) > 0;
	}
	public void setDeleteAchievement(boolean flag)
	{
		if (flag)
		{
			data |= DELETE_ACHIEVEMENT;
		}
		else
		{
			data &= ~DELETE_ACHIEVEMENT;
		}
	}
	
	/**
	 * 产品列表管理权限（包括添加、删除、修改、管理顺序等）
	 */
	public boolean canManageProductList()
	{
		return ( data & MANAGE_PRODUCT_LIST ) > 0;
	}
	public void setManageProductList(boolean flag)
	{
		if (flag)
		{
			data |= MANAGE_PRODUCT_LIST;
		}
		else
		{
			data &= ~MANAGE_PRODUCT_LIST;
		}
	}
	
	/**
	 * 代理商管理权限
	 */
	public boolean canManageWorldwide()
	{
		return ( data & MANAGE_WORLDWIDE ) > 0;
	}
	public void setManageWorldwide(boolean flag)
	{
		if (flag)
		{
			data |= MANAGE_WORLDWIDE;
		}
		else
		{
			data &= ~MANAGE_WORLDWIDE;
		}
	}
	
	/**
	 * 用户反馈信息管理权限
	 */
	public boolean canAnswerFeedback()
	{
		return ( data & ANSWER_FEEDBACK ) > 0;
	}
	public void setAnswerFeedback(boolean flag)
	{
		if (flag)
		{
			data |= ANSWER_FEEDBACK;
		}
		else
		{
			data &= ~ANSWER_FEEDBACK;
		}
	}
	public boolean canDeleteFeedback()
	{
		return ( data & DELETE_FEEDBACK ) > 0;
	}
	public void setDeleteFeedback(boolean flag)
	{
		if (flag)
		{
			data |= DELETE_FEEDBACK;
		}
		else
		{
			data &= ~DELETE_FEEDBACK;
		}
	}
	
	/**
	 * 公司联系方式管理权限
	 */
	public boolean canManageContactInfo()
	{
		return ( data & MANAGE_CONTACT_INFO ) > 0;
	}
	public void setManageContactInfo(boolean flag)
	{
		if (flag)
		{
			data |= MANAGE_CONTACT_INFO;
		}
		else
		{
			data &= ~MANAGE_CONTACT_INFO;
		}
	}
	
	/**
	 * 管理员工权限
	 */
	public boolean canAddUser()
	{
		return ( data & ADD_USER ) > 0;
	}
	public void setAddUser(boolean flag)
	{
		if (flag)
		{
			data |= ADD_USER;
		}
		else
		{
			data &= ~ADD_USER;
		}
	}
	public boolean canModifyUser()
	{
		return ( data & MODIFY_USER ) > 0;
	}
	public void setModifyUser(boolean flag)
	{
		if (flag)
		{
			data |= MODIFY_USER;
		}
		else
		{
			data &= ~MODIFY_USER;
		}
	}
	public boolean canDeleteUser()
	{
		return ( data & DELETE_USER ) > 0;
	}
	public void setDeleteUser(boolean flag)
	{
		if (flag)
		{
			data |= DELETE_USER;
		}
		else
		{
			data &= ~DELETE_USER;
		}
	}
	
	/**
	 * 监督网站员工对网站的操作
	 */
	public boolean canSupervise()
	{
		return ( data & SUPERVISE ) > 0;
	}
	public void setSupervise(boolean flag)
	{
		if (flag)
		{
			data |= SUPERVISE;
		}
		else
		{
			data &= ~SUPERVISE;
		}
	}
	
	/**
	 * 监督网站访问记录
	 */
	public boolean canViewVisitors()
	{
		return ( data & VIEW_VISITORS ) > 0;
	}
	public void setViewVisitors(boolean flag)
	{
		if (flag)
		{
			data |= VIEW_VISITORS;
		}
		else
		{
			data &= ~VIEW_VISITORS;
		}
	}
}