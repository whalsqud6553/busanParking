package com.sideProject.model;

//busanParking_member_idx         number              default busanParking_Member_seq.nextval primary key,
//busanParking_member_id          varchar2(1000)      not null unique,
//busanParking_member_password    varchar2(1000)      not null,
//busanParking_member_salt        varchar2(1000)      not null,
//busanParking_member_nickname    varchar2(1000)      not null unique

public class BusanParkingMemberDTO {

	private int busanParking_Member_Idx;
	private String busanParking_Member_Id;
	private String busanParking_Member_Password;
	private String busanParking_Member_Salt;
	private String busanParking_Member_Nickname;
	
	public int getBusanParking_Member_Idx() {
		return busanParking_Member_Idx;
	}
	public void setBusanParking_Member_Idx(int busanParking_Member_Idx) {
		this.busanParking_Member_Idx = busanParking_Member_Idx;
	}
	public String getBusanParking_Member_Id() {
		return busanParking_Member_Id;
	}
	public void setBusanParking_Member_Id(String busanParking_Member_Id) {
		this.busanParking_Member_Id = busanParking_Member_Id;
	}
	public String getBusanParking_Member_Password() {
		return busanParking_Member_Password;
	}
	public void setBusanParking_Member_Password(String busanParking_Member_Password) {
		this.busanParking_Member_Password = busanParking_Member_Password;
	}
	public String getBusanParking_Member_Nickname() {
		return busanParking_Member_Nickname;
	}
	public void setBusanParking_Member_Nickname(String busanParking_Member_Nickname) {
		this.busanParking_Member_Nickname = busanParking_Member_Nickname;
	}
	public String getBusanParking_Member_Salt() {
		return busanParking_Member_Salt;
	}
	public void setBusanParking_Member_Salt(String busanParking_Member_Salt) {
		this.busanParking_Member_Salt = busanParking_Member_Salt;
	}
	
}
