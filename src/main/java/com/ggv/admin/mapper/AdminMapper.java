package com.ggv.admin.mapper;

import java.util.List;

import com.ggv.admin.domain.AdminResvVO;
import com.ggv.admin.domain.SalesVO;

public interface AdminMapper {
	public List<SalesVO> getSalesByMovie();
	
	public Long getTotalSales();
	
	public List<AdminResvVO> getAdminResv();
}
