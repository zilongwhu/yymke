package liftingmagnet.com.app;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;

public class ContactInfo implements Serializable{
	private static final long serialVersionUID = 2831268039315949782L;
	
	private static ContactInfo info = new ContactInfo();
	
	private String companyName;
	private String address;
	private String postcode;
	private String phone1;
	private String phone2;
	private String fax1;
	private String fax2;
	private String email;
	private String msn1;
	private String msn2;
	
	private ContactInfo()
	{
		companyName = "YUEYANG QIANGLI ELECTROMAGNET CO.,LTD";
		address = "(Jianshengqiao Village), Lengshuipu, Yueyang City, Hunan, China";
		postcode = "414000";
		phone1 = "0086-730-8638790";
		phone2 = "0086-730-8799058";
		fax1 = "0086-730-8628175";
		fax2 = "0086-730-8799009";
		email = "starwang@liftingmangnet.com.cn";
		msn1 = "wangxingming11287@hotmail.com";
		msn2 = "beauty.zhang@hotmail.com";
	}
	
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPostcode() {
		return postcode;
	}
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	public String getPhone1() {
		return phone1;
	}
	public void setPhone1(String phone1) {
		this.phone1 = phone1;
	}
	public String getPhone2() {
		return phone2;
	}
	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}
	public String getFax1() {
		return fax1;
	}
	public void setFax1(String fax1) {
		this.fax1 = fax1;
	}
	public String getFax2() {
		return fax2;
	}
	public void setFax2(String fax2) {
		this.fax2 = fax2;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMsn1() {
		return msn1;
	}
	public void setMsn1(String msn1) {
		this.msn1 = msn1;
	}
	public String getMsn2() {
		return msn2;
	}

	public void setMsn2(String msn2) {
		this.msn2 = msn2;
	}

	private void writeObject(ObjectOutputStream out)throws IOException
	{
		out.writeUTF(this.companyName);
		out.writeUTF(this.address);
		out.writeUTF(this.postcode);
		out.writeUTF(this.phone1);
		out.writeUTF(this.phone2);
		out.writeUTF(this.fax1);
		out.writeUTF(this.fax2);
		out.writeUTF(this.email);
		out.writeUTF(this.msn1);
		out.writeUTF(this.msn2);
	}
	
	private void readObject(ObjectInputStream in) throws IOException, ClassNotFoundException
	{
		 this.companyName = in.readUTF();
		 this.address = in.readUTF();
		 this.postcode = in.readUTF();
		 this.phone1 = in.readUTF();
		 this.phone2 = in.readUTF();
		 this.fax1 = in.readUTF();
		 this.fax2 = in.readUTF();
		 this.email = in.readUTF();
		 this.msn1 = in.readUTF();
		 this.msn2 = in.readUTF();
	}
	
	public static ContactInfo loadFromFile(String path)
	{
		try {
			ObjectInputStream in = new ObjectInputStream(new FileInputStream(path));
			ContactInfo info1 = (ContactInfo)in.readObject();
			info = info1;
			in.close();
		} catch (FileNotFoundException e) {
			//ok
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		return info;
	}
	
	public static void saveToFile(String path)
	{
		try {
			ObjectOutputStream out = new ObjectOutputStream(new FileOutputStream(path));
			out.writeObject(info);
			out.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
