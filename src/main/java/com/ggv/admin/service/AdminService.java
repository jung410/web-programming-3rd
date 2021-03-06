package com.ggv.admin.service;

import java.util.List;

import com.ggv.admin.domain.AdminResvVO;
import com.ggv.admin.domain.SalesVO;

public interface AdminService {
	public List<SalesVO> getSalesByMovie();
	
	public Long getTotalSales();
	
	public List<AdminResvVO> getAdminResv();
}
