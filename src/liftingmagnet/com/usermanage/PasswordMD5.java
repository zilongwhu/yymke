package liftingmagnet.com.usermanage;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class PasswordMD5 {
	
	public static byte[] encode(String password)
	{
		if (password==null)
		{
			return null;
		}
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(password.getBytes());
			return md.digest();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public static boolean isEqual(String password,byte[] data)
	{
		if (password==null)
		{
			return false;
		}
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(password.getBytes());
			return MessageDigest.isEqual(md.digest(),data);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			return false;
		}
	}
}
