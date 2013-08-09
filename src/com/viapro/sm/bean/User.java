package com.viapro.sm.bean;

import java.io.Serializable;

public class User implements Identify, Serializable {
	private static final long serialVersionUID = 1L;

	private String address;
	private int gender;
	private int id;
	private String mobile;
	private String password;
	private int privilege;
	private String username;
	private int yob;

	public User() {
		super();
	}

	public User(String address, int gender, int id, String mobile,
			String password, int privilege, String username, int yob) {
		super();
		this.address = address;
		this.gender = gender;
		this.id = id;
		this.mobile = mobile;
		this.password = password;
		this.privilege = privilege;
		this.username = username;
		this.yob = yob;
	}

	public String getAddress() {
		return address;
	}

	public int getGender() {
		return gender;
	}

	@Override
	public Serializable getId() {
		return id;
	}

	public String getMobile() {
		return mobile;
	}

	public String getPassword() {
		return password;
	}

	public int getPrivilege() {
		return privilege;
	}

	public String getUsername() {
		return username;
	}

	public int getYob() {
		return yob;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public void setGender(int gender) {
		this.gender = gender;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public void setPrivilege(int privilege) {
		this.privilege = privilege;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public void setYob(int yob) {
		this.yob = yob;
	}
}
