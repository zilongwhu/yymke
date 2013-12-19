package liftingmagnet.com.util;

public class StringHelper {
	public static String getFristNChars(String str,int n)
	{
		if (n<=3||str==null||str.length()<n)
		{
			return str;
		}
		else
		{
			return str.substring(0,n-3)+"...";
		}
	}
	
	public static String transform(String str,char s,String t)
	{
		if (str==null||t==null)
		{
			return str;
		}
		StringBuffer sb = new StringBuffer();
		int len = str.length();
		for (int i=0;i<len;i++)
		{
			char ch = str.charAt(i);
			if (ch==s)
			{
				sb.append(t);
			}
			else
			{
				sb.append(ch);
			}
		}
		return sb.toString();
	}
}
