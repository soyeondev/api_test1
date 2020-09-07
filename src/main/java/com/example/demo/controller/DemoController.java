package com.example.demo.controller;

import java.io.ByteArrayOutputStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.hello.HelloAnalyticsReporting;
import com.fasterxml.jackson.core.JsonFactory;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.api.services.analyticsreporting.v4.AnalyticsReporting;
import com.google.api.services.analyticsreporting.v4.model.GetReportsResponse;
import com.google.gson.JsonArray;

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
//	public ModelAndView chartjstest(@RequestParam String demen, @RequestParam String metr,
//			@RequestParam Date startDate, @RequestParam Date endDate) {
	//public ModelAndView chartjstest() {
		System.out.println(demen);
		System.out.println(metr);
		System.out.println(startDate);
		System.out.println(endDate);
		ModelAndView mav = new ModelAndView();
		HelloAnalyticsReporting har = new HelloAnalyticsReporting();
		
	    try {
	        AnalyticsReporting service = har.initializeAnalyticsReporting();
	        
	        List list = har.getReport(service, demen, metr, startDate, endDate);
	        GetReportsResponse response = (GetReportsResponse) list.get(0);
	        //String[] dateArr = new String[100];
	        //System.out.println(har.getReport(service, demen, metr, startDate, endDate).get(1));
	        har.printResponse(response);

	        /*ByteArrayOutputStream out = new ByteArrayOutputStream();
	        ObjectMapper mapper = new ObjectMapper();

	        mapper.writeValue(out, list.get(1));
	        
	        byte[] data = out.toByteArray();*/
	        
	        JSONArray json = new JSONArray(list.get(1).toString());
	        
	        mav.addObject("res", response);
	        mav.addObject("preDateArr", json);
	        
	      } catch (Exception e) {
	        e.printStackTrace();
	      }

	    mav.setViewName("chartjstest");
	    
	    return mav;
	}
	
	@RequestMapping("/charttest")
	public void charttest() {}
}
