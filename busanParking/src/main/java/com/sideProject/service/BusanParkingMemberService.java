package com.sideProject.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sideProject.component.HashComponent;
import com.sideProject.model.BusanParkingMemberDTO;
import com.sideProject.repository.BusanParkingMemberDAO;

@Service
public class BusanParkingMemberService {
	
	@Autowired
	private BusanParkingMemberDAO busanParkingDAO;
	@Autowired
	private HashComponent hashComponent;
	
	public int join(BusanParkingMemberDTO dto) {
		String salt = hashComponent.getSalt();
		String hash = hashComponent.getHash(dto.getBusanParking_Member_Password(), salt);
		dto.setBusanParking_Member_Salt(salt);
		dto.setBusanParking_Member_Password(hash);
		
		return busanParkingDAO.join(dto);
	}

	public BusanParkingMemberDTO login(BusanParkingMemberDTO dto) {
		BusanParkingMemberDTO login = busanParkingDAO.selectById(dto.getBusanParking_Member_Id());
		if(login != null) {
			String pw = hashComponent.getHash(dto.getBusanParking_Member_Password(), login.getBusanParking_Member_Salt());
			if(pw.equals(login.getBusanParking_Member_Password())) {
				return login;
			}
		}
		
		return null;
	}

	public BusanParkingMemberDTO idDuplicationCheck(String member_id) {
		BusanParkingMemberDTO dto = busanParkingDAO.selectById(member_id);
		return dto;
	}

	public BusanParkingMemberDTO nickDuplicationCheck(String member_nick) {
		BusanParkingMemberDTO dto = busanParkingDAO.selectByNickName(member_nick);
		return dto;
	}
	
	
}
