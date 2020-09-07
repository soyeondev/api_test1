<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
  <title>Embed API Demo</title>
    <meta charset="utf-8">
  <title>Hello Analytics Reporting API V4</title>
  <meta name="google-signin-client_id" content="808706814285-f44ev80ictroiiarr65q4mj299pin69c.apps.googleusercontent.com">
  <meta name="google-signin-scope" content="https://www.googleapis.com/auth/analytics.readonly">
</head>
<body>

<!-- Step 1: Create the containing elements. -->

<section id="auth-button"></section>
<section id="view-selector"></section>
<section id="timeline"></section>
<section id="timeline_user"></section>
New Visitor: <input id="new_user"/>
Returning Visitor: <input id="return_user"/>
percent: <input id="percent"/>

<!-- Step 2: Load the library. -->

<script>
(function(w,d,s,g,js,fjs){
  g=w.gapi||(w.gapi={});g.analytics={q:[],ready:function(cb){this.q.push(cb)}};
  js=d.createElement(s);fjs=d.getElementsByTagName(s)[0];
  js.src='https://apis.google.com/js/platform.js';
  fjs.parentNode.insertBefore(js,fjs);js.onload=function(){g.load('analytics')};
}(window,document,'script'));
</script>
<script>
gapi.analytics.ready(function() {

  // Step 3: Authorize the user.

  var CLIENT_ID = '808706814285-f44ev80ictroiiarr65q4mj299pin69c.apps.googleusercontent.com';

  gapi.analytics.auth.authorize({
    container: 'auth-button',
    clientid: CLIENT_ID,
  });

  // Step 4: Create the view selector.

  var viewSelector = new gapi.analytics.ViewSelector({
    container: 'view-selector'
  });

  // Step 5: Create the timeline chart.

  var timeline = new gapi.analytics.googleCharts.DataChart({
    reportType: 'ga',
    query: {
      'dimensions': 'ga:date',
      'metrics': 'ga:sessions',
      'start-date': '30daysAgo',
      'end-date': 'today',
    },
    chart: {
      type: 'LINE',
      container: 'timeline'
    }
  });

  var timeline_user = new gapi.analytics.googleCharts.DataChart({
    reportType: 'ga',
    query: {
      'dimensions': 'ga:userType',
      'metrics': 'ga:users',
      'start-date': '30daysAgo',
      'end-date': 'today',
    },
    chart: {
      type: 'PIE',
      container: 'timeline_user'
    }
  });
  // Step 6: Hook up the components to work together.

  gapi.analytics.auth.on('success', function(response) {
    viewSelector.execute();
  });

  viewSelector.on('change', function(ids) {
    var newIds = {
      query: {
        ids: ids
      }
    }
    timeline.set(newIds).execute();
    timeline_user.set(newIds).execute();
  });
});
</script>

<p class="g-signin2" data-onsuccess="queryReports"></p>

<!-- The API response will be printed here. -->
<textarea cols="80" rows="20" id="query-output"></textarea>

<script>
  // Replace with your view ID.
  var VIEW_ID = '129913980';

  // Query the API and print the results to the page.
  function queryReports() {
    gapi.client.request({
      path: '/v4/reports:batchGet',
      root: 'https://analyticsreporting.googleapis.com/',
      method: 'POST',
      body: {
        reportRequests: [
          {
            viewId: VIEW_ID,
            dateRanges: [
              {
                startDate: '30daysAgo',
                endDate: 'today'
              }
            ],
            metrics: [
              /* {
                expression: 'ga:sessions'
              }, */
              {
                expression: 'ga:users'
              }
            ],
            dimensions: [
            	/* {
	            	name: 'ga:userType'        		
            	} */
            	{
            		name: 'ga:date'
            	}
             ]
          }
        ]
      }
    }).then(displayResults, console.error.bind(console));
  }

  function displayResults(response) {
    var formattedJson = JSON.stringify(response.result, null, 2);
    const json = '{"result":true, "count":42}';
    console.log(response);
    console.log(formattedJson);
    //console.log(response.result.reports[0].data.rows[0].metrics.values());

    var preNewVisitor = response.result.reports[0].data.rows[0].metrics.values();
    var preReVisitor = response.result.reports[0].data.rows[1].metrics.values();
    
    var newVisitor = 0;
    var reVisitor = 0;
    
    for(var value of preNewVisitor) {
    	newVisitor = value.values[0];
    }
    
    for(var value of preReVisitor) {
    	reVisitor = value.values[0];
    }

    var percent = reVisitor / (newVisitor+reVisitor)*100;
    
    document.getElementById('query-output').value = formattedJson;
    document.getElementById('new_user').value = newVisitor;
    document.getElementById('return_user').value = reVisitor;
    document.getElementById('percent').value = percent;
  }
</script>

<!-- Load the JavaScript API client and Sign-in library. -->
<script src="https://apis.google.com/js/client:platform.js"></script>



</body>
</html>