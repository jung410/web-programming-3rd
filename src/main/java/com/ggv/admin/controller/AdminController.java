package com.ggv.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ggv.admin.service.AdminService;
import com.ggv.member.controller.MemberController;
import com.ggv.member.service.MemberService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/*")
public class AdminController {
	@Setter
	@Autowired
	private MemberService service;
	@Setter @Autowired
	private AdminService adminService;
	
	@GetMapping("/sales")
	public String sales(Model model) {
		model.addAttribute("salesList", adminService.getSalesByMovie());
		model.addAttribute("totalSales", adminService.getTotalSales());
		return "admin/adminPageSales";
	}
	
	@GetMapping("/resv")
	public String resv(Model model) {
		model.addAttribute("resvList", adminService.getAdminResv());
		return "admin/adminPageResv";
	}
	
	@GetMapping("/users")
	public String users(Model model) {
		model.addAttribute("memberList", service.getMemberList());
		return "admin/adminPageUsers";
	}
}
