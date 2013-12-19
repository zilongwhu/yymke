package liftingmagnet.com.servlet;

public class CheckHelper {
	private static String emailChars = "abcdefghigklmnopqrstuvwxyz_.0123456789";
	
	/**
	 * �绰�����ʽ��+Country/RegionCode(AreaCode)SubscriberNumber
	 * +
	 * 		�����ú�����Ϲ淶�ĵ�ַ��ʽ��
	 * ���ң�����������
	 * 		��ʶ�绰����Ĺ��ң��������ı�׼���ң����������롣�������� 0 �� 9 ��һλ���λ���֡� ����֮���ǿո�ָ��Ĺ��ң����������롣
	 * �����ţ�
	 * 		�绰��������Ż���д��롣����ܰ���һ�������� 0 �� 9 �����֣���������д������Բ�����С��Բ�ʹ�õ�������д���Ĺ��ң�����������ʡ�Ը������
	 * ������
	 * 		�绰�������롣������� 0 �� 9 ��һ���������֡���ʽ���ַ��򲦺ſ����ַ���
	 * 			A a B b C c D d P p T t W w * # ! @ $ ?
	 * 		�����Ų�Ӧ�ð��������ַ���
	 * 			( ) ^
	 * 		�ڶ������ڵĸ�ʽ���ַ�ͨ���ǿո񡢾������ۺš�ʹ�ø�ʽ���ַ�ʹ�绰���������Ķ�����Ϊ TAPI �������ǣ�������ǲ�Ӱ�첦�š�
	 */
	
	public static boolean checkPhoneValid(String phone)
	{
		if (phone==null||(phone=phone.trim()).length()==0)
		{
			return false;
		}
		int len = phone.length();
		for (int i=0;i<len;i++)
		{
			char ch = phone.charAt(i);
			switch (ch)
			{
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
			case '-':
			case ' ':
				break;
			default:
				return false;
			}
		}
		if (phone.charAt(0)=='-'||phone.charAt(len-1)=='-')
		{
			return false;
		}
		return true;
	}
	
	public static boolean checkPostcodeValid(String postcode)
	{
		if (postcode==null||(postcode=postcode.trim()).length()==0)
		{
			return false;
		}
		int len = postcode.length();
		if (len!=6)
		{
			return false;
		}
		for (int i=0;i<len;i++)
		{
			char ch = postcode.charAt(i);
			switch (ch)
			{
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
				break;
			default:
				return false;
			}
		}
		return true;
	}
	
	public static boolean checkEmailValid(String email)
	{
		if (email==null||(email=email.trim().toLowerCase()).length()==0)
		{
			return false;
		}
		int split = email.indexOf('@');
		if (split<=0||split==email.length()-1)
		{
			return false;
		}
		
		String name = email.substring(0,split);
		String server = email.substring(split+1);
		
		int len = name.length();
		for (int i=0;i<len;i++)
		{
			if (emailChars.indexOf(name.charAt(i))<0)
			{
				return false;
			}
		}
		
		len = server.length();
		for (int i=0;i<len;i++)
		{
			if (emailChars.indexOf(server.charAt(i))<0)
			{
				return false;
			}
		}
		return true;
	}
}
