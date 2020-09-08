package com.example.demo.hello;

import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;

import java.io.FileInputStream;
import java.io.IOException;
import java.security.GeneralSecurityException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.google.api.services.analyticsreporting.v4.AnalyticsReportingScopes;
import com.google.api.services.analyticsreporting.v4.AnalyticsReporting;

import com.google.api.services.analyticsreporting.v4.model.ColumnHeader;
import com.google.api.services.analyticsreporting.v4.model.DateRange;
import com.google.api.services.analyticsreporting.v4.model.DateRangeValues;
import com.google.api.services.analyticsreporting.v4.model.GetReportsRequest;
import com.google.api.services.analyticsreporting.v4.model.GetReportsResponse;
import com.google.api.services.analyticsreporting.v4.model.Metric;
import com.google.api.services.analyticsreporting.v4.model.Dimension;
import com.google.api.services.analyticsreporting.v4.model.MetricHeaderEntry;
import com.google.api.services.analyticsreporting.v4.model.Report;
import com.google.api.services.analyticsreporting.v4.model.ReportRequest;
import com.google.api.services.analyticsreporting.v4.model.ReportRow;
import com.google.api.services.analyticsreporting.v4.model.Segment;

public class HelloAnalyticsReporting3 {
  private static final String APPLICATION_NAME = "Hello Analytics Reporting";
  private static final JsonFactory JSON_FACTORY = JacksonFactory.getDefaultInstance();
  private static final String KEY_FILE_LOCATION = "C:\\keyfile/elite-coral-288101-af14671be629.json";
  private static final String VIEW_ID = "227801079";
  public static void main(String[] args) {
    try {
      AnalyticsReporting service = initializeAnalyticsReporting();
      
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  /**
   * Initializes an Analytics Reporting API V4 service object.
   *
   * @return An authorized Analytics Reporting API V4 service object.
   * @throws IOException
   * @throws GeneralSecurityException
   */
  public static AnalyticsReporting initializeAnalyticsReporting() throws GeneralSecurityException, IOException {

    HttpTransport httpTransport = GoogleNetHttpTransport.newTrustedTransport();
    GoogleCredential credential = GoogleCredential
        .fromStream(new FileInputStream(KEY_FILE_LOCATION))
        .createScoped(AnalyticsReportingScopes.all());

    // Construct the Analytics Reporting service object.
    return new AnalyticsReporting.Builder(httpTransport, JSON_FACTORY, credential)
        .setApplicationName(APPLICATION_NAME).build();
  }

  /**
   * Queries the Analytics Reporting API V4.
   *
   * @param service An authorized Analytics Reporting API V4 service object.
 * @param endDate 
 * @param startDate 
 * @param metr 
 * @param demen 
   * @return GetReportResponse The Analytics Reporting API V4 response.
   * @throws IOException
 * @throws ParseException 
   */
  //public static ArrayList getReport(AnalyticsReporting service, String demen, String metr, String startDate, String endDate) throws IOException, ParseException {
  public static ArrayList getReport(AnalyticsReporting service, String demen, String metr, String startDate, String endDate) throws IOException, ParseException {
	  
	ArrayList list = new ArrayList(); 
	  
	SimpleDateFormat preStartDate = new SimpleDateFormat("yyyy-MM-dd");
	Date postStartDate = preStartDate.parse(startDate);

	SimpleDateFormat preEndDate = new SimpleDateFormat("yyyy-MM-dd");
	Date postEndDate = preEndDate.parse(endDate);
	
	SimpleDateFormat jsonDateFormat = new SimpleDateFormat("yyyyMMdd");

	Calendar startC = Calendar.getInstance();
	Calendar endC = Calendar.getInstance();
	startC.setTime(postStartDate);
	endC.setTime(postEndDate);
	long diff = postEndDate.getTime() - postStartDate.getTime();
	long diffDay = (diff / (1000 * 60 * 60 * 24));
	
	List<String> arr = new ArrayList<String>();
	String strStart = jsonDateFormat.format(startC.getTime());
	arr.add(strStart);
	for(int i = 1; i < diffDay; i++) {
		startC.add(Calendar.DATE, 1);
		arr.add(jsonDateFormat.format(startC.getTime()).toString());
		
	}
	// Create the DateRange object.
    DateRange dateRange = new DateRange();
    dateRange.setStartDate(startDate);
    dateRange.setEndDate(endDate);

    // Create the Metrics object.
	/*
	 * Metric sessions = new Metric() .setExpression("ga:sessions")
	 * .setAlias("sessions");
	 */
    
    Metric users = new Metric()
            .setExpression("ga:users")
            .setAlias("users");
    
    Dimension date = new Dimension()
    		.setName("ga:date");
    
	/*
	 * Dimension userType = new Dimension() .setName("ga:userType");
	 */
    
	/*
	 * Segment reUser = new Segment() .setSegmentId("ga:userType");
	 */
	
	/*
	Dimension pageTitle = new Dimension() .setName("ga:pageTitle");
	*/
    
    // Create the ReportRequest object.
    ReportRequest request = new ReportRequest()
        .setViewId(VIEW_ID)
        .setDateRanges(Arrays.asList(dateRange))
        .setMetrics(Arrays.asList(users))
        .setDimensions(Arrays.asList(date));

    ArrayList<ReportRequest> requests = new ArrayList<ReportRequest>();
    requests.add(request);

    // Create the GetReportsRequest object.
    GetReportsRequest getReport = new GetReportsRequest()
        .setReportRequests(requests);

    // Call the batchGet method.
    GetReportsResponse response = service.reports().batchGet(getReport).execute();

    list.add(response);
    list.add(arr);
    System.out.println(list);
    // Return the response.
    return list;
  }

  /**
   * Parses and prints the Analytics Reporting API V4 response.
   *
   * @param response An Analytics Reporting API V4 response.
   */
  public static void printResponse(GetReportsResponse response) {
    for (Report report: response.getReports()) {
      ColumnHeader header = report.getColumnHeader();
      List<String> dimensionHeaders = header.getDimensions();
      List<MetricHeaderEntry> metricHeaders = header.getMetricHeader().getMetricHeaderEntries();
      List<ReportRow> rows = report.getData().getRows();

      if (rows == null) {
         System.out.println("No data found for " + VIEW_ID);
         return;
      }

      System.out.println(response);

      for (ReportRow row: rows) {
        List<String> dimensions = row.getDimensions();
        List<DateRangeValues> metrics = row.getMetrics();

        for (int i = 0; i < dimensionHeaders.size() && i < dimensions.size(); i++) {
          //System.out.println(dimensionHeaders.get(i) + ": " + dimensions.get(i));
       	}

        for (int j = 0; j < metrics.size(); j++) {
          //System.out.print("Date Range (" + j + "): ");
          DateRangeValues values = metrics.get(j);
          for (int k = 0; k < values.getValues().size() && k < metricHeaders.size(); k++) {
            //System.out.println(metricHeaders.get(k).getName() + ": " + values.getValues().get(k));
          }
        }
      }
      
    }
  }
}
