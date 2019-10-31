package com.ggv.common.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ggv.movie.service.MovieService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class IndexController {
	@Setter
	@Autowired
	private MovieService service;
	
	@RequestMapping("/")
	public String index(Model model) {
		model.addAttribute("movieList", service.getList("movieChart"));
		log.info("index..");
		return "index";
	}
}
