package com.example.demo.controller;

import java.util.List;

import org.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.hello.HelloAnalyticsReporting;
import com.google.api.services.analyticsreporting.v4.AnalyticsReporting;
import com.google.api.services.analyticsreporting.v4.model.GetReportsResponse;

@Controller
public class DemoController {
	@RequestMapping("/reporting")
	public void reporting() {}
	
	@RequestMapping("/embed")
	public void embed() {}
	
	@RequestMapping("/queryform")
	public void queryform() {}
	
	@RequestMapping("/charttest")
	public void charttest() {}
	
	@RequestMapping(value="/chartjstest", method=RequestMethod.POST)
	public ModelAndView chartjstest(@RequestParam String startDate, @RequestParam String endDate) {
		ModelAndView mav = new ModelAndView();
		HelloAnalyticsReporting har = new HelloAnalyticsReporting();
		
	    try {
	        AnalyticsReporting service = har.initializeAnalyticsReporting();
	        
	        List list = har.getReport(service, startDate, endDate);
	        GetReportsResponse response = (GetReportsResponse) list.get(0);
	        har.printResponse(response);

	        JSONArray json = new JSONArray(list.get(1).toString());
	        String re_user_map = (String) list.get(2);
	        String new_user_map = (String) list.get(3);
	        
	        mav.addObject("res", response);
	        mav.addObject("preDateArr", json);
	        mav.addObject("reUserMap", re_user_map);
	        mav.addObject("newUserMap", new_user_map);
	        
	      } catch (Exception e) {
	        e.printStackTrace();
	      }

	    mav.setViewName("chartjstest");
	    
	    return mav;
	}

}
