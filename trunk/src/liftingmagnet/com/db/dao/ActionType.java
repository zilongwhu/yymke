package liftingmagnet.com.db.dao;

public class ActionType {
	public static ActionType TYPES[] = {
		new ActionType(1<<0),//用户登录
		new ActionType(1<<1),//用户退出登录
		new ActionType(1<<2),//添加新员工
		new ActionType(1<<3),//修改员工权限
		new ActionType(1<<4),//删除员工
		new ActionType(1<<5),//添加新闻
		new ActionType(1<<6),//修改新闻
		new ActionType(1<<7),//删除新闻
		new ActionType(1<<8),//添加新产品类型
		new ActionType(1<<9),//删除产品类型
		new ActionType(1<<10),//添加介绍信息
		new ActionType(1<<11),//修改介绍信息
		new ActionType(1<<12),//删除介绍信息
		new ActionType(1<<13),//添加新产品
		new ActionType(1<<14),//修改产品信息
		new ActionType(1<<15),//删除产品信息
		new ActionType(1<<16),//添加业绩表
		new ActionType(1<<17),//修改业绩表
		new ActionType(1<<18),//删除业绩表
		new ActionType(1<<19),//屏蔽客户留言
		new ActionType(1<<20),//回复客户留言
		new ActionType(1<<21),//删除客户留言
		new ActionType(1<<22),//添加代理商
		new ActionType(1<<23),//删除代理商
		new ActionType(1<<24)//修改公司联系方式
	};
	
	private long value;

	private ActionType(long value) {
		super();
		this.value = value;
	}

	public long getValue() {
		return value;
	}
	
	public String transform(String target)
	{
		if (value==TYPES[0].value)
		{
			return "登录";
		}
		if (value==TYPES[1].value)
		{
			return "退出登录";
		}
		if (value==TYPES[24].value)
		{
			return "修改公司联系方式";
		}
		if (target==null)
		{
			return "";
		}
		if (value==TYPES[2].value)
		{
			return "添加新员工{"+target+"}";
		}
		if (value==TYPES[3].value)
		{
			return "修改员工{"+target+"}的权限";
		}
		if (value==TYPES[4].value)
		{
			return "删除员工{"+target+"}";
		}
		if (value==TYPES[5].value)
		{
			return "添加新闻{"+target+"}";
		}
		if (value==TYPES[6].value)
		{
			return "修改新闻{"+target+"}";
		}
		if (value==TYPES[7].value)
		{
			return "删除新闻{"+target+"}";
		}
		if (value==TYPES[8].value)
		{
			return "添加新产品类型{"+target+"}";
		}
		if (value==TYPES[9].value)
		{
			return "删除产品类型{"+target+"}";
		}
		if (value==TYPES[10].value)
		{
			return "添加介绍信息{"+target+"}";
		}
		if (value==TYPES[11].value)
		{
			return "修改介绍信息{"+target+"}";
		}
		if (value==TYPES[12].value)
		{
			return "删除介绍信息{"+target+"}";
		}
		if (value==TYPES[13].value)
		{
			return "添加新产品{"+target+"}";
		}
		if (value==TYPES[14].value)
		{
			return "修改产品{"+target+"}的信息";
		}
		if (value==TYPES[15].value)
		{
			return "删除产品{"+target+"}";
		}
		if (value==TYPES[16].value)
		{
			return "添加业绩表{"+target+"}";
		}
		if (value==TYPES[17].value)
		{
			return "修改业绩表{"+target+"}";
		}
		if (value==TYPES[18].value)
		{
			return "删除业绩表{"+target+"}";
		}
		if (value==TYPES[19].value)
		{
			return "屏蔽{"+target+"}的留言";
		}
		if (value==TYPES[20].value)
		{
			return "回复{"+target+"}的留言";
		}
		if (value==TYPES[21].value)
		{
			return "删除{"+target+"}的留言";
		}
		if (value==TYPES[22].value)
		{
			return "添加全球代理商{"+target+"}";
		}
		if (value==TYPES[23].value)
		{
			return "删除全球代理商{"+target+"}";
		}
		return "";
	}
	
	public static ActionType getActionType(long v)
	{
		for (int i=0;i<TYPES.length;i++)
		{
			if (v==TYPES[i].value)
			{
				return TYPES[i];
			}
		}
		return null;
	}
}
