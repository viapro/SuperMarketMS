package com.viapro.sm.bean;

import java.io.Serializable;

public class Provider implements Identify {
	private String address;
	private String contact;
	private String fax;
	private int id;
	private String proDesc;
	private String proName;
	private String tel;

	public Provider() {
		super();
	}

	public Provider(int id, String proName, String proDesc, String contact,
			String tel, String fax, String address) {
		super();
		this.id = id;
		this.proName = proName;
		this.proDesc = proDesc;
		this.contact = contact;
		this.tel = tel;
		this.fax = fax;
		this.address = address;
	}

	public String getAddress() {
		return address;
	}

	public String getContact() {
		return contact;
	}

	public String getFax() {
		return fax;
	}

	@Override
	public Serializable getId() {
		return id;
	}

	public String getProDesc() {
		return proDesc;
	}

	public String getProName() {
		return proName;
	}

	public String getTel() {
		return tel;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setProDesc(String proDesc) {
		this.proDesc = proDesc;
	}

	public void setProName(String proName) {
		this.proName = proName;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}
}
