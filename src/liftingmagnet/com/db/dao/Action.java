package liftingmagnet.com.db.dao;

import java.util.Date;

public class Action {
	private int id;
	private String actioner;
	private long type;
	private String target;
	private Date time;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getActioner() {
		return actioner;
	}
	public void setActioner(String actioner) {
		this.actioner = actioner;
	}
	public long getType() {
		return type;
	}
	public void setType(long type) {
		this.type = type;
	}
	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
}
