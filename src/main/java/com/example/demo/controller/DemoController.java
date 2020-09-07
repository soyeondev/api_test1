package com.example.demo.controller;

import java.util.Calendar;
import java.util.Date;
import java.util.Map;

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
	
	@RequestMapping(value="/chartjstest", method=RequestMethod.POST)
	//@RequestMapping(value="/chartjstest")
	public ModelAndView chartjstest(@RequestParam String demen, @RequestParam String metr,
			@RequestParam String startDate, @RequestParam String endDate) {
	//public ModelAndView chartjstest() {
		System.out.println(demen);
		System.out.println(metr);
		System.out.println(startDate);
		System.out.println(endDate);
		ModelAndView mav = new ModelAndView();
		HelloAnalyticsReporting har = new HelloAnalyticsReporting();
		Map<String, Object> map = null;
		
	    try {
	        AnalyticsReporting service = har.initializeAnalyticsReporting();
	        
	        GetReportsResponse response = (GetReportsResponse) har.getReport(service, demen, metr, startDate, endDate).get(0);
	        //Calendar[] dateArr = new Calendar[100];
	        Object dateArr = har.getReport(service, demen, metr, startDate, endDate).get(1);
	        System.out.println(har.getReport(service, demen, metr, startDate, endDate).get(1));
	        har.printResponse(response);
	        mav.addObject("res", response);
	        mav.addObject("dateArr", dateArr);
	        
	      } catch (Exception e) {
	        e.printStackTrace();
	      }

	    mav.setViewName("chartjstest");
	    
	    return mav;
	}
	
	@RequestMapping("/charttest")
	public void charttest() {}
}
