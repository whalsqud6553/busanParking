package com.sideProject.repository;

import org.springframework.stereotype.Repository;

import com.sideProject.model.BusanParkingMemberDTO;

@Repository
public interface BusanParkingMemberDAO {

	int join(BusanParkingMemberDTO dto);

	BusanParkingMemberDTO selectById(String busanParking_Member_Id);

	BusanParkingMemberDTO selectByNickName(String member_nick);
	
}
