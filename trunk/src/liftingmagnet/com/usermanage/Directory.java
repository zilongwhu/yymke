package liftingmagnet.com.usermanage;

public class Directory {
	private String path;
	private int id;
	private int parent;
	public Directory()
	{
		path = "/";
		id = 0;
		parent = -1;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getParent() {
		return parent;
	}
	public void setParent(int parent) {
		this.parent = parent;
	}
}
