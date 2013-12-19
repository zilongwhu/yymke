package liftingmagnet.com.db.dao;

public class ActionType {
	public static ActionType TYPES[] = {
		new ActionType(1<<0),//�û���¼
		new ActionType(1<<1),//�û��˳���¼
		new ActionType(1<<2),//�����Ա��
		new ActionType(1<<3),//�޸�Ա��Ȩ��
		new ActionType(1<<4),//ɾ��Ա��
		new ActionType(1<<5),//�������
		new ActionType(1<<6),//�޸�����
		new ActionType(1<<7),//ɾ������
		new ActionType(1<<8),//����²�Ʒ����
		new ActionType(1<<9),//ɾ����Ʒ����
		new ActionType(1<<10),//��ӽ�����Ϣ
		new ActionType(1<<11),//�޸Ľ�����Ϣ
		new ActionType(1<<12),//ɾ��������Ϣ
		new ActionType(1<<13),//����²�Ʒ
		new ActionType(1<<14),//�޸Ĳ�Ʒ��Ϣ
		new ActionType(1<<15),//ɾ����Ʒ��Ϣ
		new ActionType(1<<16),//���ҵ����
		new ActionType(1<<17),//�޸�ҵ����
		new ActionType(1<<18),//ɾ��ҵ����
		new ActionType(1<<19),//���οͻ�����
		new ActionType(1<<20),//�ظ��ͻ�����
		new ActionType(1<<21),//ɾ���ͻ�����
		new ActionType(1<<22),//��Ӵ�����
		new ActionType(1<<23),//ɾ��������
		new ActionType(1<<24)//�޸Ĺ�˾��ϵ��ʽ
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
			return "��¼";
		}
		if (value==TYPES[1].value)
		{
			return "�˳���¼";
		}
		if (value==TYPES[24].value)
		{
			return "�޸Ĺ�˾��ϵ��ʽ";
		}
		if (target==null)
		{
			return "";
		}
		if (value==TYPES[2].value)
		{
			return "�����Ա��{"+target+"}";
		}
		if (value==TYPES[3].value)
		{
			return "�޸�Ա��{"+target+"}��Ȩ��";
		}
		if (value==TYPES[4].value)
		{
			return "ɾ��Ա��{"+target+"}";
		}
		if (value==TYPES[5].value)
		{
			return "�������{"+target+"}";
		}
		if (value==TYPES[6].value)
		{
			return "�޸�����{"+target+"}";
		}
		if (value==TYPES[7].value)
		{
			return "ɾ������{"+target+"}";
		}
		if (value==TYPES[8].value)
		{
			return "����²�Ʒ����{"+target+"}";
		}
		if (value==TYPES[9].value)
		{
			return "ɾ����Ʒ����{"+target+"}";
		}
		if (value==TYPES[10].value)
		{
			return "��ӽ�����Ϣ{"+target+"}";
		}
		if (value==TYPES[11].value)
		{
			return "�޸Ľ�����Ϣ{"+target+"}";
		}
		if (value==TYPES[12].value)
		{
			return "ɾ��������Ϣ{"+target+"}";
		}
		if (value==TYPES[13].value)
		{
			return "����²�Ʒ{"+target+"}";
		}
		if (value==TYPES[14].value)
		{
			return "�޸Ĳ�Ʒ{"+target+"}����Ϣ";
		}
		if (value==TYPES[15].value)
		{
			return "ɾ����Ʒ{"+target+"}";
		}
		if (value==TYPES[16].value)
		{
			return "���ҵ����{"+target+"}";
		}
		if (value==TYPES[17].value)
		{
			return "�޸�ҵ����{"+target+"}";
		}
		if (value==TYPES[18].value)
		{
			return "ɾ��ҵ����{"+target+"}";
		}
		if (value==TYPES[19].value)
		{
			return "����{"+target+"}������";
		}
		if (value==TYPES[20].value)
		{
			return "�ظ�{"+target+"}������";
		}
		if (value==TYPES[21].value)
		{
			return "ɾ��{"+target+"}������";
		}
		if (value==TYPES[22].value)
		{
			return "���ȫ�������{"+target+"}";
		}
		if (value==TYPES[23].value)
		{
			return "ɾ��ȫ�������{"+target+"}";
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
