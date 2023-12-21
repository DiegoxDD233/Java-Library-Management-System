package entity;

import java.time.LocalDateTime;

public class ProblemDB {

	private Integer pid;
	private Integer uid;
	private String name;
	private String account;
	private String title;
	private String page;
	private String content;
	private String link;
	private Integer status;
	private LocalDateTime Time;
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	public Integer getUid() {
		return uid;
	}
	public void setUid(Integer uid) {
		this.uid = uid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public LocalDateTime getTime() {
		return Time;
	}
	public void setTime(LocalDateTime time) {
		Time = time;
	}
	@Override
	public String toString() {
		return "ProblemDB [pid=" + pid + ", uid=" + uid + ", name=" + name + ", account=" + account + ", title=" + title
				+ ", page=" + page + ", content=" + content + ", link=" + link + ", status=" + status + ", Time=" + Time
				+ "]";
	}
	
	
	
}
