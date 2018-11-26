package edu.asu.controller;

import java.util.Map;

import org.json.simple.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.json.simple.JSONObject;

import javax.servlet.http.HttpServletRequest;


@Controller
public class HomeController {

	@RequestMapping(value={"", "/", "/home"})
	public String welcome(Map<String, Object> model) {
		return "welcome";
	}
	@RequestMapping("/login")
	public String search(Map<String, Object> model) {
		return "login";
	}

	@RequestMapping("/visualization")
	public String queryResults(HttpServletRequest request, Map<String, Object> model) {
        JSONObject json = new JSONObject();
        JSONArray array = new JSONArray();
        JSONObject item = new JSONObject();
        item.put("skill1","9");
        item.put("skill2", "3");
		item.put("skill3", "8");
        array.add(item);
        System.out.println(array);
        model.put("res",item);
        return "visualization";
    }

	@RequestMapping("/summary")
	public String searchResults(HttpServletRequest request, Map<String, Object> model) {
		JSONObject json = new JSONObject();
		JSONArray array = new JSONArray();
		JSONObject item = new JSONObject();
		item.put("skill1","60");
		item.put("skill2", "30");
		item.put("skill3", "10");
		array.add(item);
		System.out.println(array);
		model.put("res",item);
		return "summary";
	}
}
