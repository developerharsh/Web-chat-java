package message;

import java.sql.Blob;

public class msg_model 
{
	private String sender;
	private String reciever;
	private String complaintid;
	private String text;
	private Blob attachments;
	private String att_name;
	private String datetime;
	private Integer count;
	private String sname;
	
	public String getAtt_name() {
		return att_name;
	}
	public void setAtt_name(String att_name) {
		this.att_name = att_name;
	}
	public String getSname() {
		return sname;
	}
	public void setSname(String sname) {
		this.sname = sname;
	}
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
	
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public String getReciever() {
		return reciever;
	}
	public void setReciever(String reciever) {
		this.reciever = reciever;
	}
	public String getComplaintid() {
		return complaintid;
	}
	public void setComplaintid(String complaintid) {
		this.complaintid = complaintid;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	
	
	
	public Blob getAttachments() {
		return attachments;
	}
	public void setAttachments(Blob attachments) {
		this.attachments = attachments;
	}
	public String getDatetime() {
		return datetime;
	}
	public void setDatetime(String datetime) {
		this.datetime = datetime;
	}
	


	
}