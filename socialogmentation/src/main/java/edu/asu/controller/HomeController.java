package edu.asu.controller;

import java.util.Map;

import org.json.simple.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.json.simple.JSONObject;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;


@Controller
public class HomeController {

	String username="error";

	@RequestMapping(value={"", "/", "/home"})
	public String welcome(Map<String, Object> model, @RequestParam(value = "username", required = false) String username) {
		if(username!=null || username!="") {
			this.username=username;
		}
		model.put("username", this.username);
		return "welcome";
	}

	@RequestMapping("/login")
	public String search(Map<String, Object> model) {
		model.put("username", this.username);
		return "login";
	}

	@RequestMapping("/visualization")
	public String queryResults(HttpServletRequest request, Map<String, Object> model) {
		model.put("username", this.username);
        return "visualization";
    }

	@RequestMapping("/summary")
	public String searchResults(HttpServletRequest request, Map<String, Object> model) {
		model.put("username", this.username);
		return "summary";
	}

	@RequestMapping("/recommend")
	public String recommendResults(HttpServletRequest request, Map<String, Object> model) {
		model.put("username", this.username);
		return "recommend";
	}
}
