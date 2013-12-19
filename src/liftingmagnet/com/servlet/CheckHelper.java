package liftingmagnet.com.servlet;

public class CheckHelper {
	private static String emailChars = "abcdefghigklmnopqrstuvwxyz_.0123456789";
	
	/**
	 * 电话号码格式：+Country/RegionCode(AreaCode)SubscriberNumber
	 * +
	 * 		表明该号码符合规范的地址格式。
	 * 国家（地区）代码
	 * 		标识电话号码的国家（地区）的标准国家（地区）代码。它包含从 0 到 9 的一位或多位数字。 数字之后是空格分隔的国家（地区）代码。
	 * （区号）
	 * 		电话号码的区号或城市代码。这可能包含一个或多个从 0 到 9 的数字，地区或城市代码放在圆括号中。对不使用地区或城市代码的国家（地区），则省略该组件。
	 * 订户号
	 * 		电话订户号码。这包含从 0 到 9 的一个或多个数字、格式化字符或拨号控制字符：
	 * 			A a B b C c D d P p T t W w * # ! @ $ ?
	 * 		订户号不应该包含以下字符：
	 * 			( ) ^
	 * 		在订户号内的格式化字符通常是空格、句点和破折号。使用格式化字符使电话号码易于阅读。因为 TAPI 忽略它们，因此它们不影响拨号。
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
